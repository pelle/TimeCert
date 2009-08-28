# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def source_code_select(content,options={})
    "<form action=\"#\"><textarea #{ {:cols=>90,:rows=>2,:onclick=>'this.select()',:class=>'select-code'}.merge(options).collect{|k,v| "#{k}=\"#{v}\""}.join(' ') }>#{content}</textarea></form>"
  end
  
  # Embeds a gist given it's gist number
  def gist(gist)
    "<script src=\"http://gist.github.com/#{gist}.js\"></script>"
  end
  
  def gravatar(email,size=80)
    image_tag(gravatar_url(email,size),:alt=>email,:size=>"#{size}x#{size}")
  end
  
  def gravatar_url(email,size=80)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=#{size}"
  end
  
  def link_to_committer(content,email,options={})
    if email=~/pelle/
      link_to content, "http://stakeventures.com"
    else
      content
    end
  end
end
