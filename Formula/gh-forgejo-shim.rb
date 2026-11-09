class GhForgejoShim < Formula
  desc "GitHub CLI compatibility shim for Forgejo repositories"
  homepage "https://github.com/dirtydishes/gh-forgejo-shim"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "578c30e49fc46060738a403b12e7e390cfd64899db9a4862a9959ccb6b34de21"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "2f837462d091379063d4a210ca861159465320faf0a74674eaa30c1bf41c3057"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "97a5a1427fa333e504134c76ab7e17e8ed3dfe1dd884f287b82b6efdc44fb202"
    else
      url "https://github.com/dirtydishes/gh-forgejo-shim/releases/download/v#{version}/gh-forgejo-shim-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "781f4412bc15882e38f4fd2ec2a24f3a4ac62ec42072b3a66646836a8bb5d9db"
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
