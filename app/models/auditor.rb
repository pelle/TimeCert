require 'git'
class Auditor
  attr_accessor :git
  
  def initialize
    @git=Git.open(RAILS_ROOT)
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