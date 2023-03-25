statcheet = File.open('player_stats.txt')
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

#boss stats
boss_hp = 1000
boss_min_dmg = 70
boss_max_dmg = play_total_h / 2
boss_dmg_reduction = 20#%
current_boss_hp = boss_hp
doge_dmg = player_max_dmg / 2
while current_hp.positive? && boss_hp.positive?
  if current_hp > play_total_hp
    current_hp = play_total_hp
  end

  puts "you currently have #{current_hp}hp\nand the enemy has#{boss_hp}\nwhat do you choose to do\nFight(f)\nHeal(h)\nDoge(d)"
  case gets.chomp.upcase
  when 'F'
    dmg_to_boss = rand(player_min_dmg..player_max_dmg)
    if rand(0..100) >= player_crit_chance
      current_boss_hp -= dmg_to_boss.to_i
      puts "you dealt #{boss_hp - current_boss_hp} the enemy now has #{current_boss_hp} "
      if current_hp.positive? && current_boss_hp.negative?
        puts "you win you still have #{current_hp}hp"
        puts "you gained #{total_player_gold} gold"
        total_player_gold += 10000
        File.open("player_stats.txt", "r+") do |filee|
          lines = filee.each_line.to_a
          lines[8] = "#{total_player_gold}\n"
          filee.rewind
          filee.write(lines.join)
        end
        load 'city.rb'
        exit!
      else
      current_hp -= rand(boss_min_dmg..boss_max_dmg)
      puts "the enemy attacks you now have #{current_hp} hp "
      end


    else
      current_boss_hp -= dmg_to_boss * player_crit_dmg
      puts "you crit and deal #{player_crit_dmg} times dmg totaling to #{dmg_to_boss * player_crit_dmg}"
      current_hp -= rand(boss_min_dmg..boss_max_dmg)
      puts "the enemy attacks you now have #{current_hp} hp "
    end
  when'H'
    if rand(0..100)>=player_crit_chance
      current_hp += player_heal * 2
      current_hp -= rand(boss_min_dmg..boss_max_dmg)
    else
      current_hp+= player_heal
      current_hp -= rand(boss_min_dmg..boss_max_dmg)
    end
  when'D'
    if rand(0..100)>player_doge_chance
      current_hp -= rand(boss_min_dmg..boss_max_dmg) - player_dmg_rduction
      puts `you fail to doge and the boss still hits you`
    else
      current_boss_hp -= doge_dmg
      puts "you skillfully doge and deal #{doge_dmg}dmg to the boss he now has #{current_boss_hp}"
    end

  end
  end
end
