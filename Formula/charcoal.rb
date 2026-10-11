class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.4"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.4/ch-macos-arm64"
      sha256 "2497b4483613edcbca6533ac87aec8b47ff7b2bee664b6fb45ca635b2e2c7338"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.4/ch-macos-x64"
      sha256 "b1032c2c690afd8650dd8a26e5a081de23b67c8568bfe355b92108be8eac58ee"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.4/ch-linux"
    sha256 "8853c5d3a012c848bcf3128ad502712be5b019b7280c28e2b56f02d38d8cf08b"
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
