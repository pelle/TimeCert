class AuditController < ApplicationController
  caches_action :index
  
  def index
    @auditor=Auditor.new
  end
end
