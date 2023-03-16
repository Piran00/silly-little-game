i = 0
s_time = 0.01
def win_animation(total_player_gold, i , s_time)
  increase_amount = if total_player_gold >= 10_000
                      total_player_gold / 100
                    else
                      5
                    end
  coins = 0
  until coins == total_player_gold
    a = case i % 3
        when 1
          34
        when 2
          93
        else
          31
        end
    c = if i.even?
          "\e[0;93m © \e[0m"
        else
          "\e[0;93m - \e[0m"
        end
    text = "you have \e[%dm%d#{c}\e[0m coins"
    i += 1
    printf text, a, coins
    coins += rand(increase_amount..increase_amount * 2)
    if coins >= total_player_gold
      a = 93
      c = "\e[0;93m © \e[0m"
      coins = total_player_gold
      printf "\r"
      printf text, a, coins
      break
    end
    printf "\r"
    sleep(s_time)
    s_time *= 1.05
  end
end
win_animation(94_570, i, 0.009)
