class Movie < ActiveRecord::Base
	def self.ratings
		["G","PG","PG-13","R","NC-17"]
	end

	def self.ratings_hash
		{"G"=>"1","PG"=>"1","PG-13"=>"1","R"=>"1","NC-17"=>"1"}
	end
end
