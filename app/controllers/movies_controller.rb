class MoviesController < ApplicationController
  def index
    Item.order(rank: :desc)
    @all_items = Item.order(rank: :desc).where(kind: "Movie")
    @media = "Movie"
    @link_path = "/movies/"

    @path = new_movie_path
  end

  def show
    @item = Item.find_by(id: params[:id].to_i)

    if @item == nil # if the item does not exist
      flash[:notice] = "That item does not exist."
      redirect_to action: "index"
    elsif @item.kind != "Movie"
      flash[:notice] = "That item is not a movie."
      redirect_to action: "index"
    else
      @upvote_path = movies_upvote_path(@item.id)
      @edit_path = edit_movie_path(@item.id)
      @delete_path = movie_path(@item.id)
      @media = "Movies"
      @view_media_path = movies_path
    end
  end

  def new
    @item = Item.new
    @action = :create
    @author_text = "Director"
    @method = :post
  end

  def create
    @params = params
    @item = Item.new(post_params(params))
    @item.rank = 0
    @item.kind = "Movie"
    if @item.save
      # success
      redirect_to movies_path
    else
      flash[:notice] = "Cannot save #{@item.errors.keys} - #{@item.errors.values}"
    end
  end

  def edit
    @item = Item.find_by(id: params[:id].to_i)
    if @item == nil # if the item does not exist
      flash[:notice] = "That item does not exist."
      redirect_to action: "index"
    elsif @item.kind != "Movie"
      flash[:notice] = "That item is not a movie."
      redirect_to action: "index"
    else
      @action = :update
      @author_text = "Director"
      @method = :put
    end


  end

  def update
    @item = Item.find_by(id: params[:id].to_i)
    if @item == nil # if the item does not exist
      redirect_to :index, flash: {notice: "That item does not exist."}
    elsif @item.kind != "Movie"
      redirect_to :index, flash: {notice: "That item is not a movie."}
    end
    @item.name = post_params(params)[:name]
    @item.author = post_params(params)[:author]
    @item.description = post_params(params)[:description]
    if @item.save
      redirect_to book_path(@item.id), flash: {notice: "Item saved."}
    else
      redirect_to edit_book_path(@item.id), flash: {notice: "Item could not be saved."}
    end

  end

  def destroy
    @item = Item.find_by(id: params[:id].to_i)
    if @item == nil # if the item does not exist
      flash[:notice] = 'That item does not exist.'
      redirect_to :index
    elsif @item.kind != "Movie"
      flash[:notice] = 'That item is not a movie.'
      redirect_to :index
    elsif @item.destroy
      flash[:notice] = "Sucessfully deleted"
      redirect_to :action=> :index, status: 303
    else
      flash[:notice] = "Unable to delete the movie"
      redirect_to :action=> :index, status: 303
    end
  end

  def upvote
    @item = Item.find_by(id: params[:id].to_i)
    if @item == nil # if the item does not exist
      flash[:notice] = 'That item does not exist.'
      redirect_to :index
    else
      @item.upvote
      if request.referer
        redirect_to request.referer
      else
        redirect_to action: "index"
      end
    end
  end

  private
    def post_params(params)
      params.require(:item).permit(:name, :author, :description)
    end
end
