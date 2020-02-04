# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class MirrorSh < Formula
    desc "Mirror online resources like repositories or files locally and acts the most basic version of a bash-package-manager."
    homepage ""
    url "https://github.com/vknabel/mirror-sh/archive/0.1.0.tar.gz"
    sha256 "051247746f5f2a5b537ff891d17c4e588c1c8e1cb6709441dfad05481420d1ba"

    # depends_on "cmake" => :build

    def install
      # ENV.deparallelize  # if your formula fails when building in parallel
      # Remove unrecognized options if warned by configure
      mv "mirror.sh", "mirror"
      bin.install "mirror"
    end

    test do
      # `test do` will create, run in and delete a temporary directory.
      #
      # This test will fail and we won't accept that! For Homebrew/homebrew-core
      # this will need to be a test that verifies the functionality of the
      # software. Run the test with `brew test mirror-sh`. Options passed
      # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
      #
      # The installed folder is not in the path, so use the entire path to any
      # executables being tested: `system "#{bin}/program", "do", "something"`.
      system "#{bin}/mirror"
    end
  end