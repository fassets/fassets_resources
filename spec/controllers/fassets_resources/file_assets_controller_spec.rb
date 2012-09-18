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
  end
end
