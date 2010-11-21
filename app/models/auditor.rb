class Auditor
  # I'm requiring it here, so the git gem is only loaded when this model is instantiated.
  # This is due to some issues I had with multiple passenger instances attempting load the gem
  # at the same time. The checks the git version  which apparently causes issues.
  require 'git' 
  attr_accessor :git
  
  def initialize
    @git=Git.open(Rails.root)
  end
  
  def url
    @url||=@git.remote.url
  end
  
  def digest
    @digest||=current.sha
  end
  
  def tree_digest
    current.gtree.sha
  end
  
  def log
    @log||=@git.log
  end
  
  def name
    current.author.name
  end
  
  def email
    current.author.email
  end
  
  def message
    current.message
  end
  
  def current
    @current||=log.first
  end
  
  def parent
    current.parent
  end

  def tree_url
    github_url("/tree/#{digest}")
  end

  def commit_url
    github_url("/commit/#{digest}")
  end
  
  def parent_url
    github_url("/commit/#{parent.sha}")
  end
  
  def github_url(path="")
    "http://github.com/pelle/TimeCert#{path}"
  end
end