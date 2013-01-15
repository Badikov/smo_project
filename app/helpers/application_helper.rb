module ApplicationHelper
  def box_wrapper(&block)  
    content = capture(&block)  
    content_tag(:div, content, :class => 'box')  
  end
end
