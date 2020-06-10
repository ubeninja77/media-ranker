class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  def self.top_ten(category)
   
  end

  def self.sort_by_vote(category)
  
  end

  def self.spotlight
    
    
  end
end
