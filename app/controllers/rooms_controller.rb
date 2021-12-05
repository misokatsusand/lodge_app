class RoomsController < ApplicationController
  require "date"
  before_action :authenticate_user,{only: [:owned_room,:new,:create,:return_confirm,:return_confirm_reload]}
  before_action :forbid_url,{only: [:destroy,:update]}

  def top; end

  def index
    @area = params[:search_area]
    @keyword = params[:search_keyword]
    @rooms = Room.search(@area,@keyword).order(id: "desc").page(params[:page]).per(20).order(id: "desc")
  end

  def index_all
    @rooms = Room.all.order(id: "desc")
    @rooms = Room.page(params[:page]).per(20)
    render "rooms/index"
  end

  def owned_room
    @rooms = Room.where(user_id: @current_user.id)
  end

  def new
    @room = Room.new()
  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :comment, :price_per_day_and_person, :area, :image_name, :user_id))
    if params[:room_image]
      @room.image_name = "#{@room.id}.jpg"
      image = params[:room_image]
      File.binwrite("public/room_images/#{@room.image_name}",image.read)
    else
      @room.image_name = "default.jpg"
    end
    if @room.save
      flash[:notice] = 'ルームを新規登録しました'
      redirect_to "/rooms"
    else
      @name = params[:name]
      @comment = params[:comment]
      @price_per_day_and_person = params[:price_per_day_and_person]
      @area = params[:area]
      render "rooms/new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @book = Book.new()
  end

  def return_confirm
    @book = Book.new(params.require(:book).permit(:start, :end, :number_of_people, :user_id, :room_id))
    @book.days = (@book.end.to_date - @book.start.to_date).to_i
    @book.total_price = @book.days * @book.number_of_people * @book.room.price_per_day_and_person
    render "books/confirm"
  end

  def return_confirm_reload
    flash[:notice] = '再読み込みが行われたため、再度入力をお願いします'
    redirect_to "/rooms/#{params[:id]}"
  end

  def destroy; end
  def update; end
end
