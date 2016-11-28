class Minialign < Formula
  desc "Fast and accurate alignment tool for PacBio and Nanopore long reads"
  homepage "https://github.com/ocxtal/minialign"
  url "https://github.com/ocxtal/minialign/archive/minialign-0.4.4.tar.gz"
  sha256 "cde36f9ef59c75d2e40f069056a4fa90a612cef15e9994838f5038d74f09c94a"
  head "https://github.com/ocxtal/minialign.git"

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "0.4.4", shell_output("#{bin}/minialign -v")

    (testpath/"test.fa").write ">0\nAGATGTGCTGAGATGTGCTGAGATGTGCTGAGATGTGCTGAGATGTGCTG\n"
    system "#{bin}/minialign", "-d", "test.fa.mai", "test.fa"
    assert File.exist?("test.fa.mai")
    assert_match "40M", shell_output("#{bin}/minialign -s10 -l test.fa.mai test.fa 2>/dev/null")
  end
end
