require 'fassets_core'

FassetsCore::Plugins::register({:name => "Url", :class => FassetsResources::Url})
FassetsCore::Plugins::register({:name => "Local File", :class => FassetsResources::FileAsset})
FassetsCore::Plugins::register({:name => "Remote File", :class => FassetsResources::FileAsset})
FassetsCore::Plugins::register({:name => "Wikipedia Image", :class => FassetsResources::FileAsset})

