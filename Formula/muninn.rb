class Muninn < Formula
  desc "Cognitive memory store with Ebbinghaus decay, Hebbian learning, and MCP/REST access"
  homepage "https://github.com/scrypster/muninndb"
  version "0.4.3-alpha"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/scrypster/muninndb/releases/download/v0.4.3-alpha/muninn_v0.4.3-alpha_darwin_arm64.tar.gz"
      sha256 "5b62963200ef599e40eba6e349395e1f50c88e6375d66a71a4c82d7ef81c0304"
    end
    on_intel do
      url "https://github.com/scrypster/muninndb/releases/download/v0.4.3-alpha/muninn_v0.4.3-alpha_darwin_amd64.tar.gz"
      sha256 "a26ef90e1eac50425afc782d7afd0667f44c53b9ed11796cde24acf5e703aef9"
    end
  end

  def install
    bin.install "muninn"
  end

  def caveats
    <<~EOS
      muninn manages its own background daemon. To start it:
        muninn init    # first-time setup
        muninn start   # start the daemon

      Ports:
        :8475  REST API
        :8750  MCP (AI tool integration)
        :8476  Web dashboard — http://127.0.0.1:8476
    EOS
  end

  test do
    assert_match "muninn", shell_output("#{bin}/muninn --help 2>&1")
  end
end