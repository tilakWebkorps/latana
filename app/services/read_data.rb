require 'debian_control_parser'

class ReadData
  def initialize(file_name)
    @file_name = file_name
  end

  def reader
    file_data = File.open("folders/#{@file_name}/DESCRIPTION")
    parser = DebianControlParser.new("data=<<EOF\n#{file_data.read}EOF")
    data = {}
    parser.paragraphs do |paragraph|
      paragraph.fields do |name,value|
        name = name.downcase.gsub(' ', '_').gsub('/', '_')
        data[name] = value
      end
    end
    data
  end
end