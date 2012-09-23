require 'fassets_core'

FassetsCore::Plugins::register({:name => "Url", :class => FassetsResources::Url})
FassetsCore::Plugins::register({:name => "Local File", :class => FassetsResources::FileAsset})

