class BooksController < ApplicationController
    
    
    
    def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
        redirect_to book_path(@book), notice: "You have created book successfully."
      else
        @books = Book.all
        render 'index'
      end
    end
    
    
    
    def show

      @book = Book.find(params[:id])
      @user=@book.user
      @new_book=Book.new

      @book_comment = BookComment.new
      @book_comment.user=current_user
      @book_comments = @book.book_comments
      
     
    
      @see = See.find_by(ip: request.remote_ip) 
        if @see 
        @book = Book.find(params[:id])
        else 
        @book = Book.find(params[:id])
          See.create(ip: request.remote_ip)
        end
    
      
      
      
    end


      def index
      @books = Book.all
      
      
      @book=Book.new
    
      
      @ranks=Book.created_this_week
      
      

      @today_book =  @books.created_today
      @yesterday_book = @books.created_yesterday

      @this_week_book_6days_ago_book=@books.created_6days_ago
      @this_week_book_5days_ago_book=@books.created_5days_ago
      @this_week_book_4days_ago_book=@books.created_4days_ago
      @this_week_book_3days_ago_book=@books.created_3days_ago
      @this_week_book_2days_ago_book=@books.created_2days_ago





     
      
      
        @see = See.find_by(ip: request.remote_ip) 
          if @see 
            @books = Book.all
          else 
            @books = Book.all
            See.create(ip: request.remote_ip)
          end
      

      end

    

    def edit
      @book = Book.find(params[:id])

      if @book.user==current_user
        render "edit"
      else
        redirect_to books_path
      end

    end



    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to book_path(@book), notice: "You have updated book successfully."
      else
        render "edit"
      end
    end

    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
    end
    
    def new_rank
      @books = Book.order('id DESC')
      @book=Book.new
      
      

      
        @see = See.find_by(ip: request.remote_ip) 
          if @see 
            @books = Book.all
          else 
            @books = Book.all
            See.create(ip: request.remote_ip)
          end
      
    end
    
    def evaluation_rank
      @books = Book.order('rate DESC')
      @book=Book.new
     
    end

    private

    def book_params
      params.require(:book).permit(:title, :body, :rate)

    end



end
