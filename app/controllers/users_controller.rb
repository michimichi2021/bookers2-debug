class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    
    @user = User.find(params[:id])
    
    if @user==current_user
       render "edit"
     
    else
      redirect_to user_path(current_user.id)
    end
      
  end



  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def book_count
     
    @user=User.find(params[:id])
    @books=@user.books
    create_at=params[:created_at]
    if create_at==""
      @search_book="日付けを入力してください"
      
    else
      @search_book=@books.where("created_at LIKE?","#{created_at}%").count
    end
  end



  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
 
  
end
