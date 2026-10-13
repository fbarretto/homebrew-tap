class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.8"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.8/ch-macos-arm64"
      sha256 "1e77c71e5ce4b3c66e35fdfef59b076a83085909e092355d03f4fe8eb8c681a5"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.8/ch-macos-x64"
      sha256 "4165b39a1686e54de628e6e5f294e02a0e021b00c5aa307cb963e43fe9a64df3"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.8/ch-linux"
    sha256 "63eaaca9a5c6a9783fa004e869edccdadefe1c47703413b0a080097c54a9e1da"
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
