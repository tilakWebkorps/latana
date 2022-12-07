class InformationsController < ApplicationController
  def import
    url = "https://cran.r-project.org/src/contrib/"
    scraped_data = Scrapper.new(url).scrap
    data = DownloadFile.new(scraped_data).download_zip
    render json: {message: 'the data is inserted'}
  end
end
