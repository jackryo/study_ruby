require 'securerandom'

module ChatApp
  VERSION = '1.0.0'

  class User
    attr_reader :login, :email

    def initialize(login:, email:)
      @login, @email = login, email
    end
  end

  class Bot
    attr_reader :name, :email, :owner

    def initialize(name:, owner:)
      @email = owner.email
      @name, @owner = name, owner
    end
  end

  class Message
    attr_reader :id, :string, :from, :reply_to

    def initialize(from:, string:)
      @id = SecureRandom.hex(16)
      @from, @string, @reply_to = from, string, nil
    end

    def reply(from:, string:)
      @reply_to = Message.new(from: from, string: string)
    end
  end

  class Channel
    attr_reader :name, :messages, :users, :bots

    def initialize(name:)
      @name, @messages, @users, @bots = name, [], [], []
    end
  end
end

channel = ChatApp::Channel.new(name: 'channel1')

admin = ChatApp::User.new(login: '2000/01/01', email: 'admin@email.com')
admin_bot = ChatApp::Bot.new(name: 'admin_bot', owner: admin)

user1 = ChatApp::User.new(login: '2000/01/01', email: 'user_1@email.com')
user2 = ChatApp::User.new(login: '2020/01/01', email: 'user_2@email.com')

chat_open_message = ChatApp::Message.new(from: admin_bot, string: 'open this chat')

message_user1 = ChatApp::Message.new(from: user1, string: 'hello everyone')
message_user2_reply_to_user1 = message_user1.reply(from: user2, string: 'hello user1')
message_user1_reply_to_user2 = message_user2_reply_to_user1.reply(from: user1, string: 'hello user2, lunch with me?')

ban_message = message_user1_reply_to_user2.reply(from: admin_bot, string: 'user1, dating is inhibited')