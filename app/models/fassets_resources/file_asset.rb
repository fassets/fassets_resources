require "acts_as_asset"
require 'carrierwave/processing/mime_types'

module FassetsResources
  class FileAsset < ActiveRecord::Base
    attr_accessible :file, :remote_file_url, :content_type, :author, :source, :license
    include FassetsResources::Engine.routes.url_helpers
    validates_presence_of :file
    mount_uploader :file, FileUploader
    before_save :update_file_attributes

    MIME_2_MEDIA = {
      'image/jpeg' => 'image',
      'image/png' => 'image',
      'image/gif' => 'image',
      'image/tiff' => 'image',
      'image/svg+xml' => 'image',
      'video/flv' => 'video',
      'video/x-flv' => 'video',
      'video/x-msvideo' => 'video',
      'video/mpeg' => 'video'
    }

    def update_file_attributes
      if file.present? && file_changed?
        self.content_type = file.file.content_type
        self.file_size = file.file.size
      end
    end

    def to_jq_upload
      {
        "name" => read_attribute(:file),
        "size" => file.size,
        "url" => file.url,
        "thumbnail_url" => file.thumb.url,
        "edit_box_url" => "/edit_box/"+id.to_s,
        "delete_url" => file_asset_path(:id => id),
        "delete_type" => "DELETE",
        "content_type" => "FassetsResources::FileAsset"
      }
    end
    acts_as_asset

    def media_type
      if self.content_type
        MIME_2_MEDIA[self.content_type] || 'file'
      else
        'file'
      end
    end
    def file_updated_at
      Time.now
    end
    def icon
      media_type == 'image' ? file.url(:thumb) : "/images/#{media_type}.png"
    end
    def image?
      !(file_content_type =~ /^image.*/).nil?
    end
    def image_width_preview
      image ||= MiniMagick::Image.open(file.medium.path)['width']
    end
    def image_height_preview
      image ||= MiniMagick::Image.open(file.medium.path)['height']
    end
    def image_width
      image ||= MiniMagick::Image.open(file.path)['width']
    end
    def image_height
      image ||= MiniMagick::Image.open(file.path)['height']
    end
  end
end

