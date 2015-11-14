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

		MapStat.create(:game => @gameNumber, :turns => 0, :map => "f n n n n n n o n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n n n n n n n n f f n n n o n n n n n n f f", :creation => Time.now.to_i + 5)

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
		@yourAction = @yourStats.action

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
		@enemyAction = @enemyStats.action


			rescue Exception => ex

                    if ex.class == NoMethodError 
                        redirect_to "/"
                    end

                  end
	
    #use .split and .join for arrays
    #['f', 'o', 'o', 'o'].reject(&:empty?).join(' ')

    
	end

	def pacemaker

		@gameNumber = GameStat.find_by_account(session[:account]).game

		@turns = MapStat.find_by_game(@gameNumber).turns

		@creation = MapStat.find_by_game(@gameNumber).creation

		if Time.now.to_i >= @creation + @turns


			#do turn here

			#insert @turn + 1 at end


		else 

			sleep(1)
			
		end




	end







	

end