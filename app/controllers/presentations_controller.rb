class PresentationsController < AssetsController

  def show
    @presentation = @content
    render :layout => "slide"
  end
  def content_model
    return Presentation
  end
end
