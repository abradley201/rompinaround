class GameStat < ActiveRecord::Base

	def self.inGameStat?(sessionAccount)

		accountArray = GameStat.pluck(:account)

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