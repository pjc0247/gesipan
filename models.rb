require 'rubygems'
require 'data_mapper'
require 'dm-migrations'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')

class Account
  include DataMapper::Resource

  property :id, Serial
  property :user_id, String, :required => true
  property :user_pw, String, :required => true
  property :nickname, String, :required => true
  property :created_at, DateTime

  validates_length_of :user_id, :max => 32
  validates_length_of :user_pw, :max => 32
  validates_length_of :nickname, :max => 16

  has n, :posts
  has n, :comments
end

class Post
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true
  property :body, Text, :required => true
  property :created_at, DateTime

  belongs_to :account
  has n, :comments
  has n, :likes
end
class Comment
  include DataMapper::Resource

  property :id, Serial
  property :body, Text, :required => true
  property :created_at, DateTime

  belongs_to :account
  belongs_to :post
end

class Like
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime

  belongs_to :account
  belongs_to :post
end

DataMapper.finalize
DataMapper.auto_migrate!