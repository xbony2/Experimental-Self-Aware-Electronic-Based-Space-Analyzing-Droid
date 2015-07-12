class Addriovarmor
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /addriovarmor (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*)/
  def execute(msg, name, t1_armor_rating, t1_helmet_dur, t1_chest_dur, t1_leggings_dur, t1_boots_dur, t2_armor_rating, t2_helmet_dur, t2_chest_dur, t2_leggings_dur, t2_boots_dur)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      $wiki_bot.create_page "#{name} Helmet", "{{Infobox\n|name=#{name} Helmet\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Helmet}}\n|mod=The Mists of RioV 2\n|type=armor\n" +
        "|nexttier={{Gc|mod=TMOR2|dis=false|#{name} Helmet Tier II}}\n|armorrating=#{t1_armor_rating}\n|durability=#{t1_helmet_dur}\n}}\n\nThe '''#{name} Helmet''' is an armor added by " +
        "[[The Mists of RioV 2]] mod. It can be upgraded via [[Enhancer]] to get the [[#{name} Helmet Tier II]], or be [[Enchanter|enchanted normally]]. Do note using an enchanted armor piece in the " +
        "Enhancer will wipe away it's enchantments in the upgraded version of the armor.\n\n==Recipe==\n{{Cg/Crafting Table\n|A1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|B1={{Gc|mod=TMOR2|dis=false|#{name}}}" +
        "\n|C1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|A2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|O={{Gc|mod=TMOR2|link=none|#{name} Helmet}}\n}}\n\n\n" +
        "{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n"
      $wiki_bot.create_page "#{name} Chestplate", "{{Infobox\n|name=#{name} Chestplate\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Chestplate}}\n|mod=The Mists of RioV 2\n|type=armor\n" +
        "|nexttier={{Gc|mod=TMOR2|dis=false|#{name} Chestplate Tier II}}\n|armorrating=#{t1_armor_rating}\n|durability=#{t1_chest_dur}\n}}\n\nThe '''#{name} Chestplate''' is an armor added by " +
        "[[The Mists of RioV 2]] mod. It can be upgraded via [[Enhancer]] to get the [[#{name} Chestplate Tier II]], or be [[Enchanter|enchanted normally]]. Do note using an enchanted armor piece in the " +
         "Enhancer will wipe away it's enchantments in the upgraded version of the armor.\n\n==Recipe==\n{{Cg/Crafting Table\n|A1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C1={{Gc|mod=TMOR2|dis=false|#{name}}}" +
         "\n|A2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|B2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|A3={{Gc|mod=TMOR2|dis=false|#{name}}}\n" +
         "|B3={{Gc|mod=TMOR2|dis=false|#{name}}}|C3={{Gc|mod=TMOR2|dis=false|#{name}}}|O={{Gc|mod=TMOR2|link=none|#{name} Chestplate}}\n}}\n\n\n{{Navbox The Mists of RioV 2}}\n\n" +
         "[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n"
        $wiki_bot.create_page "#{name} Leggings", "{{Infobox\n|name=#{name} Leggings\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Leggings}}\n|mod=The Mists of RioV 2\n|type=armor\n" +
          "|nexttier={{Gc|mod=TMOR2|dis=false|#{name} Leggings Tier II}}\n|armorrating=#{t1_armor_rating}\n|durability=#{t1_leggings_dur}\n}}\n\nThe '''#{name} Leggings''' is an armor added by " +
          "[[The Mists of RioV 2]] mod. It can be upgraded via [[Enhancer]] to get the [[#{name} Leggings Tier II]], or be [[Enchanter|enchanted normally]]. Do note using an enchanted armor piece in the " +
          "Enhancer will wipe away it's enchantments in the upgraded version of the armor.\n\n==Recipe==\n{{Cg/Crafting Table\n|A1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|B1={{Gc|mod=TMOR2|dis=false|#{name}}}" +
          "\n|C1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|A2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|A3={{Gc|mod=TMOR2|dis=false|#{name}}}\n" +
          "|C3={{Gc|mod=TMOR2|dis=false|#{name}}}\n|O={{Gc|mod=TMOR2|link=none|#{name} Leggings}}\n}}\n\n\n{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]" +
          "\n\n<languages/>\n"
        $wiki_bot.create_page "#{name} Boots", "{{Infobox\n|name=#{name} Boots\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Boots}}\n|mod=The Mists of RioV 2\n|type=armor\n" +
          "|nexttier={{Gc|mod=TMOR2|dis=false|#{name} Boots Tier II}}\n|armorrating=#{t1_armor_rating}\n|durability=#{t1_boots_dur}\n}}\n\nThe '''#{name} Boots''' is an armor added by " +
          "[[The Mists of RioV 2]] mod. It can be upgraded via [[Enhancer]] to get the [[#{name} Boots Tier II]], or be [[Enchanter|enchanted normally]]. Do note using an enchanted armor piece in the " +
          "Enhancer will wipe away it's enchantments in the upgraded version of the armor.\n\n==Recipe==\n{{Cg/Crafting Table\n|A1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C1={{Gc|mod=TMOR2|dis=false|#{name}}}" +
          "\n|A2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|O={{Gc|mod=TMOR2|link=none|#{name} Boots}}\n}}\n\n\n{{Navbox The Mists of RioV 2}}\n\n" +
          "[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n"
        $wiki_bot.create_page "#{name} Helmet Tier II", "{{Infobox\n|name=#{name} Helmet Tier II\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Helmet Tier II}}\n|mod=The Mists of RioV 2\n" +
          "|type=armor\n|prevtier={{Gc|mod=TMOR2|dis=false|#{name} Helmet}}\n|armorrating=#{t2_armor_rating}\n|durability=#{t2_helmet_dur}\n}}\n\nThe '''#{name} Helmet Tier II''' is an armor added by " +
          "[[The Mists of RioV 2]] mod. It as an upgraded version of the [[#{name} Helmet]].\n\n==Recipe==\n{{Cg/Enhancer\n|I1={{Gc|mod=TMOR2|dis=false|Enhancer Gem}}\n" + 
          "|I2={{Gc|mod=TMOR2|dis=false|#{name} Helmet}}\n|O={{Gc|mod=TMOR2|link=false|#{name} Helmet Tier II}}\n}}\n\n\n{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]" +
          "\n\n<languages/>\n"
        $wiki_bot.create_page "#{name} Chestplate Tier II", "{{Infobox\n|name=#{name} Chestplate Tier II\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Chestplate Tier II}}\n|mod=The Mists of RioV 2\n" +
          "|type=armor\n|prevtier={{Gc|mod=TMOR2|dis=false|#{name} Chestplate}}\n|armorrating=#{t2_armor_rating}\n|durability=#{t2_chest_dur}\n}}\n\n" +
          "The '''#{name} Chestplate Tier II''' is an armor added by [[The Mists of RioV 2]] mod. It as an upgraded version of the [[#{name} Chestplate]].\n\n==Recipe==\n" + 
          "{{Cg/Enhancer\n|I1={{Gc|mod=TMOR2|dis=false|Enhancer Gem}}\n|I2={{Gc|mod=TMOR2|dis=false|#{name} Chestplate}}\n|O={{Gc|mod=TMOR2|link=false|#{name} Chestplate Tier II}}\n}}\n\n\n" +
          "{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n"
        $wiki_bot.create_page "#{name} Leggings Tier II", "{{Infobox\n|name=#{name} Leggings Tier II\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Leggings Tier II}}\n|mod=The Mists of RioV 2\n" +
          "|type=armor\n|prevtier={{Gc|mod=TMOR2|dis=false|#{name} Leggings}}\n|armorrating=#{t2_armor_rating}\n|durability=#{t2_leggings_dur}\n}}\n\n" +
          "The '''#{name} Leggings Tier II''' is an armor added by [[The Mists of RioV 2]] mod. It as an upgraded version of the [[#{name} Leggings]].\n\n==Recipe==\n" + 
          "{{Cg/Enhancer\n|I1={{Gc|mod=TMOR2|dis=false|Enhancer Gem}}\n|I2={{Gc|mod=TMOR2|dis=false|#{name} Leggings}}\n|O={{Gc|mod=TMOR2|link=false|#{name} Leggings Tier II}}\n}}\n\n\n" +
          "{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n"
        $wiki_bot.create_page "#{name} Boots Tier II", "{{Infobox\n|name=#{name} Boots Tier II\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Boots Tier II}}\n|mod=The Mists of RioV 2\n" +
          "|type=armor\n|prevtier={{Gc|mod=TMOR2|dis=false|#{name} Boots}}\n|armorrating=#{t2_armor_rating}\n|durability=#{t2_boots_dur}\n}}\n\n" +
          "The '''#{name} Boots Tier II''' is an armor added by [[The Mists of RioV 2]] mod. It as an upgraded version of the [[#{name} Boots]].\n\n==Recipe==\n" + 
          "{{Cg/Enhancer\n|I1={{Gc|mod=TMOR2|dis=false|Enhancer Gem}}\n|I2={{Gc|mod=TMOR2|dis=false|#{name} Boots}}\n|O={{Gc|mod=TMOR2|link=false|#{name} Boots Tier II}}\n}}\n\n\n" +
          "{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n"
    end
  end
end
