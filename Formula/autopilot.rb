class Autopilot < Formula
  desc "Terminal coding agent for OpenRouter models"
  homepage "https://github.com/sinameraji/autopilot"
  url "https://registry.npmjs.org/autopilot-ai/-/autopilot-ai-1.22.2.tgz"
  sha256 "197b53a98221c5525fc3452c1e5d442e2a5ebf0a4541876700f25bd243623df5"
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
