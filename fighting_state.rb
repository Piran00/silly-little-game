# frozen_string_literal: true

# deffing fighting state
require 'C:\Users\jakob\Desktop\silly little game made by silly little people\city'
require 'etc'
require 'io/console'

def win?(current_hp, filee, total_player_gold)
  lines = filee.each_line.to_a
  lines[8] = "#{total_player_gold}\n"
  lines[9] = "#{current_hp}\n"
  filee.rewind
  filee.write(lines.join)
end

def over_heal(hp, max_hp)
  if hp >max_hp
    hp = max_hp
    puts 'you feel reborn'
    return hp
  end
end
def coin_animation(total_player_gold)
  puts 'You have    coins'
  coins = 0
  until coins == total_player_gold
    print "\e[2;10H"
    coins += 1
    print coins
    sleep(0.00001)
    if coins == total_player_gold
      puts ' '
    end
  end

end


def fighting(enemy_file_path)
  statcheet = File.open('C:\Users\jakob\Desktop\silly little game made by silly little people\player_stats.txt')
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
  # defing enemy stats
  enemy_statcheet = File.open(enemy_file_path)
  enemy_statlist = enemy_statcheet.read
  enemy_statcheet.close
  enemy_stats = enemy_statlist.split(' ')
  enemy_hp = enemy_stats[0].to_i
  enemy_dmg_max = enemy_stats[1].to_i
  enemy_dmg_min = enemy_stats[2].to_i
  enemy_gold_reward = enemy_hp / 2
  current_hp = stats[9].to_i
  current_enemy_hp = enemy_hp

  puts 'you have entered combat'
  while current_hp.positive? || current_enemy_hp.positive?
    puts "you currently have #{current_hp}hp\nand the enemy has#{current_enemy_hp}\nwhat do you choose to do\nFight(f)\nHeal(h)\nDoge(d)"
    dmg_to_enemy = rand(player_min_dmg.to_i..player_max_dmg.to_i)
    puts dmg_to_enemy
    player_fight_state = gets.chomp
    case player_fight_state
    when 'f'
      if rand(0..100) >= player_crit_chance
        current_enemy_hp -= dmg_to_enemy.to_i
        puts "you dealt #{dmg_to_enemy} the enemy now has #{current_enemy_hp} hp"
        if current_hp.positive? && current_enemy_hp.negative?
          puts "you win you still have #{current_hp}hp"
          puts "you gained #{enemy_gold_reward} gold"
          total_player_gold += enemy_gold_reward
          File.open('player_stats.txt', 'r+') do |filee|
            win?(current_hp, filee, total_player_gold)
          end
          puts total_player_gold
          load('C:\Users\jakob\Desktop\silly little game made by silly little people\city.rb')
          exit!
        end
      else
        current_enemy_hp -= dmg_to_enemy.to_i * player_crit_dmg
        puts "you crit and deal #{player_crit_dmg} times dmg totaling to #{dmg_to_enemy * player_crit_dmg}"
      end
      current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
      puts "the enemy attacks you now have #{current_hp} hp "
    when 'h'
      if rand(0..100) >= player_crit_chance
        current_hp += player_heal * 2
        current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
        current_hp = over_heal(current_hp, play_total_hp)
        puts "you critical heal and are now at #{current_hp}"
      else
        current_hp += player_heal
        current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
        current_hp = over_heal(current_hp, play_total_hp)
        puts "you heal your hp back up to #{current_hp}"
      end
      puts "the enemy attacks and you now have #{current_hp}hp"
    when 'd'
      if rand(0..100) >= player_doge_chance
        current_hp -= rand(enemy_dmg_min...enemy_dmg_max).to_i - player_dmg_rduction.to_i
        puts 'the enemy attacks'
        puts "you now have #{current_hp}hp"
      else
        puts 'you skillfully doge'
        current_enemy_hp -= dmg_to_enemy / 2
      end
    end
    if current_hp.positive? && current_enemy_hp.negative?
      puts "you win you still have #{current_hp}hp"
      puts "you gained #{enemy_gold_reward} "
      total_player_gold += enemy_gold_reward
      File.open('player_stats.txt', 'r+') do |filee|
        win?(current_hp, filee, total_player_gold)
      end
      puts total_player_gold
      load('C:\Users\jakob\Desktop\silly little game made by silly little people\city.rb')
      exit!
    end
    if current_hp.negative? && current_enemy_hp.positive?
      puts 'you lose' if (current_hp <= 0) && current_enemy_hp.positive?
      exit!
    end
  end
end
puts 'what do you want to fight?\n'
puts 'Goblin'
enemy_name = gets.chomp
case enemy_name
when 'goblin' # is sus
  fighting('C:\Users\jakob\Desktop\silly little game made by silly little people\goblin.txt')
when 'skeleton'

end

puts enemy_name
