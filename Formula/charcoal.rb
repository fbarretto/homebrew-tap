class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "1.1.0"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.0/ch-macos-arm64"
      sha256 "2f6f5db1cad9cf7a6b56479375e0c45c2bb7ef53ba9a28ab32bdadd04e8f74ce"
    else
      url "https://github.com/fbarretto/charcoal/releases/download/v1.1.0/ch-macos-x64"
      sha256 "74baa875def3004546557155ec4fb0e5e2bb92bf29f2aac5c01ecc80b699798f"
    end
  end

  on_linux do
    url "https://github.com/fbarretto/charcoal/releases/download/v1.1.0/ch-linux"
    sha256 "817c5f914bfe4ad6b04dc2a04f8853f40b2355e8b54a4fc744e82b3c69c99dd5"
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
