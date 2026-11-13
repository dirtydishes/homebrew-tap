class GhForgejoShim < Formula
  desc "GitHub CLI compatibility shim for Forgejo repositories"
  homepage "https://github.com/dirtydishes/gh-forgejo-shim"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "e6fc67e4eca8bcd2e55048d7fd08da375ac99b6a51a963753f3e6855d111ce84"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "9ef4b55e8f94a3ae169db5766573547bfe2e45cfa0d17e46eb1137140a6045ca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6cb110b7134d6b320d4e98e055dc5a700796543796425e55c8d7ffd0294ca6c2"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1fd627a1e4e91327be75c96ca12bfc2cdca21c583dcf461ff0535ce5aa22a602"
    end
  end

  depends_on "gh"

  def install
    bin.install "gh-forgejo-shim"
    bin.install "gfj"
  end

  def caveats
    <<~EOS
      gh-forgejo-shim needs GitHub CLI 2.103.3 or newer, which Homebrew installs
      as a dependency. After installing or upgrading, run this from inside your
      Forgejo checkout to set up or refresh the managed gh wrapper:
        gfj bootstrap

      It sends one anonymous usage report a day: the version, OS, agent and forge
      software, never hosts, repositories or commands. `gfj telemetry show` prints
      it, and `gfj telemetry off` stops it. See docs/telemetry.md in the repository.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gfj --version")
    assert_match "doctor", shell_output("#{bin}/gh-forgejo-shim --help")
  end
end
