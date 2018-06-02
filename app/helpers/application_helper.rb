module ApplicationHelper
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def home_page_class?(path)
    return 'home-page' if request.path == path
    ''
  end
end
