require_relative '../puppy_breeder.rb'

class TerminaClient
	def start_terminal_client
		puts "Hello! Welcome to PetBreeder Manager v1.0!"
		puts "What is your name?"
		@name = gets.chomp
		PuppyBreeder::Breeder.new(@name)
	end

	def help
		puts "These are the valid commands:"
		puts "create REQUEST - Creates a new purchase request with request=REQUEST"
		puts "add PUPPY - Adds a new puppy for sale with puppy=PUPPY"
		puts "view - View purchase requests"
		puts "completed - View completed purchases"
		puts "transaction - Make a transaction"
		puts "exit"
	end

	def get_input
		puts "What do you want to do? "
		input = gets.chomp
		case input
		when 'create purchase request'

		when 'add puppy for sale'

		when 'view purchase requests'

		when 'view completed purchases'

		when 'make transaction'

		when 'exit'
			puts "PuppyBreeder Manager powering down..."
			exit
		else
			puts "That is not a valid action. Please choose from these functions:"
			self.get_input
		end
	end
end

TerminaClient.new.start_terminal_client