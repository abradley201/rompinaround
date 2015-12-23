class UniversalController < ApplicationController
	def whiteCore

		@gameNumber = GameStat.find_by_account(session[:account]).game
		
		@whiteCoreHP = MapStat.find_by_game(@gameNumber).WhiteCoreHP


		render :json => { :whiteCoreHP => @whiteCoreHP }
		
	end


	def blackCore

		@gameNumber = GameStat.find_by_account(session[:account]).game
		
		@blackCoreHP = MapStat.find_by_game(@gameNumber).BlackCoreHP


		render :json => { :blackCoreHP => @blackCoreHP }
		
	end




	

end