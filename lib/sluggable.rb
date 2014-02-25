module Sluggable
	extend ActiveSupport::Concern

	included do
		before_save :generate_slug
		class_attribute :slug_column
	end

	def to_param
		self.slug
	end

	def generate_slug
		self.slug = self.send(self.class.slug_column).gsub(' ', '-').downcase
	end

	module ClassMethods
		def sluggable_column(column_name)
			self.slug_column = column_name
		end
	end
end