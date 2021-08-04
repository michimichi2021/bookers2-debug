class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites,dependent: :destroy
  has_many :books,dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :book_comments, dependent: :destroy
  
  has_many :follower,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  has_many :followed,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy
  
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def follow(user_id)
    follower.create(followed_id:user_id)
  end
  
  def unfollow(user_id)
    follower.find_by(followed_id:user_id).destroy
  end
  
  def following?(user)
    following_user.include?(user)
  end
  
  	  
  def self.looks(how,word)
  		
  	    if how == "1"
  	      @users = User.where('name LIKE(?) or introduction LIKE(?)' ,"#{word}%","#{word}%")
  	    elsif how == "2"
  	      @users = User.where('name LIKE(?) or introduction LIKE(?)' ,"%#{word}","%#{word}")
  	    elsif how == "0"
  	      @users = User.where('name LIKE(?) or introduction LIKE(?)' ,"#{word}","#{word}")
  	    elsif how == "3"
  	      @users = User.where('name LIKE(?) or introduction LIKE(?)' ,"%#{word}%","%#{word}%")
  	    else
  	      @users = User.all
  	    end
  	    
  end
  
  has_many :entries,dependent: :destroy
  has_many :messages, dependent: :destroy
  
  has_many :group_users   #ここ！
  has_many :groups, through: :group_users
  	 
  
end


 