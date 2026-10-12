class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.7"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.7/ch-macos-arm64"
      sha256 "c76e9f958a532df8d9d0d23f2b0c9c42eb62d0a4bb766a5e1596d5f3dbdf4079"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.7/ch-macos-x64"
      sha256 "e48e08c90433f9d92e79e21bcf2872852e7cde9783f69cf0225cd702b6bdddad"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.7/ch-linux"
    sha256 "97025ad838bf88fd0fdf6811dda208d0c7e4229013ccc5bf76031a87b15cda7c"
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
