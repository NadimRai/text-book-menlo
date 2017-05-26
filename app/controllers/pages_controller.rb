class PagesController < ApplicationController
  def about
  end

  def contact
  end
  def home
  	@listings = Listing.limit(4)
  end
end
