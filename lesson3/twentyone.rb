def prompt(msg)
  puts "\n=> #{msg}"
end

# clean deck, 52 cards, hash, Key = Suit/Card, Value = Card value, no duplicates
FULL_DECK = [['A', '2'], ['A', '3'], ['A', '4'], ['A', '5'], ['A', '6'],
             ['A', '7'], ['A', '8'], ['A', '9'], ['A', '10'], ['A', 'J'],
             ['A', 'Q'], ['A', 'K'], ['A', 'A'], ['H', '2'], ['H', '3'],
             ['H', '4'], ['H', '5'], ['H', '6'], ['H', '7'], ['H', '8'],
             ['H', '9'], ['H', '10'], ['H', 'J'], ['H', 'Q'], ['H', 'K'],
             ['H', 'A'], ['S', '2'], ['S', '3'], ['S', '4'], ['S', '5'],
             ['S', '6'], ['S', '7'], ['S', '8'], ['S', '9'], ['S', '10'],
             ['S', 'J'], ['S', 'Q'], ['S', 'K'], ['S', 'A'], ['C', '2'],
             ['C', '3'], ['C', '4'], ['C', '5'], ['C', '6'], ['C', '7'],
             ['C', '8'], ['C', '9'], ['C', '10'], ['C', 'J'], ['C', 'Q'],
             ['C', 'K'], ['C', 'A']]

def bust?(hand)
  total_score(hand) > 21
end

def display_hand(hand, player_or_dealer, endgame = nil)
  displayed_hand = []
  hand.each do |card|
    displayed_hand << card[1]
  end

  if player_or_dealer == "player"
    puts "\nYour hand: #{displayed_hand.join(', ')}"
  elsif player_or_dealer == "dealer" && endgame == nil
    puts "\nDealer hand: #{displayed_hand[0..-2].join(', ')} and unkown card"
  elsif player_or_dealer == "dealer" && endgame == 'final score'
    puts "\nDealer final hand: #{displayed_hand.join(', ')}"
  end
end

def compare_hands(player, dealer)
  if total_score(player) > total_score(dealer)
    prompt("You win!")
  elsif total_score(dealer) > total_score(player)
    prompt("Dealer wins!")
  elsif total_score(dealer) == total_score(player)
    prompt("It's a tie!")
  end
end

def deal_card(deck)
  deck.delete_at(rand(deck.length))
end

def total_score(hand)
  values = hand.map {|card| card[1]}

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.select { |value| value == "A"}.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

## Main Game Loop
loop do
  system 'clear'
  prompt("Welcome to 21!")
  clean_deck = FULL_DECK.dup

  prompt("Dealing initial hands...")

  dealer_hand = [deal_card(clean_deck), deal_card(clean_deck)]
  player_hand = [deal_card(clean_deck), deal_card(clean_deck)]

  dealer_points = total_score(dealer_hand)
  player_points = total_score(player_hand)

  prompt("Initial Hands:")

  display_hand(player_hand, "player")
  puts "Your score: #{total_score(player_hand)}"

  display_hand(dealer_hand, "dealer")

  ## PLAYER TURN
  prompt("It's your turn! What'll it be?")

  answer = nil
  loop do
    puts "\nhit or stay?"
    answer = gets.chomp
    player_hand << deal_card(clean_deck) if answer == 'hit'
    display_hand(player_hand, "player")
    puts "Your score: #{total_score(player_hand)}"
    break if answer == 'stay' || bust?(player_hand)
  end

  if answer == 'stay'
    prompt("you chose to stay, here is your final hand and score")
    display_hand(player_hand, "player")
    puts "Your score: #{total_score(player_hand)}"
  elsif bust?(player_hand)
    prompt("You busted! Dealer wins!")
    display_hand(dealer_hand, "dealer", 'final score')
    puts "Dealer score: #{total_score(dealer_hand)}"
    break
  end

  ## DEALER TURN

  prompt("It's the dealers turn!")

  loop do
    break if total_score(dealer_hand) >= 17
    prompt("Dealer hits!")
    dealer_hand << deal_card(clean_deck)
    display_hand(dealer_hand, "dealer")
    puts "Dealer score: #{total_score(dealer_hand)}"
  end

  if !bust?(dealer_hand)
    prompt("Dealer chose to stay, here is their final hand and score")
    display_hand(dealer_hand, "dealer", 'final score')
    puts "Dealer score: #{total_score(dealer_hand)}"
  elsif bust?(player_hand)
    prompt("Dealer busted! You win!")
    display_hand(player_hand, "player")
    puts "Your score: #{total_score(player_hand)}"
    break
  end

  compare_hands(player_hand, dealer_hand)
  prompt("Play again? Y/N:")
  reply = gets.chomp.to_s.downcase
  break if reply == 'n'
end

prompt("Thanks for playing!")
