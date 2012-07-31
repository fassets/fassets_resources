module FassetsResources
  class Engine < Rails::Engine
    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( flowplayer.js form.js jquery.collapsiblePanel-0.2.0.js jquery.fileupload.js jquery.fileupload-ui.js jquery.iframe-transport.js jquery.tmpl.min.js jquery.ui.widget.js jquery.fileupload-ui.css jquery-ui-theme_base.css)
    end
  end
end
