class Category < ActiveRecord::Base
	include Sluggable
	has_many :post_categories
	has_many :posts, through: :post_categories

	validates :name,       presence: true, length: { minimum: 4 }

	sluggable_column :name
end
