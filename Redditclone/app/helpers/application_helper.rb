module ApplicationHelper
  def auth_token_input
    str = <<-HTML
      <input type="hidden" name="authenticity_token" value="#{form_authenticity_token}">
    HTML
    str.html_safe
  end

  def method_input(method)
    str = <<-HTML
      <input type="hidden" name="_method" value="#{method}">
    HTML

    str.html_safe
  end
  
end
