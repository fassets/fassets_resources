# lib/carrierwave/ffmpeg.rb
require 'streamio-ffmpeg'
require 'fileutils'

module CarrierWave
  module FFMPEG
    module ClassMethods
      def convert_to_flv
        process :convert_to_flv
      end
    end
 
    def convert_to_flv
      directory = File.dirname( current_path )
      tmpfile   = File.join( current_path+".flv")
 
      FileUtils.mv( current_path, tmpfile)
 
      file = ::FFMPEG::Movie.new(tmpfile)
      file.transcode( current_path, :custom => "-f flv", :audio_codec => "libmp3lame")
      
      FileUtils.rm(tmpfile)
    end
  end
end
