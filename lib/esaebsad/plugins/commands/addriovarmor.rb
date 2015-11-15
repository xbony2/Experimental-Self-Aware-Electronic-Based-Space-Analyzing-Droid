class AddRiovArmor < ESAEBSADCommand
  include Cinch::Plugin
  
  def get_wikitext(type, name, durablity, damage = "", mining_level = "")
    File.read("git/IRC-Bot/lib/resources/templates/#{type}").gsub(/#NAME/, name).gsub(/#DURA/, durablity).gsub(/#DAMAGE/, damage).gsub(/#MINING_LEVEL/, mining_level)
  end
  
  set_help("addriovarmor", "Group: owner. Syntax: \"@@addriovarmor (name); (info1); (info2); (info3)...\"\nThe addriovarmor command is an alias for all automatic page-generating commands.\nIt should never be run more then once, and it's arguments vary on it's need.")
  set :prefix, /^@@/
  match /addriovarmor (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*)/
  def execute(msg, name, t1_durablity, t1_sword_dmg, t1_pick_dmg, t1_mining_level, t1_axe_dmg, t1_shovel_dmg, t2_durablity, t2_sword_dmg, t2_pick_dmg, t2_mining_level, t2_axe_dmg, t2_shovel_dmg)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      get_client.create_page("#{name} Sword", get_wikitext("t1_sword_template", name, t1_durablity, t1_sword_dmg), "Generated new article.")
      get_client.create_page("#{name} Pickaxe", get_wikitext("t1_pick_template", name, t1_durablity, t1_pick_dmg, t1_mining_level), "Generated new article.")
      get_client.create_page("#{name} Axe", get_wikitext("t1_axe_template", name, t1_durablity, t1_axe_dmg), "Generated new article.")
      get_client.create_page("#{name} Shovel", get_wikitext("t1_shovel_template", name, t1_durablity, t1_shovel_dmg), "Generated new article.")
      get_client.create_page("#{name} Hoe", get_wikitext("t1_hoe_template", name, t1_durablity), "Generated new article.")
      get_client.create_page("#{name} Sword Tier II", get_wikitext("t2_sword_template", name, t2_durablity, t2_sword_dmg), "Generated new article.")
      get_client.create_page("#{name} Pickaxe Tier II", get_wikitext("t2_pick_template", name, t2_durablity, t2_pick_dmg, t2_mining_level), "Generated new article.")
      get_client.create_page("#{name} Axe Tier II", get_wikitext("t2_axe_template", name, t2_durablity, t2_axe_dmg), "Generated new article.")
      get_client.create_page("#{name} Shovel Tier II", get_wikitext("t2_shovel_template", name, t2_durablity, t2_shovel_dmg), "Generated new article.")
      
       msg.reply "Process complete, all #{name} tools done."
    end
  end
end
