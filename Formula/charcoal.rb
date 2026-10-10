class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.2"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.2/ch-macos-arm64"
      sha256 "a86d8bb3430b6c604cd8e254d23fbf7a393b3da4fe3c191094788b7b3cd1ad5a"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.2/ch-macos-x64"
      sha256 "a7ac94c7803c90a284f09eda5a357a8dfbe03b3b6aaf576e85d72c5e6484fbef"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.2/ch-linux"
    sha256 "b959a2f3cbf0f496f35591b1077b703b279625840d26daca39ffeb9efbcd244c"
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
