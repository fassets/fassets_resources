require 'spec_helper'

module FassetsResources
  describe FileAssetsController do
    let(:asset) { double(FileAsset, :id => 1,
                         :format => "png",
                         :media_type => "image",
                         :file_url => "#{root_path}public/uploads/1/small.png"
                        )
                }
    let(:create_params) do
      {"fassets_resources_file_asset" =>
       {:file => Rack::Test::UploadedFile.new(Rails.root.join("../fixtures/files/example.png"),"image/png")}
      }
    end
    include_examples "every authenticated controller"
    it_should_behave_like "Every AssetsController"

    it "assigns content with FileAsset class" do
      get 'new', :use_route => :fassets_resources
      response.should be_success
      assigns(:content).class.should == FileAsset
    end

    context "actions with assets" do
      before(:each) { setup_content }

      it "should redirect into the thumb folder" do
        get 'thumb', :id => asset.id, :format => asset.format, :use_route => :fassets_resources
        response.should redirect_to("#{root_path}public/uploads/#{asset.id}/thumb.#{asset.format}")
      end

      it "should redirect into the preview folder" do
        get 'preview', :id => asset.id, :format => asset.format, :use_route => :fassets_resources
        response.should redirect_to("#{root_path}public/uploads/#{asset.id}/small.#{asset.format}")
      end

      it "should redirect into the original image folder" do
        get 'original', :id => asset.id, :format => asset.format, :use_route => :fassets_resources
        response.should redirect_to("#{root_path}public/uploads/#{asset.id}/original.#{asset.format}")
      end

      it "should render partials" do
        get 'show', :id => asset.id, :use_route => :fassets_resources
        response.should render_template("layouts/fassets_core/application")
        response.should render_template("assets/show")
      end
    end

    context "GET wikipedia_images" do
      it "should get a list of images" do
        page = double("Wikipedia::Page")
        test_urls = ['http://test.host/test1.png','http://test.host/test2.png']
        page.should_receive(:image_urls) { test_urls }
        Wikipedia.should_receive(:find).with("test search") { page }
        get 'wikipedia_images', :use_route => :fassets_resources, :search_key => "test search"
        response.should be_success
        response.should render_template "wikipedia_images"
        response.should_not render_template "layouts/fassets_core/application"
        assigns(:image_urls).should == test_urls
      end

      it "should not assign nil as image list" do
        page = double("Wikipedia::Page")
        # image_urls returns nil if no images are found
        page.should_receive(:image_urls) { nil }
        Wikipedia.should_receive(:find).with("test search") { page }
        get 'wikipedia_images', :use_route => :fassets_resources, :search_key => "test search"
        assigns(:image_urls).should_not be_nil
        assigns(:image_urls).should be_empty
      end
    end
  end
end
