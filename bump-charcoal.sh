#!/usr/bin/env bash
# Regenerates Formula/charcoal.rb for a published fbarretto/charcoal release.
# Usage: ./bump-charcoal.sh 1.1.0
set -euo pipefail

version="${1:?usage: $0 <version, e.g. 1.1.0>}"
base="https://github.com/fbarretto/charcoal/releases/download/v${version}"

sha() { curl -fsSL "${base}/$1" | shasum -a 256 | cut -d' ' -f1; }
arm=$(sha ch-macos-arm64)
x64=$(sha ch-macos-x64)
linux=$(sha ch-linux)

mkdir -p Formula
cat > Formula/charcoal.rb <<EOF
class Charcoal < Formula
  desc "Stacked-PR CLI with Graphite-compatible commands (fork of danerwilliams/charcoal)"
  homepage "https://github.com/fbarretto/charcoal"
  version "${version}"
  license "AGPL-3.0-only"

  depends_on "gh"
  depends_on "git-absorb" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "${base}/ch-macos-arm64"
      sha256 "${arm}"
    else
      url "${base}/ch-macos-x64"
      sha256 "${x64}"
    end
  end

  on_linux do
    url "${base}/ch-linux"
    sha256 "${linux}"
  end

  def install
    bin.install Dir["ch-*"].first => "ch"
  end

  def caveats
    <<~EOS
      Charcoal installs the \`ch\` command. Commands and flags match Graphite's \`gt\`.
      Run \`ch auth\` once (uses your gh login), then \`ch init\` in each repo.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ch --version")
  end
end
EOF
echo "Formula/charcoal.rb -> v${version}"
