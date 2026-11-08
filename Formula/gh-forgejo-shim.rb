class GhForgejoShim < Formula
  desc "GitHub CLI compatibility shim for Forgejo repositories"
  homepage "https://github.com/dirtydishes/gh-forgejo-shim"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "c2500690acb412000cce684bdafc09640122e80f5f47a772f362d6481f6378fe"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "6b43543f88b28c751755868feb9f4a217dc0dd97318227e10922adef6f65b8cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5555b1cc79c6005a859b5c4c4f4f01a99a136f2f0982b141903e9b2236fefc10"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5d499544992d7ef864bb3350a377f8bbc5f2b3bb4faf4551e0d8dfc8771b1454"
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
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gfj --version")
    assert_match "doctor", shell_output("#{bin}/gh-forgejo-shim --help")
  end
end
