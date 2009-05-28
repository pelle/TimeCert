require 'digest/sha1'
class DigestsController < ApplicationController
  def new
  end

  def create
    redirect_to stamp_url(:digest=>Digest::SHA1.hexdigest(params[:body]))
  end

  def show
    @stamp=Stamp.find_or_create_by_digest params[:digest]
  end

end
