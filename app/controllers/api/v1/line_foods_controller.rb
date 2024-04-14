module Api
    module V1
      class LineFoodsController < ApplicationController
        #コントローラーのメインアクションに入る前に行う処理
        before_action :set_food, only: %i[create replace]

        def index
            #linefood の中からActiveなものを取得する
            line_foods = LineFood.active
            #対象のインスタンスのデータがDBにあるか、すなわち、注文が一つ以上あるか
            if line_foods.exists?
            #　｜｜は配列として取得される要素、左は入れる要素
              render json: {
                line_food_ids: line_foods.map { |line_food| line_food.id },
                restaurant: line_foods[0].restaurant,
                count: line_foods.sum { |line_food| line_food[:count] },
                amount: line_foods.sum { |line_food| line_food.total_amount },
              }, status: :ok
            else
              render json: {}, status: :no_content
            end
        end
  
        def create
            #例外処理を行う
          if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
            return render json: {
              existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
              new_restaurant: Food.find(params[:food_id]).restaurant.name,
            }, status: :not_acceptable
          end
  
          set_line_food(@ordered_food)
  
          # DBに保存、エラーの場合は500系を返す
          if @line_food.save
            render json: {
              line_food: @line_food
            }, status: :created
          else
            render json: {}, status: :internal_server_error
          end
        end

        def replace
            LineFood.active.other_restaurant(@ordered_food.restaurant.id).each do |line_food|
              line_food.update_attribute(:active, false)
            end
    
            set_line_food(@ordered_food)
    
            if @line_food.save
              render json: {
                line_food: @line_food
              }, status: :created
            else
              render json: {}, status: :internal_server_error
            end
        end
  
        private
        def set_food
            #foodのIDを抽出して、インスタンス変数に格納
          @ordered_food = Food.find(params[:food_id])
        end
  
        def set_line_food(ordered_food)
            #すでにその商品がある場合には、その商品の個数を増やす
          if ordered_food.line_food.present?
            @line_food = ordered_food.line_food
            @line_food.attributes = {
              count: ordered_food.line_food.count + params[:count],
              active: true
            }
          else
            #ない場合には、新しく生成する
            @line_food = ordered_food.build_line_food(
              count: params[:count],
              restaurant: ordered_food.restaurant,
              active: true
            )
          end
        end
      end
    end
  end
  