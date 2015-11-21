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


					GameStat.create(:account => session[:account], :game => @gameNumber, :character => @yourHero, :hp => @yourHero_hp, :maxhp => @yourHero_maxhp, :shield => 0, :mp => @yourHero_mp, :maxmp => @yourHero_maxmp, :pos => 0, :kills => 0, :deaths => 0, :exp => 0, :allies => "black", :action => 0)


					BaseStat.update(BaseStat.find_by_account(session[:account]).id, :account => nil, :game => nil)


					otherAccount = GameStat.find_by_game(@gameNumber).account

					render :json => { :account => otherAccount }

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
					
						GameStat.create(:account => session[:account], :game => @gameNumber, :character => @yourHero, :hp => @yourHero_hp, :maxhp => @yourHero_maxhp, :shield => 0, :mp => @yourHero_mp, :maxmp => @yourHero_maxmp, :pos => 0, :kills => 0, :deaths => 0, :exp => 0, :allies => "white", :action => 0)


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