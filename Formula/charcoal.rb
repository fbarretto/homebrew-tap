class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.6"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.6/ch-macos-arm64"
      sha256 "0e279c066206e3275da74e6586a6bfe1502b4dd245eb37271db1ee8d878c2a85"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.6/ch-macos-x64"
      sha256 "a1baf2939c6621f2949c12eaeb104e7135e68010632bb47c2a18f70af018a7f4"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.6/ch-linux"
    sha256 "033a18eb8c5973dd66319711cd4d0d856ddbde03013fc71ceff236fbdb346ea8"
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
