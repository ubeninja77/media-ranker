class HomepageController < ApplicationController
  def index
    @spotlight = Work.spotlight
  end
end
