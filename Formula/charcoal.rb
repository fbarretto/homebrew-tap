class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.1"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.1/ch-macos-arm64"
      sha256 "73740f20fccd83576e976fd5639aa4845ae03747e94fb3bf3cee06c582859509"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.1/ch-macos-x64"
      sha256 "8d68351959b606a1d6fb9ccce5022ac61ddda904ff31fbf69b3c85903bcb3633"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.1/ch-linux"
    sha256 "02ab0193f1de4e513f7b6f7dffcbc30bd5f95fd4465df8f5bb1e318bee01aaa0"
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
