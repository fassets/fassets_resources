require "pandoc-ruby"

module PresentationsHelper
  def template_path(template)
    File.join(TEMPLATE_PATH, template).to_s
  end
  def render_inner_template(slide)
    template = slide.presentation.template;
    render(
      :file => File.join(template_path(template), slide.template + ".html.haml").to_s,
      :locals => {:slide => slide}
    )
  end
  def render_slot(slot, css_class="")
    return "" unless slot
    if slot["mode"] == "asset" and slot.asset
      @content = slot.asset.content
      render :partial => content_partial(slot.asset.content, "preview") if slot.asset
    else
      PandocRuby.convert(slot["markup"], :from => :markdown, :to => :html)
    end
  end
end
