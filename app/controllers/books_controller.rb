class BooksController < ApplicationController
  before_action :authenticate_user,{only: [:index,:show,:create]}
  before_action :forbid_url,{only: [:confirm]}

  def index
    @books = Book.where(user_id: @current_user.id)
  end

  def show
    if @current_user.id == Book.find(params[:id]).user_id
      @book = Book.find(params[:id])
    else
      flash[:notice] = '予約したユーザー以外参照できません'
      redirect_to "/"
    end
  end

  def confirm
    @book = Book.new()
  end

  def create
    @book = Book.new(params.require(:book).permit(:start, :end, :days, :number_of_people, :total_price, :user_id, :room_id))
    if @book.save
      flash[:notice] = '予約が完了しました'
      redirect_to "/books/#{@book.id}"
    else
      flash[:notice] = '不正な値が入力されたため、再入力をお願いします'
      redirect_to "/rooms/#{params[:room_id]}"
    end
  end
end
