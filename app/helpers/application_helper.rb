# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def source_code_select(content,options={})
    "<textarea #{ {:cols=>70,:rows=>2,:onclick=>'this.select()'}.merge(options).collect{|k,v| "#{k}=\"#{v}\""}.join(' ') }>#{content}</textarea>"
  end
end
