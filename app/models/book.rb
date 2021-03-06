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
  
  def self.search(keyword)
   Book.where(['category LIKE ?', "#{keyword}"])
  end
  
	def self.last_week # メソッド名は何でも良いです
	  Book.joins(:favorites).where(favorites:{created_at:0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
	end
	
	scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } 
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 
  
	scope :created_6days_ago, -> { where(created_at: 6.day.ago.all_day) } 
	scope :created_5days_ago, -> { where(created_at: 5.day.ago.all_day) } 
	scope :created_4days_ago, -> { where(created_at: 4.day.ago.all_day) } 
	scope :created_3days_ago, -> { where(created_at: 3.day.ago.all_day) } 
	scope :created_2days_ago, -> { where(created_at: 2.day.ago.all_day) } 
	
	
	validates :rate, presence: true
  validates :rate, numericality: {
    # only_integer: true,
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1,
  }
  
  
	
end
