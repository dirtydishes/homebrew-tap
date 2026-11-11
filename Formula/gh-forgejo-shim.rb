class GhForgejoShim < Formula
  desc "GitHub CLI compatibility shim for Forgejo repositories"
  homepage "https://github.com/dirtydishes/gh-forgejo-shim"
  version "0.5.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "83aabdcc6e331070560f045ea6b631cb83efa41a4617c2578a23aab0990c4c93"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "ca014d97bd0595b9aea0e55ce66323c92442c3c711b86ddeaaa5f6cbac60dd11"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "652b7eabd98a2286898d73656b7f2114595cbc397491883b477974744b1ec3eb"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dd10716100dd70d4ecac838d41323708c56e7baccee9cf8943b8c2a50e1960b6"
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
