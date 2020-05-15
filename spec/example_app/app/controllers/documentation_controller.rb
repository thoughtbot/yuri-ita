class DocumentationController < ApplicationController
  def index
    render_documentation_page "README"
  end

  def show
    render_documentation_page "docs/#{params[:page]}"
  end

  private

  def render_documentation_page(name)
    path = full_page_path(name)

    if File.exist?(path)
      html = parse_document(path)
      render layout: "documentation", html: html.html_safe
    else
      render_not_found
    end
  end

  def full_page_path(page)
    Rails.root + "../../#{page}.md"
  end

  def parse_document(path)
    file = path.to_s
    GitHub::Markup.render(file, File.read(file))
  end

  def render_not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
