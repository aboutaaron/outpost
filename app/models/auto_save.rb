class AutoSave < ActiveRecord::Base
  serialize :frozen_article
  
  belongs_to :article, polymorphic: true
end
