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
      html = File.read(path)
      renderer = Redcarpet::Render::HTML.new
      markdown = Redcarpet::Markdown.new(renderer, extensions = {fenced_code_blocks: true})
      rendered_markdown = markdown.render(html)

      render layout: "documentation", html: rendered_markdown.html_safe
    else
      render_not_found
    end
  end

  def full_page_path(page)
    Rails.root + "../../#{page}.md"
  end

  def render_not_found
    raise ActionController::RoutingError, "Not Found"
  end
end
