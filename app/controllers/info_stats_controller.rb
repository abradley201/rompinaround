require 'digest/sha1'

class InfoStatsController < ApplicationController

		def new

    		@info = InfoStat.new


            if session[:account] != nil
                redirect_to "/login"
            end

    	end

        def logout

            if BaseStat.find_by_account(session[:account]) != nil

                BaseStat.update(BaseStat.find_by_account(session[:account]).id, :account => nil)

            end

            session[:account] = nil

            redirect_to "/"

        end
	
		def create
    	@info = InfoStat.new(safe_account_params)
        @info.passcode = Digest::SHA1.hexdigest(params[:info_stat][:passcode])
    	if @info.save
      	redirect_to @info
    	else
      	render "BAN"
    	end
  		end

		

		def safe_account_params
      	params.require('info_stat').permit(:account, :passcode)
    	end


    	def show 

    		@info = InfoStat.find(params[:id])

    	end

    	def login

            if session[:account] == nil

                  begin

    		      @info = InfoStat.find_by_account(params[:info_stat][:account])

                  rescue Exception => ex

                    if ex == NoMethodError 
                        render "ANF"
                    end

                  end

    		      if @info.nil? 
    			     render "ANF"
    		      else 

    			     if @info.passcode == Digest::SHA1.hexdigest(params[:info_stat][:passcode])

                        session[:account] = @info.account

                            if GameStat.inGameStat?(session[:account]) == true

                                redirect_to "/board1"

                            else

                                @possibleQuery = BaseStat.find_by_account(session[:account])

                                if @possibleQuery != nil

                                    @gameNumber = @possibleQuery.game

                                else

                                    @gameNumber = -1

                                end

                                if GameStat.inGameStat?(@gameNumber) == true

                                    @yourHero = BaseStat.find_by_account(session[:account]).character
                                    @yourHero_hp = BaseStat.find_by_character(@yourHero).hp
                                    @yourHero_maxhp = BaseStat.find_by_character(@yourHero).maxhp
                                    @yourHero_mp = BaseStat.find_by_character(@yourHero).mp
                                    @yourHero_maxmp = BaseStat.find_by_character(@yourHero).maxmp

                                    GameStat.create(:account => session[:account], :game => @gameNumber, :room => 1, :character => @yourHero, :hp => @yourHero_hp, :maxhp => @yourHero_maxhp, :shield => 0, :mp => @yourHero_mp, :maxmp => @yourHero_maxmp, :pos => 0, :kills => 0, :deaths => 0, :status => "fine", :exp => 0, :allies => "black")

                                    BaseStat.update(BaseStat.find_by_account(session[:account]).id, :account => nil, :game => nil)

                                    redirect_to "/board1"

                                end

                            end


    			     else
    				    render "PNM"
    			     end

    		      end

                

            else

                if GameStat.inGameStat?(session[:account]) == true

                    redirect_to "/board1"

                else

                    @possibleQuery = BaseStat.find_by_account(session[:account])

                    if @possibleQuery != nil

                        @gameNumber = @possibleQuery.game

                    else

                        @gameNumber = -1

                    end

                    if GameStat.inGameStat?(@gameNumber) == true

                        @yourHero = BaseStat.find_by_account(session[:account]).character
                        @yourHero_hp = BaseStat.find_by_character(@yourHero).hp
                        @yourHero_maxhp = BaseStat.find_by_character(@yourHero).maxhp
                        @yourHero_mp = BaseStat.find_by_character(@yourHero).mp
                        @yourHero_maxmp = BaseStat.find_by_character(@yourHero).maxmp

                        GameStat.create(:account => session[:account], :game => @gameNumber, :room => 1, :character => @yourHero, :hp => @yourHero_hp, :maxhp => @yourHero_maxhp, :shield => 0, :mp => @yourHero_mp, :maxmp => @yourHero_maxmp, :pos => 0, :kills => 0, :deaths => 0, :status => "fine", :exp => 0, :allies => "black")

                        BaseStat.update(BaseStat.find_by_account(session[:account]).id, :account => nil, :game => nil)

                        redirect_to "/board1"

                    end

                end

            end

    	end  


        def record

            if session[:account] != nil

            @wins = InfoStat.find_by_account(session[:account]).wins

            @losses = InfoStat.find_by_account(session[:account]).losses

            else

            @wins = 0

            @losses = 0

            end

            render :json => { :wins => @wins, :losses => @losses }

        end	

end