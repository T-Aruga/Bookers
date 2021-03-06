class BooksController < ApplicationController

  before_action :ensure_correct_user, only: [:edit]

    def new
    end

    def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "You have created book successfully."
         redirect_to book_path(@book.id)
      else
        @user = current_user
        @books = Book.page(params[:page]).reverse_order
        render :index
      end
    end

    def index
      @books = Book.page(params[:page]).reverse_order
      @book = Book.new
      @user = current_user
    end

    def show
      @book = Book.new
      @book_detail = Book.find(params[:id])
      @user = current_user
    end

    def edit
      @book = Book.find(params[:id])
    end

    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        flash[:notice] = "Book was successfully updated."
        redirect_to book_path(@book.id)
      else
        render :edit
      end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end

    def ensure_correct_user
      @book = Book.find(params[:id])
      if current_user.id != @book.user_id
        redirect_to books_path
      end
    end

    private

    def book_params
    params.require(:book).permit(:title, :body)
    end

  end
