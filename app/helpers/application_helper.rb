module ApplicationHelper

def is_active?(page_name)
  "active" if params[:action] == page_name
end
	
def sortable(column, title = nil)
  title ||= column.titleize
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
end

def sortable2(column, title = nil)
  title ||= column.titleize
  css_class = column == sort_column2 ? "current #{sort_direction}" : nil
  direction = column == sort_column2 && sort_direction == "asc" ? "desc" : "asc"
  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
end

end
