require 'telegram/bot'
require './lib/app_configurator'
require './lib/message_responder'

config = AppConfigurator.new
config.configure
#
# developer = Developer.new
# developer.dataset.insert(name: "John",username: "@john",github_account: "@john_git")
# developer.db
#

token = '1123591294:AAGhEX-u-pd37WFI_M6471muyXBay1ACZjk'

BotClient = Telegram::Bot

BotClient::Client.run(token) do |bot|
  bot.listen do |message|
    options = {bot: bot, message: message}
    MessageResponder.new(options).respond
    # puts "@#{message.from.username} send  #{message.text}"
  end
end

