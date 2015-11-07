class Board1Controller < ApplicationController
	def go1

		@SelectedHero = GameStat.find_by_account(session[:account]).character

    #find out who SelectedHero is
    #give positions when pos == 0, based on allies being white/black
    #create Boardcode for map_stats
    #use .split and .join for arrays
    #['f', 'o', 'o', 'o'].reject(&:empty?).join(' ')

    
	end









	

end