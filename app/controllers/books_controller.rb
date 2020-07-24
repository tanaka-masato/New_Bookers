class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :corrent_user, only: [:edit, :update]
	
	def index
		@book = Book.new
		@books = Book.all
		@users = User.all
		# @user = current_user
	end
	
	def new
		# @newbook = Book.new
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
		flash[:notice] = "Book was successfully destroyed"
	end
	
	
	def show
		@book = Book.find(params[:id])
		@newbook = Book.new
		@user = User.find(@book.user_id)
	end

	def edit
		@book = Book.find(params[:id])
	end
	

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id 
		if @book.save
			redirect_to book_path(@book)
			flash[:notice] = "Book was successfully created."
		else
			@books = Book.all
			render :"index"
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(@book.id)
			flash[:notice] = "Book was successfully update"
		else
			render 'edit'
			flash[:danger] = "Book"
		end
	end
	

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end

  def corrent_user
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
  end

end
