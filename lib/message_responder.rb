require './models/Developer'
require './models/Project'
require './lib/message_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = Developer.all
  end

  def respond
    case message
    when Telegram::Bot::Types::CallbackQuery
      puts message
      case message.data
      when 'new'
        bot.api.send_message(chat_id: message.from.id, text: "Apa nama projectnya ?")
      when 'show'
        answer_with_message("Ini daftar project kalian")
      when 'delete'
        markup = Project
        # answer_with_keyboard_inline("Mana yang ingin di hapus ?", markup)
      end
    when Telegram::Bot::Types::ChosenInlineResult
      options = %w(Ya Tidak)
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(keyboard: options)
      bot.api.send_message(chat_id: message.id, text: "Nama Judul Projectnya adalah #{message.query}", reply_markup: markup)
    when Telegram::Bot::Types::Message
      case message.text
      when /tik/i
        kb = [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "Buat Project", callback_data: "new"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "List Project", callback_data: "show"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "Hapus Project", callback_data: "delete"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Go to Google', url: 'https://google.com'),
        ]
        text = "Hey #{message.from.first_name}, apa yang harus aku lakukan ?"
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
        answer_with_keyboard_inline(text, markup)
      else
        answer_with_message "Aku gak ngerti perintahmu cuy"
      end
    end
    #
    # on /tik/i do
    #   question = "Iya boss, #{message.from.first_name}, Ada yang bisa saya bantu ?"
    #   answers = ["buat project", "lihat project", "hapus project"]
    #   answer_with_markup_reply(question, answers)
    # end
    # on /buat project/i do
    #   question = "Apa nama projectnya? "
    #   answer_with_message(question)
    # end
    # on /lihat project/i do
    #   # if project.empty?
    #   #   robot.send_message(chat_id: message.chat.id, text: "You don't have any projects yet")
    #   # else
    #   #   robot.send_message(chat_id: message.chat.id, text: "Here are the projects #{projects}")
    #   # end
    # end
    # on /hapus project/i do
    #   answer_with_message("Project mana yang mau di hapus ?")
    # end
    # on /^\/start/ do
    #   answer_with_greeting_message
    # end
    #
    # on /^\/stop/ do
    #   answer_with_farewell_message
    # end
  end

  private

  #
  # def on regex, &block
  #   regex =~ message.text
  #
  #   if $~
  #     case block.arity
  #     when 0
  #       yield
  #     when 1
  #       yield $1
  #     when 2
  #       yield $1, $2
  #     end
  #   end
  # end

  def greeting_hello
    answer_with_message("Halo bos, ada yang bisa saya bantu ?")
  end

  def answer_with_greeting_message
    answer_with_message "greeting_message"
  end

  def answer_with_farewell_message
    answer_with_message "Farewall MEss"
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_with_markup_reply(text, markup)
    MessageSender.new(bot: bot, chat: message.chat, text: text, answers: markup).send
  end

  def answer_with_keyboard_inline(text, markup)
    bot.api.send_message(chat_id: message.chat.id, text: text, reply_markup: markup)
    # MessageSender.new(bot: bot, chat: message.chat, text: text, markup_inline: markup).send
  end

end