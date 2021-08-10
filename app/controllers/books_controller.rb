class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
     @categorys = Category.where(is_valid: true)
    @q = Book.all.ransack(params[:q])
    @books = @q.result(distinct: true)
     @book = Book.new
  end

  def create
       @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
       redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end
  
  def search
    @categorys = Category.where(is_valid: true)
    @category = Category.find(params[:id])
    @q = @category.books.all.ransack(params[:q])
    @notes = @q.result(distinct: true).page(params[:page])
    @title = @category.name
    render :index
  end
  private

  def book_params
    params.require(:book).permit(:title, :body,:rate,:category_id)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
