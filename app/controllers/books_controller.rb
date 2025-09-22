class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      puts @book.errors.full_messages
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user = current_user
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = @book.user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to '/books'
    end
  end

   def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end


end

 
 private

  def book_params
    params.require(:book).permit(:title, :body)
  end