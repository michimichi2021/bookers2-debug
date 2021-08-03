class MessagesController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def show
  #BさんのUser情報を取得
   @user = User.find(params[:id])
  #entryテーブルのuser_idがAさんのレコードのroom_idを配列で取得
   rooms = current_user.entries.pluck(:room_id)
  #user_idがBさん(@user)で、room_idがAさんの属するroom_id（配列）となるentryテーブルのレコードを取得して、entry変数に格納
  #これによって、AさんとBさんに共通のroom_idが存在していれば、その共通のroom_idとBさんのuser_idがentry変数に格納される（1レコード）。存在しなければ、nilになる。
  
   entry=Entry.find_by(user_id:@user.id,room_id:rooms)
   
  #entryでルームを取得できなかった（AさんとBさんのチャットがまだ存在しない）場合の処理  
   room = nil
   if entry.nil?
   #roomのidを採番
    room = Room.new
    room.save
    #採番したroomのidを使って、entryのレコードを2人分（Aさん用、Ｂさん用）作る（＝AさんとBさんに共通のroom_idを作る）
    #Bさんの@user.idをuser_idとして、room.idをroom_idとして、Entryモデルのがラムに保存（1レコード）
     Entry.create(user_id: @user.id, room_id: room.id)
    #Aさんのcurrent_user.idをuser_idとして、room.idをroom_idとして、Entryモデルのカラムに保存（1レコード）
     Entry.create(user_id: current_user.id, room_id: room.id)
   else
    #entryに紐づくroomsテーブルのレコードをroomに格納
     room = user_room.room
   end

   #roomに紐づくmessagesテーブルのレコードを@messagesに格納
    @messages = room.messages
   #form_withでチャットを送信する際に必要な空のインスタンス
   #ここでroom.idを@messageに代入しておかないと、form_withで記述するroom_idに値が渡らない
    @message = Message.new(room_id: room.id)
  end

  def create
    @message = current_user.messages.new(message_params)
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:message, :room_id,:user_id)
  end

end
