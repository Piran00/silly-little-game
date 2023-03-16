puts "welcome to the casino"
statcheet = File.open('C:\Users\jakob\Desktop\silly little game made by silly little people\player_stats.txt')
stats_list = statcheet.read
statcheet.close
stats = stats_list.split(' ')
player_luck = stats[11]
total_player_gold = stats[8].to_i
puts 'how many coins do you want to bet?'
coin_amount = gets.chomp
def win_animation(total_player_gold)
  text = "you have %d coins"
  coins = 0
  until coins == total_player_gold
    printf text,coins
    coins += rand(5..10)
    if coins >= total_player_gold
      coins = total_player_gold
      printf "\r"
      printf text,coins
      break
    end
    printf "\r"
    sleep(0.001)
  end
end
win_animation(total_player_gold)
def gamble (player_luck,coin_amount)

end