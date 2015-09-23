class Addriovarmor
  include Cinch::Plugin
  
  def get_wikitext(type, name, durablity, damage = 0, mining_level = 0)
    text = File.read("git/IRC-Bot/src/main/resources/xbony2/ircbot/templates/#{type}")
    text = text.gsub(/#NAME/, name)
    text = text.gsub(/#DURA/, durablity)
    if text.gsub(/#DAMAGE/, damage) != nil then text = text.gsub(/#DAMAGE/, damage) end
    if text.gsub(/#MINING_LEVEL/, mining_level) != nil then text = text.gsub(/#MINING_LEVEL/, mining_level) end
    
    return text
  end
  
  set :prefix, /^@@/
  match /addriovarmor (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*)/
  def execute(msg, name, t1_durablity, t1_sword_dmg, t1_pick_dmg, t1_mining_level, t1_axe_dmg, t1_shovel_dmg, t2_durablity, t2_sword_dmg, t2_pick_dmg, t2_mining_level, t2_axe_dmg, t2_shovel_dmg)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      $wiki_bot.edit(title: "#{name} Sword", text: get_wikitext("t1_sword_template", name, t1_durablity, t1_sword_dmg), bot: 1)
      $wiki_bot.edit(title: "#{name} Pickaxe", text: get_wikitext("t1_pick_template", name, t1_durablity, t1_pick_dmg, t1_mining_level), bot: 1)
      $wiki_bot.edit(title: "#{name} Axe", text: get_wikitext("t1_axe_template", name, t1_durablity, t1_axe_dmg), bot: 1)
      $wiki_bot.edit(title: "#{name} Shovel", text: get_wikitext("t1_shovel_template", name, t1_durablity, t1_shovel_dmg), bot: 1)
      $wiki_bot.edit(title: "#{name} Hoe", text: get_wikitext("t1_hoe_template", name, t1_durablity), bot: 1)
      $wiki_bot.edit(title: "#{name} Sword Tier II", text: get_wikitext("t2_sword_template", name, t2_durablity, t2_sword_dmg), bot: 1)
      $wiki_bot.edit(title: "#{name} Pickaxe Tier II", text: get_wikitext("t2_pick_template", name, t2_durablity, t2_pick_dmg, t2_mining_level), bot: 1)
      $wiki_bot.edit(title: "#{name} Axe Tier II", text: get_wikitext("t2_axe_template", name, t2_durablity, t2_axe_dmg), bot: 1)
      $wiki_bot.edit(title: "#{name} Shovel Tier II", text: get_wikitext("t2_shovel_template", name, t2_durablity, t2_shovel_dmg), bot: 1)
      
       msg.reply "Process complete, all #{name} tools done."
    end
  end
end
