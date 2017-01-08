class DuelmatcherController < ApplicationController

	def makematch

		gameOngoing = GameStat.find_by_account(session[:account])

		@gameNumber = nil

		if gameOngoing == nil

			if BaseStat.find_by_account(session[:account]) != nil

				if BaseStat.find_by_account(session[:account]).game != nil

					@gameNumber = BaseStat.find_by_account(session[:account]).game

					@yourHero = BaseStat.find_by_account(session[:account]).character
					@yourHero_hp = BaseStat.find_by_character(@yourHero).hp
					@yourHero_maxhp = BaseStat.find_by_character(@yourHero).maxhp
					@yourHero_mp = BaseStat.find_by_character(@yourHero).mp
					@yourHero_maxmp = BaseStat.find_by_character(@yourHero).maxmp


					GameStat.create(:account => session[:account], :game => @gameNumber, :room => 1, :character => @yourHero, :hp => @yourHero_hp, :maxhp => @yourHero_maxhp, :shield => 0, :mp => @yourHero_mp, :maxmp => @yourHero_maxmp, :pos => 0, :kills => 0, :deaths => 0, :status => "fine", :exp => 0, :allies => "black")


					BaseStat.update(BaseStat.find_by_account(session[:account]).id, :account => nil, :game => nil)


					@otherAccount = BaseStat.find_by_game(@gameNumber).account
					@otherHero = BaseStat.find_by_account(@otherAccount).character
					@otherHero_hp = BaseStat.find_by_character(@otherHero).hp
					@otherHero_maxhp = BaseStat.find_by_character(@otherHero).maxhp
					@otherHero_mp = BaseStat.find_by_character(@otherHero).mp
					@otherHero_maxmp = BaseStat.find_by_character(@otherHero).maxmp

					#for other account
					GameStat.create(:account => @otherAccount, :game => @gameNumber, :room => 1, :character => @otherHero, :hp => @otherHero_hp, :maxhp => @otherHero_maxhp, :shield => 0, :mp => @otherHero_mp, :maxmp => @otherHero_maxmp, :pos => 0, :kills => 0, :deaths => 0, :status => "fine", :exp => 0, :allies => "black")
					#for other account
					BaseStat.update(BaseStat.find_by_account(@otherAccount).id, :account => nil, :game => nil)

					render :json => { :account => @otherAccount }

				end

			end

			if @gameNumber == nil

				otherAccount = BaseStat.ready4play(session[:account])

				if otherAccount != false && BaseStat.find_by_account(otherAccount).character != params[:character]

					validHeroes = BaseStat.pluck(:character)

					if validHeroes.include? params[:character]

						@yourHero = params[:character]
						@yourHero_hp = BaseStat.find_by_character(@yourHero).hp
						@yourHero_maxhp = BaseStat.find_by_character(@yourHero).maxhp
						@yourHero_mp = BaseStat.find_by_character(@yourHero).mp
						@yourHero_maxmp = BaseStat.find_by_character(@yourHero).maxmp

						@TheGames = GameStat.pluck(:game)

						if @TheGames.length == 0

							@gameNumber = 0

						else

							@TheGames = @TheGames.sort

							@gameNumber = @TheGames.last + 1

						end

						BaseStat.update(BaseStat.find_by_account(otherAccount).id, :game => @gameNumber)
					
						GameStat.create(:account => session[:account], :game => @gameNumber, :room => 1, :character => @yourHero, :hp => @yourHero_hp, :maxhp => @yourHero_maxhp, :shield => 0, :mp => @yourHero_mp, :maxmp => @yourHero_maxmp, :pos => 0, :kills => 0, :deaths => 0, :status => "fine", :exp => 0, :allies => "white")


					render :json => { :account => otherAccount }

					else 

					render :json => { :account => false }

					end

				elsif otherAccount == false && BaseStat.find_by_account(session[:account]) != nil

					if BaseStat.find_by_account(session[:account]).character != params[:character]

						BaseStat.update(BaseStat.find_by_account(session[:account]).id, :account => nil)

						BaseStat.update(BaseStat.find_by_character(params[:character]).id, :account => session[:account])

					end

					render :json => { :account => false }

				elsif otherAccount == false && BaseStat.find_by_account(session[:account]) == nil

					BaseStat.update(BaseStat.find_by_character(params[:character]).id, :account => session[:account])

					render :json => { :account => false }

				elsif otherAccount != false && BaseStat.find_by_account(otherAccount).character == params[:character]

					render :json => { :account => "mirror" }

				else

					render :json => { :account => false }
		
				end

			end

		else

			render :json => { :account => "gameOngoing" }

		end

    end

        def cancelsearch

        	if BaseStat.inBaseStat?(session[:account]) == true

        		if BaseStat.find_by_account(session[:account]).game == nil

				BaseStat.update(BaseStat.find_by_account(session[:account]).id, :account => nil)

				render :json => { :account => true }

				else

				render :json => { :account => false }

				end

			else 

				render :json => { :account => true }

        	end

        end

end
