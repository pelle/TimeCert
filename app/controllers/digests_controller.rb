require 'digest/sha1'
class DigestsController < ApplicationController
#  caches_page :show
  def new
  end

  def create
    redirect_to stamp_url(:digest=>Digest::SHA1.hexdigest(params[:body]))
  end

  def show
    @stamp=Stamp.by_digest params[:digest]
    if request.env["HTTP_REFERER"]
      uri = URI.parse(request.env["HTTP_REFERER"])
      $redis.incr("site:#{uri.host}") if uri.host
    end
    
    respond_to do |format|
      format.html
      format.iframe
      format.xml
      [:csv,:text,:yaml,:json,:ini,:time].each do |type|
        format.send(type) do 
          render :text=>@stamp.send("to_#{type.to_s}")
        end
      end
    end
  end

end
