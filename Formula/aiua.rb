class Aiua < Formula
  desc "Hotel daemon for the Philotic Stack — materializes and supervises AI agents"
  homepage "https://github.com/likesjx/philotic-stack"
  url "https://github.com/likesjx/philotic-stack/archive/refs/tags/v0.1.0-alpha.tar.gz"
  sha256 "25d278c35dd8164e80d94c8461f86d13a961f57a9ae95e8cf4591932f05807ab"
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
    system "cargo", "install", *std_cargo_args(path: "crates/graph-runner")
    system "cargo", "install", *std_cargo_args(path: "crates/tool-runner")
    system "cargo", "install", *std_cargo_args(path: "crates/onnx-runner")
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
