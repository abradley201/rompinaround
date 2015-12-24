class Board1Controller < ApplicationController

	def go1

		begin

		@yourHero = GameStat.find_by_account(session[:account]).character

		@gameNumber = GameStat.find_by_account(session[:account]).game

		@gameArray = GameStat.where(game:@gameNumber)


		if @gameArray.first.account != session[:account]

			@enemyHero = @gameArray.first.character
			@enemyAccount = @gameArray.first.account

		else

			@enemyHero = @gameArray.last.character
			@enemyAccount = @gameArray.last.account

		end


		if GameStat.find_by_account(session[:account]).pos == 0

			if GameStat.find_by_account(session[:account]).allies == "white"

				GameStat.update(GameStat.find_by_account(session[:account]).id, :pos => 7)

			else

				GameStat.update(GameStat.find_by_account(session[:account]).id, :pos => 112)

			end

		end

		if GameStat.find_by_account(@enemyAccount).pos == 0

			if GameStat.find_by_account(@enemyAccount).allies == "white"

				GameStat.update(GameStat.find_by_account(@enemyAccount).id, :pos => 7)

			else

				GameStat.update(GameStat.find_by_account(@enemyAccount).id, :pos => 112)

			end

		end


		if MapStat.find_by_game(@gameNumber) == nil

		MapStat.create(:game => @gameNumber, :creation => Time.now.to_i, :map => "f n n n n n n o n n o f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f o n n o n n n n n n f f", :e => 12, :WhiteCoreHP => 300, :BlackCoreHP => 300, :WhiteCorePOS => 10, :BlackCorePOS => 109)

		end


		@yourStats = GameStat.find_by(game:@gameNumber, character:@yourHero)
		@enemyStats = GameStat.find_by(game:@gameNumber, character:@enemyHero)


		@yourHp = @yourStats.hp
		@yourMaxhp = @yourStats.maxhp
		@yourShield = @yourStats.shield
		@yourMp = @yourStats.mp
		@yourMaxmp = @yourStats.maxmp
		@yourPos = @yourStats.pos
		@yourKills = @yourStats.kills
		@yourDeaths = @yourStats.deaths
		@yourStatus = @yourStats.status
		@yourExp = @yourStats.exp
		@yourAllies = @yourStats.allies

		@enemyHp = @enemyStats.hp
		@enemyMaxhp = @enemyStats.maxhp
		@enemyShield = @enemyStats.shield
		@enemyMp = @enemyStats.mp
		@enemyMaxmp = @enemyStats.maxmp
		@enemyPos = @enemyStats.pos
		@enemyKills = @enemyStats.kills
		@enemyDeaths = @enemyStats.deaths
		@enemyStatus = @enemyStats.status
		@enemyExp = @enemyStats.exp
		@enemyAllies = @enemyStats.allies


			rescue Exception => ex

                    if ex.class == NoMethodError 
                        redirect_to "/"
                    end

                  end

    
	end








	

end