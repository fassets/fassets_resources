module AssetsHelper
  def content_partial(content, partial)
    content.class.to_s.underscore.pluralize + "/" + content.media_type.to_s.underscore + "_" + partial.to_s 
  end

  # construct the path for the assets content
  def asset_content_path(content)
    begin
      return url_for content
    rescue NoMethodError
      # it’s fine, if this fails this means, the engine should know about the url
    end
    engine = content.class.to_s.split("::").first + "::Engine"
    send(engine.constantize.engine_name).url_for content
  end
  def edit_asset_content_path(content)
    asset_content_path(content) + "/edit"
  end
end

