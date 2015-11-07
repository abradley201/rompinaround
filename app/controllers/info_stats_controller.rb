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

                                @gameNumber = GameStat.find_by_account(session[:account]).game

                                if GameStat.inGameStat?(session[:account]) == true

                                    @gameNumber = GameStat.find_by_account(session[:account]).game

                                    @gameArray = GameStat.where(game:@gameNumber)

                                    if @gameArray.length == 2

                                        redirect_to "/board1"

                                    end

                                end

                            end


    			     else
    				    render "PNM"
    			     end

    		      end

                

            else

                if GameStat.inGameStat?(session[:account]) == true

                    @gameNumber = GameStat.find_by_account(session[:account]).game

                    @gameArray = GameStat.where(game:@gameNumber)

                    if @gameArray.length == 2

                    redirect_to "/board1"

                    end

                end

            end

    	end  	

end