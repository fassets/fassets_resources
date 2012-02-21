require "acts_as_asset"
require 'carrierwave/processing/mime_types'

class FileAsset < ActiveRecord::Base
  attr_accessible :file, :remote_file_url, :content_type, :author, :source, :license
  include Rails.application.routes.url_helpers
  #validates_presence_of :file
  mount_uploader :file, FileUploader
  before_create :save_content_type
  
  MIME_2_MEDIA = {
    'image/jpeg' => 'image',
    'image/png' => 'image',
    'image/gif' => 'image',   
    'image/tiff' => 'image',
    'image/svg+xml' => 'image',
    'video/flv' => 'video',
    'video/x-flv' => 'video'
  }

  def save_content_type
    self.content_type = file.file.content_type
  end
  
  def to_jq_upload
    {
      "name" => read_attribute(:file),
      "size" => file.size,
      "url" => file.url,
      "thumbnail_url" => file.thumb.url,
      "edit_box_url" => "/edit_box/"+id.to_s,
      "delete_url" => file_asset_path(:id => id),
      "delete_type" => "DELETE" 
    }
  end
  acts_as_asset

  def media_type
    MIME_2_MEDIA[self.content_type] || 'file'
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

