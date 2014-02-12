module ApplicationHelper
	def error_text(instance)
		model = instance.class.to_s

		if instance.errors.count == 1
			"1 error prevented #{model}"
		else
			"#{instance.errors.count} errors prevented #{model}"
		end
	end

	def fix_url(str)
		str.starts_with?('http://') ? str : "http://#{str}"
	end
end
