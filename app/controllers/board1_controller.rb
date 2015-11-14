class Board1Controller < ApplicationController
	def go1

		@SelectedHero = GameStat.find_by_account(session[:account]).character
		@gameNumber = GameStat.find_by_account(session[:account]).game
		@gameArray = GameStat.where(game:@gameNumber)
		if @gameArray.first.account != session[:account]
			@enemyHero = @gameArray.first.character
		else
			@enemyHero = @gameArray.last.character
		end

		if GameStat.find_by_account(session[:account]).pos == 0

			if GameStat.find_by_account(session[:account]).allies == "white"

				GameStat.update(GameStat.find_by_account(session[:account]).id, :pos => 7)

			else

				GameStat.update(GameStat.find_by_account(session[:account]).id, :pos => 112)

			end

		end

		

    #give positions when pos == 0, based on allies being white/black
    #create Boardcode for map_stats
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