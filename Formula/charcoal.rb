class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.9"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.9/ch-macos-arm64"
      sha256 "6cd0a0c031b992e22fea1dc229255bd57f00f291a60a3cbace9e074eca667db1"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.9/ch-macos-x64"
      sha256 "881b532b1d4f1de4b4b460334a2553aced3adf3228ebc997fe7ec0f1889aca67"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.9/ch-linux"
    sha256 "b64b74dac0021589cf607a3e8f0798b280afdc32b3f34cf046aaa44fe635c93b"
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
