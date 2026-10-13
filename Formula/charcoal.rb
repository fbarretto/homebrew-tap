class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.11"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.11/ch-macos-arm64"
      sha256 "514afa3959373142787d8e67b730b6084943b46d50daf8f61a0372fc43b2be10"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.11/ch-macos-x64"
      sha256 "7f1515526c8d466befd623b39207e9200998342a54ee71b8a3f5e0c8181c5022"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.11/ch-linux"
    sha256 "80ecd79077dddc5022d860aa93fd73097dc52426bd345de1f207b6b748b4572c"
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
