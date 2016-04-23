module SapphireBot
  STATS = Stats.new

  SHORTENER = Shortener.new

  bot = Discordrb::Commands::CommandBot.new(token: DISCORD_TOKEN,
                                            application_id: DISCORD_ID,
                                            prefix: PREFIX,
                                            advanced_functionality: false)

  LOGGER.info "oauth url: #{bot.invite_url}+&permissions=#{PERMISSIONS_CODE}"

  bot.bucket(:default, limit: 5,
                       time_span: 30,
                       delay: 1)

  bot.include! Commands::Announce
  bot.include! Commands::Delete
  bot.include! Commands::Flip
  bot.include! Commands::Invite
  bot.include! Commands::Lmgtfy
  bot.include! Commands::Roll
  bot.include! Commands::Stats
  bot.include! Commands::Ping
  bot.include! Commands::KickAll
  bot.include! Commands::Leave
  bot.include! Commands::About
  bot.include! Commands::Avatar
  bot.include! Commands::Eval
  bot.include! Events::Mention
  bot.include! Events::Message::MessagesCounter
  bot.include! Events::Message::AutoShorten
  bot.include! Events::Pm::MassMessage

  bot.run :async

  loop do
    STATS.update(bot)
    STATS.inspect
    sleep(60)
  end
end