class UniversalController < ApplicationController

		
		def regen(x,y)

				@yourHero = x

			if @yourHero.hp == @yourHero.maxhp && @yourHero.mp == @yourHero.maxmp

			return

			end

				@gameNumber = y

				@WhiteRegenSquare = MapStat.find_by_game(@gameNumber).WhiteRespawnSquare

	  			@BlackRegenSquare = MapStat.find_by_game(@gameNumber).BlackRespawnSquare

	    		@statusArray = @yourHero.status.split("⚕")

	    		@lastRegen = @statusArray[1].to_f

			if (Time.now.to_f.round(3) - @lastRegen) >= 1

				if @yourHero.pos == @WhiteRegenSquare || @yourHero.pos == @BlackRegenSquare

					@newHP = @yourHero.hp + 100

					@newMP = @yourHero.mp + 50

				else

					@newHP = @yourHero.hp + 2

					@newMP = @yourHero.mp + 4

				end

				if @newHP > @yourHero.maxhp

					@newHP = @yourHero.maxhp

				end

				if @newMP > @yourHero.maxmp

					@newMP = @yourHero.maxmp

				end

				GameStat.update(@yourHero.id, :hp => @newHP)

				GameStat.update(@yourHero.id, :mp => @newMP)

				@statusArray[1] = "⚕#{Time.now.to_f.round(3)}⚕"

				@status = @statusArray.join

				GameStat.update(@yourHero.id, :status => @status)

	    	end


		end



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


		if @yourHero.character == "Joan" && @yourHero.status.include?("♱") == true

			#needs a way to expire without command, using pacemaker

			@statusArray = @yourHero.status.split("♱")

			@buffTimer = @statusArray[1].to_f

				if Time.now.to_f.round(3) - @buffTimer >= 5

					@statusArray[0].slice! "crusade"

					@statusArray.delete_at(1)

					@status = @statusArray.join

					GameStat.update(@yourHero.id, :status => @status)

				end

			m = 0.65

		else

			m = 1

		end


		if Time.now.to_f.round(3) - @yourHero.moved >= m && ["w","a","s","d"].include?(params[:command]) == true
			@canMove = true
		end

		if Time.now.to_f.round(3) - @yourHero.attacked >= 1 && params[:command].slice(0) == "1"
			@canAttack = true
		end

		if Time.now.to_f.round(3) - @yourHero.casted >= 1 && ["e"].include?(params[:command].slice(0)) == true
			@canCast = true
		end


		if @yourHero.status.include?("†") == true
			@canMove = false
			@canAttack = false
			@canCast = false
		end


		def EnemyHeroDeath()

			GameStat.update(@enemyHero.id, :deaths => @enemyHero.deaths + 1)

			GameStat.update(@yourHero.id, :kills => @yourHero.kills + 1)

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

		def CoreDeath(x)

			if x == "white"

				@winningAccountRow = GameStat.where(:game => @gameNumber).where(:allies => "black")

				@winningAccount = @winningAccountRow.first.account

				@CW = InfoStat.find_by_account(@winningAccount).wins

				@losingAccountRow = GameStat.where(:game => @gameNumber).where(:allies => "white")

				@losingAccount = @losingAccountRow.first.account

				@CL = InfoStat.find_by_account(@losingAccount).losses

				InfoStat.update(InfoStat.find_by_account(@winningAccount).id, :wins => @CW + 1)

				InfoStat.update(InfoStat.find_by_account(@losingAccount).id, :losses => @CL + 1)

			end

			if x == "black"

				@winningAccountRow = GameStat.where(:game => @gameNumber).where(:allies => "white")

				@winningAccount = @winningAccountRow.first.account

				@CW = InfoStat.find_by_account(@winningAccount).wins

				@losingAccountRow = GameStat.where(:game => @gameNumber).where(:allies => "black")

				@losingAccount = @losingAccountRow.first.account

				@CL = InfoStat.find_by_account(@losingAccount).losses

				InfoStat.update(InfoStat.find_by_account(@winningAccount).id, :wins => @CW + 1)

				InfoStat.update(InfoStat.find_by_account(@losingAccount).id, :losses => @CL + 1)

			end

		end

		def AttackDamage(x)

			if x == "Joan"

				return 55

			end

			if x == "Ima"

				return 65

			end

			if x == "Steph"

				return 45

			end

		end

		def CoreDamage(y)

			if params[:command].slice(2,100).to_i == MapStat.find_by_game(@gameNumber).WhiteCorePOS && @yourHero.allies == "black"

				if MapStat.find_by_game(@gameNumber).BlackCoreHP > 0

					@whiteCoreHP = MapStat.find_by_game(@gameNumber).WhiteCoreHP - y

				end

				if @whiteCoreHP <= 0

					@whiteCoreHP = 0

					CoreDeath("white")

				end

				MapStat.update(MapStat.find_by_game(@gameNumber).id, :WhiteCoreHP => @whiteCoreHP)

			end

			if params[:command].slice(2,100).to_i == MapStat.find_by_game(@gameNumber).BlackCorePOS && @yourHero.allies == "white"

				if MapStat.find_by_game(@gameNumber).WhiteCoreHP > 0

					@blackCoreHP = MapStat.find_by_game(@gameNumber).BlackCoreHP - y

				end

				if @blackCoreHP <= 0

					@blackCoreHP = 0

					CoreDeath("black")

				end

				MapStat.update(MapStat.find_by_game(@gameNumber).id, :BlackCoreHP => @blackCoreHP)

			end

		end

		def DamageEnemy(z)

			if @enemyHero.hp != 0

				@newHP = @enemyHero.hp - z

					if @newHP <= 0

						@newHP = 0

						EnemyHeroDeath()

					end

				GameStat.update(@enemyHero.id, :hp => @newHP)

			end

		end


		if @canMove == true

			regen(@yourHero,@gameNumber)

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

			regen(@yourHero,@gameNumber)

		#make this more dynamic, so it can hit things other than 1 enemy

		#slice(2,100) needs to be changed so that 100 is dynamic


			if (params[:command].slice(2,100).to_i - @yourHero.pos).abs == 1 || (params[:command].slice(2,100).to_i - @yourHero.pos).abs == e


				if @enemyHero.pos == params[:command].slice(2,100).to_i

					DamageEnemy(AttackDamage(@yourHero.character)) 

				end
					
				CoreDamage(AttackDamage(@yourHero.character))

				GameStat.update(@yourHero.id, :attacked => Time.now.to_f.round(3))


		    end

			render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }


		end

		if @canCast == true && params[:command].slice(0) == "e"

			regen(@yourHero,@gameNumber)

			if @yourHero.character == "Joan" && @yourHero.mp >= 60

				GameStat.update(@yourHero.id, :status => "#{@yourHero.status}crusade♱#{Time.now.to_f.round(3)}♱")

				GameStat.update(@yourHero.id, :mp => @yourHero.mp - 60)

				GameStat.update(@yourHero.id, :casted => Time.now.to_f.round(3))

			end

			if @yourHero.character == "Ima" && @yourHero.mp >= 70

				#need to fix the board wrap-around problem here: Distancetx etc. needed server side. OR use mapstats, checking for f

				@TargetArray = [@yourHero.pos + 3 * e, @yourHero.pos - 3 * e, @yourHero.pos + 3, @yourHero.pos - 3, @yourHero.pos + 1 + 2 * e, @yourHero.pos + 2 + e, @yourHero.pos + 2 - e, @yourHero.pos + 1 - 2 * e, @yourHero.pos - 1 - 2 * e, @yourHero.pos - 2 - e, @yourHero.pos - 2 + e, @yourHero.pos - 1 + 2 * e];

				if @TargetArray.include?(params[:command].slice(2,100).to_i) == true && @enemyHero.pos == params[:command].slice(2,100).to_i

					DamageEnemy(120) 

				end

				CoreDamage(120)

				GameStat.update(@yourHero.id, :mp => @yourHero.mp - 70)

				GameStat.update(@yourHero.id, :casted => Time.now.to_f.round(3))	

			end

			if @yourHero.character == "Steph" && @yourHero.mp >= 40

				@mapInfo = MapStat.find_by_game(@gameNumber).map.split

				q = 1

				while @mapInfo[@yourHero.pos + q] != "f"

				 @TargetArray.push(@yourHero.pos + q)

				 q = q + 1

				end

				w = 1

				while @mapInfo[@yourHero.pos - w] != "f"

				 @TargetArray.push(@yourHero.pos - w)

				 w = w + 1

				end

				qq = 1

				while @mapInfo[@yourHero.pos + qq * e] != "f"

				 @TargetArray.push(@yourHero.pos + qq * e)

				 qq = qq + 1

				end

				ww = 1

				while @mapInfo[@yourHero.pos - ww * e] != "f"

				 @TargetArray.push(@yourHero.pos - ww * e)

				 ww = ww + 1

				end

				if @TargetArray.include?(params[:command].slice(2,100).to_i) == true && @enemyHero.pos == params[:command].slice(2,100).to_i

					DamageEnemy(AttackDamage(@yourHero.character)) 

				end

				CoreDamage(AttackDamage(@yourHero.character))

				GameStat.update(@yourHero.id, :mp => @yourHero.mp - 40)

				GameStat.update(@yourHero.id, :casted => Time.now.to_f.round(3))

			end

			render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		end
		
		if [@canMove, @canAttack, @canCast].include?(true) == false

			render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		end

	  else

	  render :json => { :gameOver => "true" }

	  end


	end



	#add buttons for skills on UI

	def pacemaker

	  @yourHero = GameStat.find_by_account(session[:account])

	  @gameNumber = GameStat.find_by_account(session[:account]).game

	  if @yourHero != nil

	  		if @yourHero.status.include?("⚕") == true

	  			regen(@yourHero,@gameNumber)

	  		end

			if @yourHero.status.include?("†") == true

				@whenDied = @yourHero.status.split("†")[1].to_f

				if (Time.now.to_f.round(3) - @whenDied) >= (2 + (@yourHero.deaths * 3)) 

					GameStat.update(@yourHero.id, :hp => @yourHero.maxhp)

					GameStat.update(@yourHero.id, :status => "regen⚕#{Time.now.to_f.round(3)}⚕")

				end

			end


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



		if @whiteCoreHP == 0 

		render :json => { :gameOver => "blackWins", :whiteCoreHP => @whiteCoreHP, :blackCoreHP => @blackCoreHP, :whiteRespawnSquare => @whiteRespawnSquare, :blackRespawnSquare => @blackRespawnSquare, :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		elsif @blackCoreHP == 0

		render :json => { :gameOver => "whiteWins", :whiteCoreHP => @whiteCoreHP, :blackCoreHP => @blackCoreHP, :whiteRespawnSquare => @whiteRespawnSquare, :blackRespawnSquare => @blackRespawnSquare, :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		else

		render :json => { :gameOver => "false", :whiteCoreHP => @whiteCoreHP, :blackCoreHP => @blackCoreHP, :whiteRespawnSquare => @whiteRespawnSquare, :blackRespawnSquare => @blackRespawnSquare, :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies }

		end

	  else

	  render :json => { :gameOver => "true" }

	  end



	end




	def endgameButton

		@game = GameStat.find_by_account(session[:account])

		if @game != nil

			@gameNumber = @game.game


			@whiteCoreHP = MapStat.find_by_game(@gameNumber).WhiteCoreHP

			@blackCoreHP = MapStat.find_by_game(@gameNumber).BlackCoreHP



			if @whiteCoreHP == 0 || @blackCoreHP == 0

			render :json => { :gameOver => "true" }

			else

		    render :json => { :gameOver => "false" }

			end

		else

	  	render :json => { :gameOver => "nogame" }

	  	end

	end


	def endgame

		@game = GameStat.find_by_account(session[:account])

		if @game != nil

			@gameNumber = @game.game


			@whiteCoreHP = MapStat.find_by_game(@gameNumber).WhiteCoreHP

			@blackCoreHP = MapStat.find_by_game(@gameNumber).BlackCoreHP



			if @whiteCoreHP == 0 || @blackCoreHP == 0

				MapStat.where(game:@gameNumber).delete_all

				GameStat.where(game:@gameNumber).delete_all

				render :json => { :gameOver => "true" }

			else

		    	render :json => { :gameOver => "false" }

			end

		else

	  	render :json => { :gameOver => "nogame" }

	  	end

	
	end

				


	

end