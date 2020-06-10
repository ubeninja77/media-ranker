class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true, uniqueness: { scope: :category }

  def self.top_ten(category)
    Work.where(category: category).sort_by { |work| -work.votes.length }.first(10)
  end

  def self.find_spotlight
    works = Work.all
    spotlight = works.max_by{|work| work.votes.length}
    return spotlight
  end


  def self.sort_by_vote(category)
  
  end
end
