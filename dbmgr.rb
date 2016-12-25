
class Dbmgr < Formula

  desc "Backup and restore development databases"
  homepage "https://github.com/callahanrts/dbmgr"
  url "https://github.com/callahanrts/dbmgr/archive/v0.1.2.tar.gz"

  head "https://github.com/callahanrts/dbmgr.git"
  bottle :unneeded

  def install
    lib.install Dir["lib/*"]
    bin.install "bin/dbmgr"
  end

  test do
    system "#{bin}/dbmgr", "help"
  end

end
