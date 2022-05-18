class UsersController < ApplicationController
    
    before_action :authenticate_user!
    before_action :correct_post,only: [:edit]
    
    def index
        @book = Book.new
        @user = current_user
        @users = User.all
    end
    
    def new
        @book = Book.new  
    end
    
    def create
        book = Book.new(book_params)
        book.user_id = current_user.id
        book.save
        redirect_to book_path(book.id)
    end
    
    def show
        @users = User.all
        @user = User.find(params[:id])
        @book = Book.new
        @books= @user.books
    end
    
    def edit
        @user = User.find(params[:id])
        if @user.id == current_user.id
            render :edit
        else
            redirect_to user_path(@user)
        end
    end
    
    def update
        @user = User.find(params[:id])
        if  @user.update(user_params)
        redirect_to user_path(@user.id), flash: {success: "You have updated user successfully."}
        else
        render  :edit
        end
    end
    
    def correct_post
        @user = User.find(params[:id])
        unless @user.id == current_user.id
          redirect_to user_path(current_user.id)
        end
    end
    
    private
    
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end 
end
