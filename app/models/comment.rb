class Comment < ActiveRecord::Base
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	belongs_to :post
	has_many   :votes, as: :voteable

	validates :body, presence: :true

	def total_votes
		votes = up_votes - down_votes
		votes.to_s + ( [-1,0,1].include?(votes) ? ' Vote' : ' Votes' )
	end

	def up_votes
		self.votes.where(vote: :true).size
	end

	def down_votes
		self.votes.where(vote: :false).size
	end
end