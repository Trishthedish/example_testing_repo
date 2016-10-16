class HomepageController < ApplicationController
  def index
    Item.limit(10)
    @movies = Item.where(kind: "Movie")
    @books  = Item.where(kind: "Book")
    @albums = Item.where(kind: "Album")
  end
end
