puts 'you finally made it to the city'
statcheet = File.open('/home/piranha/silly-little-game/player_stats.txt')
stats_list = statcheet.read
statcheet.close
stats = stats_list.split(' ')
# player stats
play_total_hp = stats[0].to_i
player_min_dmg = stats[1].to_i
player_max_dmg = stats[2].to_i
player_heal = stats[3].to_i
player_dmg_rduction = stats[4].to_i
player_doge_chance = stats[5].to_i
player_crit_chance = stats[6].to_i
player_crit_dmg = stats[7].to_f
total_player_gold = stats[8].to_i
current_hp = stats[9].to_i
heal_cost = play_total_hp - current_hp
upgrade_cost = stats[10].to_i
player_luck = stats[11]
puts 'what do you wish to do?'
puts 'heal up (h)'
puts 'upgrade (u)'
puts 'boss fight (bf)', upgrade_cost.to_s
player_state = gets.chomp
puts "you have #{total_player_gold}gold"

case player_state
when 'h', 'H'
  if heal_cost <= total_player_gold
    puts "this will cost you #{heal_cost}coins"
    total_player_gold -= heal_cost
    current_hp = play_total_hp
    puts "you are now at #{current_hp}hp this has cost you #{heal_cost}coins"
    File.open('player_stats.txt', 'r+') do |filee|
      lines = filee.each_line.to_a
      lines[8] = "#{total_player_gold}\n"
      lines[9] = "#{current_hp}\n"
      filee.rewind
      filee.write(lines.join)
    end
  else
    puts "you are to broke you need atleast #{heal_cost}coins and you only have #{total_player_gold} you brokie"
  end
when 'u', 'U'
  if total_player_gold > upgrade_cost
    puts "what do you want to upgrade?\nHP(hp)\nArmor(def)\nCrit(c)\nHeal(h)\nDoge(d)\nDamage(dmg)\nLuck(l)"
    stat_upgrade_type = gets.chomp
    case stat_upgrade_type
    when 'hp', 'Hp', 'HP'
      total_player_gold -= upgrade_cost
      play_total_hp = play_total_hp * 1.1
      upgrade_cost *= 1.2
      File.open('player_stats.txt', 'r+') do |filee|
        lines = filee.each_line.to_a
        lines[8] = "#{total_player_gold}\n"
        lines[0] = "#{play_total_hp.to_i}\n"
        lines[10] = "#{upgrade_cost.to_i}\n"
        filee.rewind
        filee.write(lines.join)
      end
      puts "you now have #{play_total_hp.to_i}hp and #{total_player_gold}gold"
    when 'DEF', 'def', 'Def'
      total_player_gold -= upgrade_cost
      player_dmg_rduction += 2
      upgrade_cost *= 1.2
      File.open('player_stats.txt', 'r+') do |filee|
        lines = filee.each_line.to_a
        lines[8] = "#{total_player_gold}\n"
        lines[4] = "#{player_dmg_rduction.to_i}\n"
        lines[10] = "#{upgrade_cost.to_i}\n"
        filee.rewind
        filee.write(lines.join)
      end
    when 'DMG', 'dmg', 'Dmg'
      total_player_gold -= upgrade_cost
      player_min_dmg *= 1.5
      player_max_dmg *= 1.5
      upgrade_cost *= 1.2
      File.open('player_stats.txt', 'r+') do |filee|
        lines = filee.each_line.to_a
        lines[1] = "#{player_min_dmg.to_i}\n"
        lines[2] = "#{player_max_dmg.to_i}\n"
        lines[10] = "#{upgrade_cost.to_i}\n"
        lines[8] = "#{total_player_gold}\n"
        filee.rewind/home/piranha/silly-little-game/
        filee.write(lines.join)
      end
    when 'C', 'c'
      total_player_gold -= upgrade_cost
      player_crit_dmg *= 1.5
      player_crit_chance *= 1.5
      upgrade_cost *= 1.2
      File.open('player_stats.txt', 'r+') do |filee|
        lines = filee.each_line.to_a
        lines[8] = "#{total_player_gold}\n"
        lines[6] = "#{player_crit_chance.to_i}\n"
        lines[7] = "#{player_crit_dmg}\n"
        lines[10] = "#{upgrade_cost.to_i}\n"
        filee.rewind
        filee.write(lines.join)
      end
    when 'H', 'h'
      total_player_gold -= upgrade_cost
      player_heal *= 1.5
      upgrade_cost *= 1.2
      File.open('player_stats.txt', 'r+') do |filee|
        lines = filee.each_line.to_a
        lines[8] = "#{total_player_gold}\n"
        lines[3] = "#{player_heal}\n"
        lines[10] = "#{upgrade_cost.to_i}\n"
        filee.rewind
        filee.write(lines.join)
      end
    when 'D', 'd'
      total_player_gold -= upgrade_cost
      upgrade_cost *= 1.2
      player_doge_chance *= 1.5
      File.open('player_stats.txt', 'r+') do |filee|
        lines = filee.each_line.to_a
        lines[8] = "#{total_player_gold}\n"
        lines[5] = "#{player_doge_chance}\n"
        lines[10] = "#{upgrade_cost.to_i}\n"
        filee.rewind
        filee.write(lines.join)
      end
    when 'L','l'
      total_player_gold -= upgrade_cost
      upgrade_cost *= 1.2
      player_luck += 10
      File.open('player_stats.txt', 'r+') do |filee|
        lines = filee.each_line.to_a
        lines[8] = "#{total_player_gold}\n"
        lines[11] = "#{player_luck}\n"
        lines[10] = "#{upgrade_cost.to_i}\n"
        filee.rewind
        filee.write(lines.join)
      end
    end
  end
when 'BF', 'bf'
  puts "are you sure you want to enter the bossfight\ny/n"
  yes_no = gets.chomp
  case yes_no
  when 'y'
    load 'C:\Users\jakob\Desktop\silly little game made by silly little people\bossfight.rb'
    exit!
  when 'n'
    puts 'coward'
  end
when 'CAS','Cas','cas'
  puts 'have fun at the casino'
  load' '
  exit!
end
load 'fighting_state.rb'
exit!
