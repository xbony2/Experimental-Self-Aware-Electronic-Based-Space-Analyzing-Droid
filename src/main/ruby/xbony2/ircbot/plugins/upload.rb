class Upload
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /upload (.+)/
  def execute(msg, file)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      $wiki_bot.upload_image(file, "Desktop/#{file}", "Contact #{$OWNER_NAME} with any concerns about this file.", true)
      msg.reply "File uploaded: http://ftb.gamepedia.com/File:#{file.gsub(' ', '_')}"
    end
  end
end