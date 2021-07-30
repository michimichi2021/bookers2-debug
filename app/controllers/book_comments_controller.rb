class BookCommentsController < ApplicationController



  def create
    # @book = Book.find(params[:book_id])
    # @book_comment = @book.book_comments.build(book_comment_params)
    # @book_comment.user_id = current_user.id

    # @book_comment.save
    # render :index

    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comments = @book.book_comments
    @book_comment.user_id = current_user.id
    @book_comment.save


    # comment = current_user.book_comments.new(book_comment_params)
    # comment.book_id = book.id

    # @book=Book.find(params[:book_id])
    # @book_comment = BookComment.new

    # comment.save!
    # render 'index'
    #redirect_to request.referer

      #投稿に紐づいたコメントを作成


  end



  def destroy
   
    @book=Book.find(params[:book_id])
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find_by(id: params[:id], book_id: @book.id)
    @book_comment.destroy


  end




  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id, :user_id)
  end





end
