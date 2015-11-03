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

    		      @info = InfoStat.find_by_account(params[:info_stat][:account])

    		      if @info.nil? 
    			     render "ANF"
    		      else 

    			     if @info.passcode == Digest::SHA1.hexdigest(params[:info_stat][:passcode])

                        session[:account] = @info.account


    			     else
    				    render "PNM"
    			     end

    		      end

            else

                if GameStat.inGameStat?(session[:account]) == true

                    @gameNumber = GameStat.find_by_account(session[:account]).game

                    allPlayersGameNumbers = GameStat.pluck(:game)

                    playersWithYourGameNumber = Array.new

                    y = 0

                    while y < allPlayersGameNumbers.length

                        if allPlayersGameNumbers[y] == @gameNumber

                            playersWithYourGameNumber.push(allPlayersGameNumbers[y])

                        end

                        y = y + 1

                    end

                    if playersWithYourGameNumber.length == 2

                    redirect_to "/board1"

                    end

                end

            end

    	end  	

end