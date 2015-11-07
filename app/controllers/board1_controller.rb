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
		

    #give positions when pos == 0, based on allies being white/black
    #create Boardcode for map_stats
    #use .split and .join for arrays
    #['f', 'o', 'o', 'o'].reject(&:empty?).join(' ')

    
	end









	

end