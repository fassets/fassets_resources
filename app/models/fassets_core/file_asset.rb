require "acts_as_asset"

module FassetsCore
  class FileAsset < ActiveRecord::Base
    MIME_2_MEDIA = {
      'image/jpeg' => 'image',
      'image/png' => 'image',
      'image/gif' => 'image',   
      'image/tiff' => 'image',
      'image/svg+xml' => 'image',
      'video/flv' => 'video',
      'video/x-flv' => 'video'
    }

    validates_attachment_presence :file

    acts_as_asset
    has_attached_file :file,
      :url => "/uploads/:id/:style.:extension",
      #:url => "/files/:id/:style.:extension",
      :path => ":rails_root/public/uploads/:id/:style.:extension",
      :styles => {
      :thumb => "48x48#",
      :small => "400x300>"
    }
    before_post_process :image?

    def media_type
      MIME_2_MEDIA[file_content_type] || 'file'
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
  end
end

