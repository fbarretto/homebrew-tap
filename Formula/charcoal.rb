class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.10"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.10/ch-macos-arm64"
      sha256 "1ec8d55c42a8021ae867ceb6c8a83dae44b03292ce4ef02f645d8440e81fffb3"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.10/ch-macos-x64"
      sha256 "b86c313eed2783925f6398ffaee76d024beaf3e199f7ad31d4e4c06f9a49962e"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.10/ch-linux"
    sha256 "7299b373b576fd5bb56a906a4ed21fe0f08542593f418f55e2be3fb77aef4e1b"
  end

  def install
    bin.install Dir["ch-*"].first => "ch"
  end

  def caveats
    <<~EOS
      Charcoal installs the `ch` command. Commands and flags match Graphite's `gt`.
      Run `ch auth` once (uses your gh login), then `ch init` in each repo.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ch --version")
  end
end
