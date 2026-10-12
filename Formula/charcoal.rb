class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.5"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.5/ch-macos-arm64"
      sha256 "7bef72f9acf26351426ed58137c00fe63e3a19a160c7bc3f44dfd17894d66f47"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.5/ch-macos-x64"
      sha256 "6bb20bedf5ff076a9896105d8fe598fbae4935dd6feb49e1dca532569aa96431"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.5/ch-linux"
    sha256 "247491c1c0255afa7ce4c119fb2302e7c7dd1407aa9cd13a66f6e73d29309ae9"
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
