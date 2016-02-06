class UniversalController < ApplicationController



	def command


	  @yourHero = GameStat.find_by_account(session[:account])

	  if @yourHero != nil



		@gameNumber = GameStat.find_by_account(session[:account]).game

		@gameArray = GameStat.where(game:@gameNumber)

		if @gameArray.first.account != session[:account]

			@enemyHero = @gameArray.first

		else

			@enemyHero = @gameArray.last

		end

		@canMove = false
		@canAttack = false
		@canCast = false


		#@room = GameStat.find_by_account(session[:account]).room

		#also need to find_by_room:
		
		
		e = MapStat.find_by_game(@gameNumber).e



		if Time.now.to_f.round(3) - @yourHero.moved >= 1 && ["w","a","s","d"].include?(params[:command]) == true
			@canMove = true
		end

		if Time.now.to_f.round(3) - @yourHero.attacked >= 1 && params[:command].slice(0) == "1"
			@canAttack = true
		end


		if @yourHero.status.include?("†") == true
			@canMove = false
			@canAttack = false
			@canCast = false
		end


		if @canMove == true

			@firstValidation = false

			@secondValidation = false

			@mapInfo = MapStat.find_by_game(@gameNumber).map.split

			@WRS = MapStat.find_by_game(@gameNumber).WhiteRespawnSquare

			@BRS = MapStat.find_by_game(@gameNumber).BlackRespawnSquare

			if params[:command] == "w"

				if @yourHero.pos - e > 0 && @mapInfo[@yourHero.pos - e] == "n"

					@firstValidation = true

				end

				if @yourHero.allies == "white" && @yourHero.pos - e != @BRS

					@secondValidation = true

				end

				if @yourHero.allies == "black" && @yourHero.pos - e != @WRS

					@secondValidation = true

				end

				if @firstValidation == true && @secondValidation == true

					@mapInfo[@yourHero.pos] = "n"

					@mapInfo[@yourHero.pos - e] = "o"

					@mapInfo = @mapInfo.reject(&:empty?).join(' ')

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					GameStat.update(@yourHero.id, :pos => @yourHero.pos - e)

					GameStat.update(@yourHero.id, :moved => Time.now.to_f.round(3))
					
					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

				else

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

				end

			end

			if params[:command] == "a"

				if @yourHero.pos - 1 > 0 && @mapInfo[@yourHero.pos - 1] == "n"

					@firstValidation = true

				end

				if @yourHero.allies == "white" && @yourHero.pos - 1 != @BRS

					@secondValidation = true

				end

				if @yourHero.allies == "black" && @yourHero.pos - 1 != @WRS

					@secondValidation = true

				end

				if @firstValidation == true && @secondValidation == true

					@mapInfo[@yourHero.pos] = "n"

					@mapInfo[@yourHero.pos - 1] = "o"

					@mapInfo = @mapInfo.reject(&:empty?).join(' ')

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					GameStat.update(@yourHero.id, :pos => @yourHero.pos - 1)

					GameStat.update(@yourHero.id, :moved => Time.now.to_f.round(3))

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

				else

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

				end

			end

			if params[:command] == "s"

				if @yourHero.pos + e < 119 && @mapInfo[@yourHero.pos + e] == "n"

					@firstValidation = true

				end

				if @yourHero.allies == "white" && @yourHero.pos + e != @BRS

					@secondValidation = true

				end

				if @yourHero.allies == "black" && @yourHero.pos + e != @WRS

					@secondValidation = true

				end

				if @firstValidation == true && @secondValidation == true

					@mapInfo[@yourHero.pos] = "n"

					@mapInfo[@yourHero.pos + e] = "o"

					@mapInfo = @mapInfo.reject(&:empty?).join(' ')

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					GameStat.update(@yourHero.id, :pos => @yourHero.pos + e)

					GameStat.update(@yourHero.id, :moved => Time.now.to_f.round(3))

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

				else

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

				end

			end

			if params[:command] == "d"

				if @yourHero.pos + 1 < 119 && @mapInfo[@yourHero.pos + 1] == "n"

					@firstValidation = true

				end

				if @yourHero.allies == "white" && @yourHero.pos + 1 != @BRS

					@secondValidation = true

				end

				if @yourHero.allies == "black" && @yourHero.pos + 1 != @WRS

					@secondValidation = true

				end

				if @firstValidation == true && @secondValidation == true

					@mapInfo[@yourHero.pos] = "n"

					@mapInfo[@yourHero.pos + 1] = "o"

					@mapInfo = @mapInfo.reject(&:empty?).join(' ')

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					GameStat.update(@yourHero.id, :pos => @yourHero.pos + 1)

					GameStat.update(@yourHero.id, :moved => Time.now.to_f.round(3))

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

				else

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

				end

			end

	
		end

		if @canAttack == true 



		#make this more dynamic, so it can hit things other than 1 enemy

		#slice(2,100) needs to be changed so that 100 is dynamic



			if (params[:command].slice(2,100).to_i - @yourHero.pos).abs == 1 || (params[:command].slice(2,100).to_i - @yourHero.pos).abs == e


				if @enemyHero.pos == params[:command].slice(2,100).to_i

				  if @enemyHero.hp != 0

					@newHP = @enemyHero.hp - 25

					if @newHP <= 0

						@newHP = 0

						GameStat.update(@enemyHero.id, :status => "dead†#{Time.now.to_f.round(3)}†")

						@mapInfo = MapStat.find_by_game(@gameNumber).map.split

						@WRS = MapStat.find_by_game(@gameNumber).WhiteRespawnSquare

						@BRS = MapStat.find_by_game(@gameNumber).BlackRespawnSquare


						@mapInfo[@enemyHero.pos] = "n"

							if @enemyHero.allies == "black"

								@mapInfo[@BRS] = "o"

								GameStat.update(@enemyHero.id, :pos => @BRS)

							else 

								@mapInfo[@WRS] = "o"

								GameStat.update(@enemyHero.id, :pos => @WRS)

							end

						@mapInfo = @mapInfo.reject(&:empty?).join(' ')

						MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					end

				    GameStat.update(@enemyHero.id, :hp => @newHP)

				  end

				end

				if params[:command].slice(2,100).to_i == MapStat.find_by_game(@gameNumber).WhiteCorePOS && @yourHero.allies == "black"

					if MapStat.find_by_game(@gameNumber).BlackCoreHP > 0

					@whiteCoreHP = MapStat.find_by_game(@gameNumber).WhiteCoreHP - 25

					end

					if @whiteCoreHP <= 0

						@whiteCoreHP = 0

						@winningAccountRow = GameStat.where(:game => @gameNumber).where(:allies => "black")

						@winningAccount = @winningAccountRow.first.account

						@CW = InfoStat.find_by_account(@winningAccount).wins

						@losingAccountRow = GameStat.where(:game => @gameNumber).where(:allies => "white")

						@losingAccount = @losingAccountRow.first.account

						@CL = InfoStat.find_by_account(@losingAccount).losses

						InfoStat.update(InfoStat.find_by_account(@winningAccount).id, :wins => @CW + 1)

						InfoStat.update(InfoStat.find_by_account(@losingAccount).id, :losses => @CL + 1)


					end

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :WhiteCoreHP => @whiteCoreHP)


				end

				if params[:command].slice(2,100).to_i == MapStat.find_by_game(@gameNumber).BlackCorePOS && @yourHero.allies == "white"

					if MapStat.find_by_game(@gameNumber).WhiteCoreHP > 0

					@blackCoreHP = MapStat.find_by_game(@gameNumber).BlackCoreHP - 25

					end

					if @blackCoreHP <= 0

						@blackCoreHP = 0

						@winningAccountRow = GameStat.where(:game => @gameNumber).where(:allies => "white")

						@winningAccount = @winningAccountRow.first.account

						@CW = InfoStat.find_by_account(@winningAccount).wins

						@losingAccountRow = GameStat.where(:game => @gameNumber).where(:allies => "black")

						@losingAccount = @losingAccountRow.first.account

						@CL = InfoStat.find_by_account(@losingAccount).losses

						InfoStat.update(InfoStat.find_by_account(@winningAccount).id, :wins => @CW + 1)

						InfoStat.update(InfoStat.find_by_account(@losingAccount).id, :losses => @CL + 1)


					end

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :BlackCoreHP => @blackCoreHP)


				end

				GameStat.update(@yourHero.id, :attacked => Time.now.to_f.round(3))

			end


				render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		end

		#how to include @canCast here? use @firstValidation && @secondValidation
		
		if @canMove == false && @canAttack == false

			render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		end

	  else

	  render :json => { :gameOver => "true" }

	  end


	end




	#add buttons for skills on UI

	def pacemaker

	  @yourHero = GameStat.find_by_account(session[:account])

	  if @yourHero != nil


			if @yourHero.status.include?("†") == true

				@whenDied = @yourHero.status.split("†")[1].to_f

				if (Time.now.to_f.round(3) - @whenDied) >= 5 

					GameStat.update(@yourHero.id, :hp => @yourHero.maxhp)

					GameStat.update(@yourHero.id, :status => "fine")

				end

			end


		@gameNumber = GameStat.find_by_account(session[:account]).game

		@gameArray = GameStat.where(game:@gameNumber)

		if @gameArray.first.account != session[:account]

			@enemyHero = @gameArray.first

		else

			@enemyHero = @gameArray.last

		end

		@whiteCoreHP = MapStat.find_by_game(@gameNumber).WhiteCoreHP

		@blackCoreHP = MapStat.find_by_game(@gameNumber).BlackCoreHP

		@whiteRespawnSquare = MapStat.find_by_game(@gameNumber).WhiteRespawnSquare

		@blackRespawnSquare = MapStat.find_by_game(@gameNumber).BlackRespawnSquare



		if @whiteCoreHP <= 0 

		render :json => { :gameOver => "blackWins", :whiteCoreHP => @whiteCoreHP, :blackCoreHP => @blackCoreHP, :whiteRespawnSquare => @whiteRespawnSquare, :blackRespawnSquare => @blackRespawnSquare, :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		elsif @blackCoreHP <= 0

		render :json => { :gameOver => "whiteWins", :whiteCoreHP => @whiteCoreHP, :blackCoreHP => @blackCoreHP, :whiteRespawnSquare => @whiteRespawnSquare, :blackRespawnSquare => @blackRespawnSquare, :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		else

		render :json => { :gameOver => "false", :whiteCoreHP => @whiteCoreHP, :blackCoreHP => @blackCoreHP, :whiteRespawnSquare => @whiteRespawnSquare, :blackRespawnSquare => @blackRespawnSquare, :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		end

	  else

	  render :json => { :gameOver => "true" }

	  end



	end




	def endgame

		@game = GameStat.find_by_account(session[:account])

		if @game != nil

			@gameNumber = @game.game


			@whiteCoreHP = MapStat.find_by_game(@gameNumber).WhiteCoreHP

			@blackCoreHP = MapStat.find_by_game(@gameNumber).BlackCoreHP


			if @whiteCoreHP == 0 || @blackCoreHP == 0

			sleep(5)

			MapStat.where(game:@gameNumber).delete_all

			GameStat.where(game:@gameNumber).delete_all

			render :json => { :gameOver => "true" }

			else

		    render :json => { :gameOver => "false" }

			end

		else

	  	render :json => { :gameOver => "true" }

	  	end

	end



				


	

end