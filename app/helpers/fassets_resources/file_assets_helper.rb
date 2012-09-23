module FassetsResources::FileAssetsHelper

  def self.partial_for_type(type)
    prefix = "fassets_resources/file_assets/"
    if type == "Local File"
      return prefix + "local_file_form"
    elsif type == "Remote File"
      return prefix + "remote_file_form"
    elsif type == "Wikipedia Image"
      return prefix + "wiki_img_form"
    end
  end

  def video_player(content)
    javascript_tag %Q<
      flowplayer('player_#{content.id}', '/swf/flowplayer.swf', {
        clip: {
          autoPlay: false
        },
        plugins: {
            controls: {
                url: 'flowplayer.controls.swf',
                bottom:0,
                height:24,
                backgroundColor: '#bbbbbb',
                backgroundGradient: 'none',
                timeColor: '#ffffff',
                buttonColor: '#222222'
            }
        }

      });
    >
  end
end

