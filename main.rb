# frozen_string_literal: true

# requirements

require 'etc'
# getting the players name from etc
name_of_user = Etc.getlogin
# greeting the player
puts "Hello #{name_of_user}! \nWelcome to my silly little game. \nDid i get your name correctly?"
print '(.n)? ' # print wont use linefeed, where puts does. consider this when making user prompts. (see block comment starting on line 18)
name_of_user = gets.chomp
while name_of_user != 'y'
  print "then what is your name? " # see line 10
  name_of_user = gets.chomp
  print "Apologies, #{name_of_user}. \nIs your name right this time? (.n) " # see line 10
  name_of_user = gets.chomp
end
=begin
^
Not sure why two seperate username vars are needed, one is plenty
this makes debugging a little easier to go over

---

also, the `print` keyword will not output a linefeed, whereas `puts` will.
you can use this to your benefit:
ie:

```
print "are apples orange? "
sane = gets.chomp
```
&
```
puts "are apples orange? "
sane = gets.chomp
````
yield different results.
the first willl say:
```
are apples orange? 
```
(note the trailing space)
then the user can:
```
are apples orange? YES!
```
and respont to the prompt on the same line.
when the enter key is pressed, the cursor returns down a line, and saves what was entered *before* the enter key was pressed, with gets
=end

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
enemy_hp = play_total_hp / rand(1..10) # ranges only use two dots # putting three makes the first param a float iirc
enemy_dmg_max = play_total_hp / 10
enemy_dmg_min = player_min_dmg / 4
current_hp = play_total_hp
current_enemy_hp = enemy_hp
# puts play_total_hp
# puts player_max_dmg
# puts player_min_dmg
puts '' # puts an empty line for easy reading
while current_hp.positive? || current_enemy_hp.positive?
  puts 'you have entered combat'
  puts 'Valid Actions:'
  puts 'Fight(f)'
  puts 'Heal(h)'
  puts 'Doge(d)'
  print 'What do you want to do? '
  # calculate player damage done to enemy if chose (f)
  dmg_to_enemy = rand(player_min_dmg.to_i..player_max_dmg.to_i)
  # puts dmg_to_enemy # no need for printing this to output, it makes extra output, that wouldn't be needed for an rpg-type game
  player_fight_state = gets.chomp
  case player_fight_state
  when 'f'
    if rand(0..100) >= player_crit_chance
      current_enemy_hp -= dmg_to_enemy.to_i
      puts "you dealt #{dmg_to_enemy} dmg. \nthe enemy now has #{current_enemy_hp} hp."
      current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
      puts "the enemy attacks! \nyou now have #{current_hp} hp. "
    else
      current_enemy_hp -= dmg_to_enemy.to_i * player_crit_dmg
      puts "you crit and deal a multiplier of #{player_crit_dmg}, \ntotaling to #{dmg_to_enemy * player_crit_dmg} dmg." # this is instakilling cos stat[7] is value 100 set line 7 to a more sane multiplier for crits
      puts "the enemy how has #{current_enemy_hp} hp."
      current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
      puts "the enemy attacks! \nyou now have #{current_hp} hp. "
    end
  when 'h'
    current_hp += player_heal
    puts "you healt #{player_heal} you now have #{current_hp}"
    current_hp -= rand(enemy_dmg_min..enemy_dmg_max)
    puts "the enemy attacks! \nyou now have #{current_hp} hp. "
  when 'd'
    if rand(0..100) >= player_doge_chance
      current_hp -= rand(enemy_dmg_min...enemy_dmg_max).to_i - player_dmg_rduction.to_i
      puts "you werent quick enough to dodge!"
      puts "the enemy attacks! \nyou now have #{current_hp} hp. f in chat."
    else
      puts 'you skillfully doge!'
    end
  end
  if current_hp.positive? && current_enemy_hp.negative?
    puts "you win! \nyou have #{current_hp} hp remaining."
    #load('city.rb') lets just debug main.rb for now
    exit!
  end
  if current_hp.negative? && current_enemy_hp.positive?
    puts 'you lose!' if (current_hp <= 0) && current_enemy_hp.positive?
    exit!
  end
  puts '' # puts an empty line for easy reading
end
