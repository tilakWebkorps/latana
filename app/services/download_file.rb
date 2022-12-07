class DownloadFile
  def initialize(files)
    @files = files
  end
  
  def download_zip
    @files.each_with_index do |i, index|
      return if index > 100
      `wget -c https://cran.r-project.org/src/contrib/#{i[:file]}`
      ExtractZip.new(i[:file]).extract
      FileUtils.rm_rf("#{Dir.pwd}/#{i[:file]}")
      file_name = i[:file].split('_')
      data = ReadData.new(file_name[0]).reader
      FileUtils.rm_rf("#{Dir.pwd}/folders/#{file_name[0]}")
      Information.create(package: data['package'], version: data['version'], r_version_needed: data['r_version_needed'], depends: data['depends'], date_publication: data['date_publication'], title: data['title'], author: data['author'], maintainer: data['maintainer'], license: data['license'])
    end
  end
end