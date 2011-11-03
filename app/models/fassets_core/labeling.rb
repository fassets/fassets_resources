module FassetsCore
  class Labeling < ActiveRecord::Base
    belongs_to :label
    belongs_to :classification
  end
end

