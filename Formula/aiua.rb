class Aiua < Formula
  desc "Hotel daemon for the Philotic Stack — materializes and supervises AI agents"
  homepage "https://github.com/likesjx/philotic-stack"
  url "https://github.com/likesjx/philotic-stack/archive/refs/tags/v0.1.0-alpha.tar.gz"
  sha256 "902c433755817b4b0bbbc121503cd53993d9eb0644234acd92fbe63d088162dd"
  version "0.1.0-alpha"
  license "MIT"
  head "https://github.com/likesjx/philotic-stack.git", branch: "develop"

  depends_on "rust" => :build
  depends_on "muninn"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/aiua")
  end

  def post_install
    (var/"philotic").mkpath
    (etc/"philotic").mkpath
  end

  def caveats
    <<~EOS
      aiua is the hotel daemon for the Philotic Stack.

      Managed via the phil CLI:
        brew install likesjx/philotic/philotic-web
        phil init
        phil start
    EOS
  end

  test do
    assert_match "aiua", shell_output("#{bin}/aiua --version 2>&1")
  end
end