class Autopilot < Formula
  desc "Terminal coding agent for any model provider, with your own key"
  homepage "https://github.com/directionally-local/autopilot"
  url "https://registry.npmjs.org/autopilot-ai/-/autopilot-ai-3.1.2.tgz"
  sha256 "8046c5202e87209065e715456eba831c43c5e2e202733c5ac728478ea9511017"
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
