# frozen_string_literal: true

# requirements

require 'etc'
# getting the players name from etc
name_of_user = Etc.getlogin
# greeting the player
puts "Hello #{name_of_user} welcome to my silly little game did i get your name correctly?"
puts 'y/n'
name_of_user_correct = gets.chomp
while name_of_user_correct != 'y'
  puts 'then what is your name?'
  name_of_user = gets.chomp
  puts "hi #{name_of_user} is it right this time?"
  name_of_user_correct = gets.chomp
end

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
# defing enemy stats
enemy_hp = play_total_hp / rand(1...10)
enemy_dmg_max = play_total_hp / 10
enemy_dmg_min = player_min_dmg / 4
current_hp = play_total_hp
current_enemy_hp = enemy_hp
puts play_total_hp
puts player_max_dmg
puts player_min_dmg

while current_hp.positive? || current_enemy_hp.positive?
  puts 'you have entered combat'
  puts 'what do you choose to do'
  puts 'Fight(f)'
  puts 'Heal(h)'
  puts 'Doge(d)'
  dmg_to_enemy = rand(player_min_dmg.to_i..player_max_dmg.to_i)
  puts dmg_to_enemy
  player_fight_state = gets.chomp
  case player_fight_state
  when 'f'
    if rand(0..100) >= player_crit_chance
      current_enemy_hp -= dmg_to_enemy.to_i
      puts "you dealt #{dmg_to_enemy} the enemy now has #{current_enemy_hp} "
      current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
      puts "the enemy attacks you now have #{current_hp} hp "
    else
      current_enemy_hp -= dmg_to_enemy.to_i * player_crit_dmg
      puts "you crit and deal #{player_crit_dmg} times dmg totaling to #{dmg_to_enemy * player_crit_dmg}"
      current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
      puts "the enemy attacks you now have #{current_hp} hp "
    end
  when 'h'
    current_hp += player_heal
    puts "you healt #{player_heal} you now have #{current_hp}"
    current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
    puts "the enemy attacks you now have #{current_hp} hp "
  when 'd'
    if rand(0..100) >= player_doge_chance
      current_hp -= rand(enemy_dmg_min...enemy_dmg_max).to_i - player_dmg_rduction.to_i
      puts 'the enemy attacks'
      puts "you now have #{current_hp} f"
    else
      puts 'you skillfully doge'
    end
  end
  if current_hp.positive? && current_enemy_hp.negative?
    puts "you win you still have #{current_hp}hp"
    load('city.rb')
    exit!
  end
  if current_hp.negative? && current_enemy_hp.positive?
    puts 'you lose' if (current_hp <= 0) && current_enemy_hp.positive?
    exit!
  end
end


