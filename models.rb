require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class Post < ActiveRecord::Base
    belongs_to :feeling
    belongs_to :user
    has_many :likes
    has_many :like_users, :through => :likes, source: :user
end 



class Feeling < ActiveRecord::Base
    has_many :posts
end 



class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :likes
    has_many :like_posts, :through => :likes, source: :post
end 

class Like < ActiveRecord::Base
    validates :user_id,
    presence: true
    validates :post_id,
    presence: true
    belongs_to :user
    belongs_to :post
end 
