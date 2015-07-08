module API
  module V1
    class Groups < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:name, :password, :avatar)
        end

        # パラメータのチェック
        # パラメーターの必須(requires)、任意(optional)を指定することができる。
        # use :attributesという形で使うことができる。
        params :attributes do
          requires :text, type: String, desc: "Letter text."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "Letter id."
        end
      end

      resource :groups do
        # desc 'GET /api/v1/letters'
        # get '', jbuilder: 'api/v1/letters/index' do
        #   @message_boards = MessageBoard.all
        # end

        desc 'POST /api/v1/groups'
        params do
          use :attributes
        end
        post '', jbuilder: 'api/v1/groups/create' do
          p "あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ"
          @group = Group.new(create_params)
          unless @group.save
            @error_message = @group.errors.full_messages
          end
        end

        # desc 'GET /api/v1/letters/:id'
        # params do
        #   use :id
        # end
        # get '/:id', jbuilder: 'api/v1/letters/show' do
        #   set_message_board
        # end

        # desc 'PUT /api/v1/letters/:id'
        # params do
        #   use :id
        #   use :attributes
        # end
        # put '/:id' do
        #   set_message_board
        #   @message_board.update(message_board_params)
        # end

        # desc 'DELETE /api/v1/letters/:id'
        # params do
        #   use :id
        # end
        # delete '/:id' do
        #   set_message_board
        #   @message_board.destroy
        # end
      end
    end
  end
end