class BaseStat < ActiveRecord::Base

	def self.ready4play(sessionAccount)

		accountArray = BaseStat.pluck(:account)

		validAccounts = Array.new

		y = 0

			while y < accountArray.length

				if accountArray[y] != sessionAccount && accountArray[y] != nil

					validAccounts.push(accountArray[y])

				end

				y = y + 1

			end

		if validAccounts.length >= 1

			z = rand(validAccounts.length)

			return validAccounts[z]


		else 

			return false

		end

		

		
	end

	def self.inBaseStat?(sessionAccount)

		accountArray = BaseStat.pluck(:account)

		validAccounts = Array.new

		y = 0

			while y < accountArray.length

				if accountArray[y] == sessionAccount

					validAccounts.push(accountArray[y])

				end

				y = y + 1

			end

		if validAccounts.length >= 1


			return true


		else 

			return false

		end


	end

	

end