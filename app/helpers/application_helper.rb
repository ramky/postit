module ApplicationHelper
	def model_name(instance)
		instance.class.to_s
	end
end
