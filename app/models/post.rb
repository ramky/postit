class Post < ActiveRecord::Base
	include Voteable
	
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	has_many   :comments
	has_many   :post_categories
	has_many   :categories, through: :post_categories


	validates  :title,       presence: true, length: { minimum: 5 }
	validates  :url,         presence: true
	validates  :description, presence: true

	before_save :generate_slug

	def to_param
		self.slug
	end

	def generate_slug
		self.slug = self.title.gsub(' ', '-').downcase
	end
end