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
    
      
      @ranks=Book.last_week
      
      

      @today_book =  @books.created_today
      @yesterday_book = @books.created_yesterday

      @this_week_book_6days_ago_book=@books.created_6days_ago
      @this_week_book_5days_ago_book=@books.created_5days_ago
      @this_week_book_4days_ago_book=@books.created_4days_ago
      @this_week_book_3days_ago_book=@books.created_3days_ago
      @this_week_book_2days_ago_book=@books.created_2days_ago





      @book_by_day = @books.group_by_day(:created_at).size
      # groupdateのgroup_by_dayメソッドで投稿日(created_at)に基づくグルーピングして個数計上。
      # => {Wed, 05 May 2021=>23, Thu, 06 May 2021=>20, Fri, 07 May 2021=>3, Sat, 08 May 2021=>0, Sun, 09 May 2021=>12, Mon, 10 May 2021=>2}

      @chartlabels = @book_by_day.map(&:first).to_json.html_safe
      # 投稿日付の配列を格納。文字列を含んでいると正しく表示されないので.to_json.html_safeでjsonに変換。
      # => "[\"2021-05-05\",\"2021-05-06\",\"2021-05-07\",\"2021-05-08\",\"2021-05-09\",\"2021-05-10\"]"

      @chartdatas = @book_by_day.map(&:second)
      # 日別投稿数の配列を格納。
      # => [23, 20, 3, 0, 12, 2]
      
      
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

    private

    def book_params
      params.require(:book).permit(:title, :body)

    end



end
