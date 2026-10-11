class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.3"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.3/ch-macos-arm64"
      sha256 "e3a893c1b1dc47c6f2f5d460c5e8a6ba9b3b0fed1b60f72b9b1a656038460804"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.3/ch-macos-x64"
      sha256 "3a6edee8a13310cec5d1ae8519c61491e7ab8304426ebacf1368e71033f9251d"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.3/ch-linux"
    sha256 "8e82b3b8bd5ac7896096e4d426499eabbb7d152e3e594006884db860416d0ca1"
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
