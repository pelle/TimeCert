# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def source_code_select(content,options={})
    "<form action=\"#\"><textarea #{ {:cols=>90,:rows=>2,:onclick=>'this.select()',:class=>'select-code'}.merge(options).collect{|k,v| "#{k}=\"#{v}\""}.join(' ') }>#{content}</textarea></form>"
  end
end
