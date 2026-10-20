class Autopilot < Formula
  desc "Terminal coding agent for OpenRouter models"
  homepage "https://github.com/sinameraji/autopilot"
  url "https://registry.npmjs.org/autopilot-ai/-/autopilot-ai-1.30.0.tgz"
  sha256 "e6e08ad4719c3690adf98264ed60b5945977d8800fd6af63fc71ee0c69d6efb6"
  license "MIT"

  depends_on "node@22"

  def install
    node_bin = formula_opt_bin("node@22")
    system node_bin/"npm", "install", "--global", "--prefix", libexec,
           "--omit=dev", "--no-audit", "--no-fund", cached_download

    (bin/"autopilot").write_env_script libexec/"bin/autopilot", PATH: node_bin
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/autopilot --help")
  end
end
