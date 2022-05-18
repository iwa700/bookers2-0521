class BooksController < ApplicationController
  
    before_action :authenticate_user!
    before_action :correct_post,only: [:edit]
    
    def index
        @user=current_user
        @book=Book.new
        @books = Book.all  
    end
    
    def new
    end
    
    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        @user=current_user
        @books = Book.all 
      
        if @book.save
          redirect_to book_path(@book.id), flash: {success: "You have created book successfully."}  
        else
          render :index
        end 
    end
    
    def show
      @book_new=Book.new
      @book=Book.find(params[:id])
      @user=@book.user
    end
    
    def edit
      @book_new=Book.new
      @book=Book.find(params[:id])
      @user=current_user
    end
    
    def update
      @book = Book.find(params[:id])
      @user=current_user
      
        if  @book.update(book_params)
          redirect_to book_path(@book.id), flash: {success: "You have updated book successfully."}
        else
        render  :edit
        end
    end
    
    def destroy
      @book = Book.find(params[:id])  # データ（レコード）を1件取得
      @book.destroy  # データ（レコード）を削除
      redirect_to '/books'  # 投稿一覧画面へリダイレクト  
    end
    
    def correct_post
          @book = Book.find(params[:id])
      unless @book.user.id == current_user.id
        redirect_to books_path
      end
    end
    
    private
    # ストロングパラメータ
    def book_params
      params.require(:book).permit(:title, :body)
    end
  
end
