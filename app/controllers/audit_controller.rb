class AuditController < ApplicationController
  caches_page :index
  
  def index
    @auditor=Auditor.new
  end
end
