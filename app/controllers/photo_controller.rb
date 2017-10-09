class PhotoController < ApplicationController
    def keyboard_init
        @msg =
            {
              type: "buttons",
              buttons: ["2명", "3명", "4명", "5명이상"]
            }
        render json: @msg, status: :ok
    end
    
    def chat_control
      
      @user_key = params[:user_key]
      @user = User.find_or_create_by(password: @user_key)

     
      #if Integer(params[:content][0]).is_a? Integer #Integer ok, but string err
      if @user.people.nil? # people값 받기

            @response = (params[:content][0]).to_i
            @user.people = @response
            @user.save
            @msg ={
                message: {
                text: "컨셉을 골라주세요!"
                },
                keyboard: {
                type: "buttons",
                buttons: ["귀엽게", "어렵게", "창피하게"]
                }
            }   
      elsif @user.concept.nil?  # params[:content]이 '컨셉'를 지칭할때
            @response= params[:content]
            @user.concept = @response
            @user.save
            
        if(@user.concept=="귀엽게")
          @result = "https://s3.ap-northeast-2.amazonaws.com/likelionkakaochat/#{@user.people}_0#{rand(1..3)}_c.png"
          
        elsif (@user.concept=="어렵게")
          @result = "https://s3.ap-northeast-2.amazonaws.com/likelionkakaochat/#{@user.people}_0#{rand(1..3)}_d.png"
          
        else
          @result = "https://s3.ap-northeast-2.amazonaws.com/likelionkakaochat/#{@user.people}_0#{rand(1..3)}_q.png"
          
        end
        @msg ={
          message: {
            "text": "추천 포즈는 바로 이것!",
            "photo": {
             "url": @result,
             "width": 640,
             "height": 480
            }
          }
        }
      end
      render json: @msg, status: :ok 

    # @user.people = nil
        
            
    end

end
