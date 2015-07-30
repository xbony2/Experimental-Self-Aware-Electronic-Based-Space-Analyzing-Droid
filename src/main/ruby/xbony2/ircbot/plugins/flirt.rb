class Flirt
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match /flirt (.+)/
  def execute(msg, flirtery) #For lack of a better term
    msg.reply "#{flirtery}: hey bby, #{["wanna fuck?", "you must be a portal, cause' I want you to explore my nether dimension.", 
    "you must be an infinite array, cause I want to interate in your forever."].sample}"
  end
end