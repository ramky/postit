module ApplicationHelper
	def model_name(instance)
		instance.class.to_s
	end

	def error_text(instance)
		if instance.errors.count == 1
			"1 error"
		else
			"#{instance.errors.count} errors"
		end
	end
end
