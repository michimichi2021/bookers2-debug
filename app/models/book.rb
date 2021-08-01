class Book < ApplicationRecord
	
	belongs_to :user

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.looks(how,word)
		
	    if how == "1"
	      @books = Book.where('title LIKE(?) or body LIKE(?)' ,"#{word}%","#{word}%")
	    elsif how == "2"
	      @books = Book.where('title LIKE(?) or body LIKE(?)' ,"%#{word}","%#{word}")
	    elsif how == "0"
	      @books = Book.where('title LIKE(?) or body LIKE(?)' ,"#{word}","#{word}")
	    elsif how == "3"
	      @books = Book.where('title LIKE(?) or body LIKE(?)' ,"%#{word}%","%#{word}%")
	    else
	      @books = Book.all
	    end
	    
  end
  
	def self.last_week # メソッド名は何でも良いです
	  Book.joins(:favorites).where(favorites:{created_at:0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
	end
	
	
end
