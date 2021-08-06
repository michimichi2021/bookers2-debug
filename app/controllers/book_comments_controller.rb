class BookCommentsController < ApplicationController



  def create
    

    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comments = @book.book_comments
    @book_comment.user_id = current_user.id
    @book_comment.save



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
