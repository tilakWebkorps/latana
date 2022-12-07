require 'rubygems/package'
require 'zlib'
require 'fileutils'

TAR_LONGLINK = '././@LongLink'

class ExtractZip

  def initialize(file)
    @file = file
  end

  def extract
    tar_gz_archive = "#{Dir.pwd}/#{@file}"
    destination = "#{Dir.pwd}/folders"
  
    Gem::Package::TarReader.new( Zlib::GzipReader.open tar_gz_archive ) do |tar|
      dest = nil
      tar.each do |entry|
        if entry.full_name == TAR_LONGLINK
          dest = File.join destination, entry.read.strip
          next
        end
        dest ||= File.join destination, entry.full_name
        if entry.directory?
          FileUtils.rm_rf dest unless File.directory? dest
          FileUtils.mkdir_p dest, :mode => entry.header.mode, :verbose => false
        elsif entry.file?
          FileUtils.rm_rf dest unless File.file? dest
          File.open dest, "wb" do |f|
            f.print entry.read
          end
          FileUtils.chmod entry.header.mode, dest, :verbose => false
        elsif entry.header.typeflag == '2' #Symlink!
          File.symlink entry.header.linkname, dest
        end
        dest = nil
      end
    end
  end

end