require 'json'
class GithubController < ApplicationController
  caches_action :show
  
  # extracts all digest from payload and timestamps them
  def create
    head :ok # Return straight away
    begin
      payload=JSON.parse(params[:payload])
      Stamp.by_digest payload["before"]
      Stamp.by_digest payload["after"]
      payload["commits"].each do |c| 
        Stamp.by_digest( c["id"])
      end
    rescue
      logger.error "Error parsing payload from github: #{$!}"
    end
  end

end
