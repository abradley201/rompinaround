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

    
	end

	def pacemaker

		e = 12


		@yourHero = GameStat.find_by_account(session[:account])

		@gameNumber = GameStat.find_by_account(session[:account]).game

		@gameArray = GameStat.where(game:@gameNumber)

		if @gameArray.first.account != session[:account]

			@enemyHero = @gameArray.first

		else

			@enemyHero = @gameArray.last

		end


		@turns = MapStat.find_by_game(@gameNumber).turns

		@creation = MapStat.find_by_game(@gameNumber).creation


		if Time.now.to_i >= @creation + @turns

			@mapInfo = MapStat.find_by_game(@gameNumber).map.split

			if params[:command] == "w"

				if @yourHero.pos - e > 0 && @mapInfo[@yourHero.pos - e] == "n"

					@mapInfo[@yourHero.pos] = "n"

					@mapInfo[@yourHero.pos - e] = "o"

					@mapInfo = @mapInfo.reject(&:empty?).join(' ')

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					GameStat.update(@yourHero.id, :pos => @yourHero.pos - e)					



					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "successful", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

				else

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "failure", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

				end

			end

			if params[:command] == "a"

				if @yourHero.pos - 1 > 0 && @mapInfo[@yourHero.pos - 1] == "n"

					@mapInfo[@yourHero.pos] = "n"

					@mapInfo[@yourHero.pos - 1] = "o"

					@mapInfo = @mapInfo.reject(&:empty?).join(' ')

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					GameStat.update(@yourHero.id, :pos => @yourHero.pos - 1)



					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "successful", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

				else

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "failure", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

				end

			end

			if params[:command] == "s"

				if @yourHero.pos + e < 119 && @mapInfo[@yourHero.pos + e] == "n"

					@mapInfo[@yourHero.pos] = "n"

					@mapInfo[@yourHero.pos + e] = "o"

					@mapInfo = @mapInfo.reject(&:empty?).join(' ')

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					GameStat.update(@yourHero.id, :pos => @yourHero.pos + e)

					

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "successful", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

				else

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "failure", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

				end

			end

			if params[:command] == "d"

				if @yourHero.pos + 1 < 119 && @mapInfo[@yourHero.pos + 1] == "n"

					@mapInfo[@yourHero.pos] = "n"

					@mapInfo[@yourHero.pos + 1] = "o"

					@mapInfo = @mapInfo.reject(&:empty?).join(' ')

					MapStat.update(MapStat.find_by_game(@gameNumber).id, :map => @mapInfo)

					GameStat.update(@yourHero.id, :pos => @yourHero.pos + 1)

					

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "successful", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

				else

					render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "failure", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

				end

			end

			if params[:command] == "nothing"

				render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "nothing", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }

			end

			

			MapStat.update(MapStat.find_by_game(@gameNumber).id, :turns => @turns + 1)

		else 

			render :json => { :yourHp => @yourHero.hp, :yourMaxhp => @yourHero.maxhp, :yourShield => @yourHero.shield, :yourMp => @yourHero.mp, :yourMaxmp => @yourHero.maxmp, :yourPos => @yourHero.pos, :yourKills => @yourHero.kills, :yourDeaths => @yourHero.deaths, :yourStatus => @yourHero.status, :yourExp => @yourHero.exp, :yourAllies => @yourHero.allies, :yourAction => "outofpace", :enemyHp => @enemyHero.hp, :enemyMaxhp => @enemyHero.maxhp, :enemyShield => @enemyHero.shield, :enemyMp => @enemyHero.mp, :enemyMaxmp => @enemyHero.maxmp, :enemyPos => @enemyHero.pos, :enemyKills => @enemyHero.kills, :enemyDeaths => @enemyHero.deaths, :enemyStatus => @enemyHero.status, :enemyExp => @enemyHero.exp, :enemyAllies => @enemyHero.allies, :enemyAction => @enemyHero.action }
			
		end




	end







	

end