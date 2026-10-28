class Autopilot < Formula
  desc "Terminal coding agent for any model provider, with your own key"
  homepage "https://github.com/directionally-local/autopilot"
  url "https://registry.npmjs.org/autopilot-ai/-/autopilot-ai-2.4.4.tgz"
  sha256 "6dbec1c522973b83a54faf8c32e8668ac2b3f7c13cc12ede7d96a1745fdbaa57"
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
