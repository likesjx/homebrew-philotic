class Aiua < Formula
  desc "Hotel daemon for the Philotic Stack — materializes and supervises AI agents"
  homepage "https://github.com/likesjx/philotic-stack"
  url "https://github.com/likesjx/philotic-stack/archive/refs/tags/v0.1.0-alpha.tar.gz"
  sha256 "541933ff60f85fc44d82ed7bd8bf7a78e4d9edc41de125dbbbb5c104db98b1e1"
  version "0.1.0-alpha"
  license "MIT"
  head "https://github.com/likesjx/philotic-stack.git", branch: "develop"

  depends_on "rust" => :build
  depends_on "muninn"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/aiua")
    system "cargo", "install", *std_cargo_args(path: "crates/membrane")
    system "cargo", "install", *std_cargo_args(path: "crates/philote")
    system "cargo", "install", *std_cargo_args(path: "crates/model-router")
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
