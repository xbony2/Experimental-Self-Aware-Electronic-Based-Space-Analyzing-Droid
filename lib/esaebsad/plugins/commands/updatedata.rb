class UpdateData < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility
  
  match "updatedata", method: :update_full
  match /updatedata (.+)/, method: :update_specific
  
  def update_full(msg)
    update_data
    msg.reply(localize("command.shared.complete"))
  end
  
  def update_specific(msg, emodule)
    update_data(emodule)
    msg.reply(localize("command.shared.complete"))
  end
end
