class PhiloticWeb < Formula
  desc "Operator CLI for managing a Philotic Stack — hotel daemon + agents"
  homepage "https://github.com/likesjx/philotic-stack"
  url "https://github.com/likesjx/philotic-stack/archive/refs/tags/v0.1.0-alpha.tar.gz"
  sha256 "ac5fffa93c09a209caf651a8bd691a0c3187d3dd961d1c8baf57beca5639aab4"
  version "0.1.0-alpha"
  license "MIT"
  head "https://github.com/likesjx/philotic-stack.git", branch: "develop"

  depends_on "rust" => :build
  depends_on "likesjx/philotic/aiua"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/philotic-web")
  end

  def caveats
    <<~EOS
      phil is the operator CLI for the Philotic Stack.

      Quick start:
        phil init      # generate identity keypair + mesh-config.json
        phil start     # start the hotel daemon (materializes all agents)
        phil status    # check running agents
        phil agents    # list configured agents
    EOS
  end

  test do
    assert_match "philotic-web", shell_output("#{bin}/philotic-web --version 2>&1")
  end
end