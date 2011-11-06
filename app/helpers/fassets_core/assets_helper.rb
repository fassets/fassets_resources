module FassetsCore
  module AssetsHelper
    def content_partial(content, partial)
      content.class.to_s.underscore.pluralize + "/" + content.media_type.to_s.underscore + "_" + partial.to_s 
    end

    # construct the path for the assets content
    def asset_content_path(content)
      class_name = content.class.to_s.split("::").last
      "#{root_path}#{class_name.underscore.pluralize}/#{content.id.to_s}"
    end
    def edit_asset_content_path(content)
      asset_content_path(content) + "/edit"
    end
  end
end

