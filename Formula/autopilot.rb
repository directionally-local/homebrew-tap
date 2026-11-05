class Autopilot < Formula
  desc "Terminal coding agent for any model provider, with your own key"
  homepage "https://github.com/directionally-local/autopilot"
  url "https://registry.npmjs.org/autopilot-ai/-/autopilot-ai-3.13.0.tgz"
  sha256 "d3a982b465e7098ef2ee6afa036c4497e9786a3a7ac224672e35f10b59cf948d"
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
