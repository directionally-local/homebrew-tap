import { createHash } from "node:crypto";
import { readFile, writeFile } from "node:fs/promises";

const metadataUrl = "https://registry.npmjs.org/autopilot-ai/latest";
const metadataResponse = await fetch(metadataUrl);
if (!metadataResponse.ok) {
  throw new Error(`npm registry returned ${metadataResponse.status} for ${metadataUrl}`);
}

const metadata = await metadataResponse.json();
const version = metadata.version;
const expectedTarball = `https://registry.npmjs.org/autopilot-ai/-/autopilot-ai-${version}.tgz`;
if (!/^\d+\.\d+\.\d+(?:-[\w.-]+)?$/.test(version) || metadata.dist?.tarball !== expectedTarball) {
  throw new Error(`Unexpected npm metadata for autopilot-ai@${version}`);
}

const tarballResponse = await fetch(expectedTarball);
if (!tarballResponse.ok || !tarballResponse.body) {
  throw new Error(`Could not download ${expectedTarball}: HTTP ${tarballResponse.status}`);
}

const hash = createHash("sha256");
for await (const chunk of tarballResponse.body) hash.update(chunk);
const sha256 = hash.digest("hex");

const formulaPath = new URL("../Formula/autopilot.rb", import.meta.url);
const formula = await readFile(formulaPath, "utf8");
const urlPattern = /^  url "https:\/\/registry\.npmjs\.org\/autopilot-ai\/-\/autopilot-ai-[^"]+\.tgz"$/m;
const shaPattern = /^  sha256 "[a-f0-9]{64}"$/m;
if (!urlPattern.test(formula) || !shaPattern.test(formula)) {
  throw new Error("Could not find exactly the expected URL and SHA-256 fields in Formula/autopilot.rb");
}

const updated = formula
  .replace(urlPattern, `  url "${expectedTarball}"`)
  .replace(shaPattern, `  sha256 "${sha256}"`);
if (updated !== formula) {
  await writeFile(formulaPath, updated);
  console.log(`Updated Homebrew formula to autopilot-ai@${version}`);
} else {
  console.log(`Homebrew formula is already current at autopilot-ai@${version}`);
}
