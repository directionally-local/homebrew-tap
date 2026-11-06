class Autopilot < Formula
  desc "Terminal coding agent for any model provider, with your own key"
  homepage "https://github.com/directionally-local/autopilot"
  url "https://registry.npmjs.org/autopilot-ai/-/autopilot-ai-3.14.0.tgz"
  sha256 "f2ab725fb664a84699ebfca0b0fbf03ce33b713ab6e7883f882a5bd6eba14165"
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
