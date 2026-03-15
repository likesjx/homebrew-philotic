class Aiua < Formula
  desc "Hotel daemon for the Philotic Web — materializes and supervises AI agents (philotes)"
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

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/aiua")
  end

  service do
    run [opt_bin/"aiua", "--load-config", etc/"philotic/mesh-config.json"]
    keep_alive true
    log_path var/"log/aiua.log"
    error_log_path var/"log/aiua.log"
    working_dir var/"philotic"
  end

  def post_install
    (var/"philotic").mkpath
    (etc/"philotic").mkpath
  end

  def caveats
    <<~EOS
      aiua is the hotel daemon for the Philotic Web.

      Before starting, create a config file at:
        #{etc}/philotic/mesh-config.json

      Copy the example config from the source repo:
        cp #{HOMEBREW_PREFIX}/share/philotic/mesh-config.example.json \\
           #{etc}/philotic/mesh-config.json

      Start the hotel daemon:
        aiua --hotel <name> --load-config #{etc}/philotic/mesh-config.json

      Or manage it via the Philotic Web CLI:
        brew install jaredlikes/philotic/philotic-web
        philotic-web start
    EOS
  end

  test do
    assert_match "aiua", shell_output("#{bin}/aiua --version 2>&1")
  end
end
