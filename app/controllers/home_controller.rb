class HomeController < ApplicationController
  def index
    @tinee_urls = TineeUrl.paginate(:page => params[:page], :per_page => 30)
  end

  def fetch_url
    encoded_id = params[:encoded_id]
    tinee_url_entry = TineeUrl.find_by_encoded_id(encoded_id)
    if tinee_url_entry
      redirect_to tinee_url_entry.url
    else
      render :text => 'Not Found', :status => '404'
    end
  end
end
