class Message < ActiveRecord::Base
	include ActiveModel::Model
	include Post 

	@priority
	@text

	def initialize(single_message_hash)
    	@priority = single_message_hash[:priority]
    	@text= single_message_hash[:text]
	end

	def priority
		@priority
	end

	def text
		@text.html_safe
	end

	def is_critical
		if @priority == "high"
			return true
		else
			return false
		end
	end


end
