class PhiloticWeb < Formula
  desc "Operator CLI for managing a Philotic Web — a mesh of aiua nodes"
  homepage "https://github.com/likesjx/philotic-stack"
  # Populated by release automation — do not edit manually
  url "https://github.com/likesjx/philotic-stack/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  head "https://github.com/likesjx/philotic-stack.git", branch: "main"

  bottle do
    # Bottles built and uploaded by CI on release
    # root_url "https://github.com/likesjx/philotic-stack/releases/download/v0.1.0"
  end

  depends_on "rust" => :build
  depends_on "jaredlikes/philotic/aiua"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/philotic-web")
  end

  def caveats
    <<~EOS
      philotic-web is the operator CLI for the Philotic Web.

      Quick start — bootstrap a local node:
        philotic-web init
        philotic-web start

      Inspect the mesh:
        philotic-web status
        philotic-web mesh nodes

      Manage a remote node:
        philotic-web --node <hostname> guests list

      For full documentation:
        https://github.com/likesjx/philotic-stack
    EOS
  end

  test do
    assert_match "philotic-web", shell_output("#{bin}/philotic-web --version 2>&1")
  end
end
