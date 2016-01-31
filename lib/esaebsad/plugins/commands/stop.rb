class Stop < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "stop"
  set :prefix, /^@@/
  match "stop"
  def execute(msg)
    is_part_of_group?(msg.user.authname, "owner") ? exit : msg.reply(localize("command.shared.unauthorized"))
  end
end
