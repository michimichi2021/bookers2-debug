class SearchesController < ApplicationController
   before_action :authenticate_user!

  def search
   
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:how], params[:word])
    else
      @books = Book.looks(params[:how], params[:word])
    end

  end


end
