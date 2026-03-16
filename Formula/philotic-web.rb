class PhiloticWeb < Formula
  desc "Operator CLI for managing a Philotic Stack — hotel daemon + agents"
  homepage "https://github.com/likesjx/philotic-stack"
  url "https://github.com/likesjx/philotic-stack/archive/refs/tags/v0.1.0-alpha.tar.gz"
  sha256 "10def55f06c95a6a05554d2fe50433901d4b9188a2dd279447f0afb073044750"
  version "0.1.0-alpha"
  license "MIT"
  head "https://github.com/likesjx/philotic-stack.git", branch: "develop"

  depends_on "rust" => :build
  depends_on "just"
  depends_on "aiua"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/philotic-web")
    bin.install_symlink bin/"philotic-web" => "phil"
  end

  def caveats
    <<~EOS
      philotic-web is installed as both `philotic-web` and `phil`.

      Quick start:
        phil init      # generate identity keypair + mesh-config.json
        phil start     # start the hotel daemon (materializes all agents)
        phil status    # check running agents
        phil agents    # list configured agents
    EOS
  end

  test do
    assert_match "philotic-web", shell_output("#{bin}/philotic-web --version 2>&1")
    assert_match "philotic-web", shell_output("#{bin}/phil --version 2>&1")
  end
end