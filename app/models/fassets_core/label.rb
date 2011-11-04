module FassetsCore
  class Label < ActiveRecord::Base
    belongs_to :facet
    has_many :labelings, :dependent => :destroy
    has_many :classifications, :through => :labelings         

    validates_presence_of :caption  
    scope :in,  lambda {|ids|
      {:conditions => ['fassets_core_labels.id IN (?)', ids], :include => :facet, :order => "facet_id"}
    }
  end
end

