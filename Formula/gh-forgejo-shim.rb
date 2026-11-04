class GhForgejoShim < Formula
  desc "GitHub CLI compatibility shim for Forgejo repositories"
  homepage "https://github.com/dirtydishes/gh-forgejo-shim"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "fd1a482786e97c9b26064f7f113c0d9e95cb176c55ae1a6d9d6076ff2c15d888"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "89fc173a3ff5cb73e55d5500f58e7de031fde3374bb60b5b5242181f42ee942f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c4a2b43586014a66640c8e80afa5ecc612f5abc006e41261ee8cd479521dfdc8"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d30425963a7c5dd94d21a8d3c7a21059261ee0fd9fe546b4ce0220029491e641"
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
