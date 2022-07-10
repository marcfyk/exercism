use std::cmp::Ordering;
use std::collections::{HashMap, HashSet};
use std::hash::Hash;
/// Given a list of poker hands, return a list of those hands which win.
///
/// Note the type signature: this function should return _the same_ reference to
/// the winning hand(s) as were passed in, not reconstructed strings which happen to be equal.
pub fn winning_hands<'a>(hands: &[&'a str]) -> Vec<&'a str> {
    let mut hands = hands.iter()
        .map(|hand| Hand::build(hand))
        .collect::<Vec<_>>();
    hands.sort_by(|x, y| x.poker_hand.partial_cmp(&y.poker_hand).unwrap().reverse());
    let best_poker_hand = &hands.first().unwrap().poker_hand;
    hands.iter()
        .take_while(|h| h.poker_hand.partial_cmp(best_poker_hand) == Some(Ordering::Equal))
        .map(|h| h.hand)
        .collect()
}

#[derive(PartialOrd, Ord, PartialEq, Eq, Hash, Clone, Copy, Debug)]
enum Suit { Diamond, Clubs, Hearts, Spades, }

impl TryFrom<char> for Suit {
    type Error = ();
    fn try_from(value: char) -> Result<Self, Self::Error> {
         match value {
            'D' => Ok(Self::Diamond),
            'C' => Ok(Self::Clubs),
            'H' => Ok(Self::Hearts),
            'S' => Ok(Self::Spades),
            _ => Err(())
        }
    } 
}

#[derive(PartialOrd, Ord, PartialEq, Eq, Hash, Clone, Copy, Debug)]
enum Rank {
    Two = 2, Three = 3, Four = 4, 
    Five = 5, Six = 6, Seven = 7,
    Eight = 8, Nine = 9, Ten = 10,
    Jack = 11, Queen = 12, King = 13,
    Ace = 14,
}

impl TryFrom<&String> for Rank {
    type Error = ();
    fn try_from(value: &String) -> Result<Self, Self::Error> {
        match value.as_str() {
            "2" => Ok(Self::Two), "3" => Ok(Self::Three), "4" => Ok(Self::Four),
            "5" => Ok(Self::Five), "6" => Ok(Self::Six), "7" => Ok(Self::Seven),
            "8" => Ok(Self::Eight), "9" => Ok(Self::Nine), "10" => Ok(Self::Ten),
            "J" => Ok(Self::Jack), "Q" => Ok(Self::Queen), "K" => Ok(Self::King),
            "A" => Ok(Self::Ace),
            _ => Err(())
        } 
    }
}

#[derive(PartialOrd, Ord, PartialEq, Eq, Clone, Copy, Debug)]
struct Card {
    rank: Rank,
    suit: Suit,
}

impl TryFrom<&String> for Card {
    type Error = ();
    fn try_from(value: &String) -> Result<Self, Self::Error> {
        let mut letters = value.chars().collect::<Vec<_>>();
        let suit = match Suit::try_from(letters.pop().unwrap()) {
            Ok(suit) => suit,
            Err(()) => return Err(())
        };
        let rank = match Rank::try_from(&letters.iter().collect::<String>()) {
            Ok(rank) => rank,
            Err(()) => return Err(())
        };
        Ok(Card { suit, rank })
    }
}

#[derive(Debug)]
struct Hand<'a> {
    poker_hand: PokerHand,
    hand: &'a str,
}

impl<'a> PartialEq<Hand<'a>> for Hand<'a> {
    fn eq(&self, other: &Hand<'a>) -> bool {
        self.poker_hand.eq(&other.poker_hand)
    }
}

impl<'a> PartialOrd<Hand<'a>> for Hand<'a> {
    fn partial_cmp(&self, other: &Hand<'a>) -> Option<Ordering> {
        self.poker_hand.partial_cmp(&other.poker_hand)
    }
}

impl<'a> Hand<'a> {
    fn build<'b>(hand: &'b str) -> Hand<'b> {
        let mut cards = hand.to_owned()
            .split(" ")
            .map(|card_letters| Card::try_from(&card_letters.to_owned()))
            .map(|card_result| card_result.unwrap())
            .collect::<Vec<_>>();
        cards.sort_by(|x, y| x.cmp(&y));
        let poker_hand = PokerHand::from(&cards);

        Hand{
            poker_hand: poker_hand,
            hand: hand,
        }
    }
}

#[derive(PartialOrd, Ord, PartialEq, Eq, Clone, Debug)]
enum PokerHand {
    HighCard(Vec<Rank>),
    Pair(Rank, Rank),
    TwoPair(Rank, Rank, Rank),
    ThreeOfAKind(Rank, Rank),
    Straight(Rank),
    Flush(Vec<Rank>),
    FullHouse(Rank, Rank),
    FourOfAKind(Rank, Rank),
    StraightFlush(Rank),
}

impl From<&Vec<Card>> for PokerHand {
    fn from(cards: &Vec<Card>) -> Self {
        let mut patterns = cards.iter().fold(HashMap::new(), |mut acc, card| {
                *acc.entry(card.rank).or_insert(0) += 1;
                acc
            })
            .iter()
            .map(|(rank, count)| (*rank, *count))
            .collect::<Vec<_>>();
        patterns.sort_by(|(_, c1), (_, c2)| c1.cmp(c2).reverse());

        match patterns.as_slice() {
            [(a, 4), (b, 1)] => Self::FourOfAKind(*a, *b),
            [(a, 3), (b, 2)] => Self::FullHouse(*a, *b),
            [(a, 3), (b, 1), (c, 1)] => Self::ThreeOfAKind(*a, *b.max(c)),
            [(a, 2), (b, 2), (c, 1)] => Self::TwoPair(*a.max(b), *a.min(b), *c),
            [(a, 2), (b, 1), (c, 1), (d, 1)] => Self::Pair(*a, *b.max(c).max(d)),
            _ => {
                let is_flush = cards.iter()
                    .map(|c| c.suit)
                    .collect::<HashSet<_>>()
                    .len() == 1;
                let straight_five = vec![Rank::Two, Rank::Three, Rank::Four, Rank::Five, Rank::Ace];
                let mut ranks = cards.iter().map(|c| c.rank).collect::<Vec<_>>();
                let is_straight = ranks == straight_five ||
                    ranks.windows(2)
                    .all(|window| (window[1] as i8) == (window[0] as i8 + 1));
                let max_rank = *ranks.iter().max().unwrap();
                let max_straight = if ranks == straight_five { Rank::Five } else { max_rank };

                if is_flush && is_straight {
                    Self::StraightFlush(max_straight)
                } else if is_flush {
                    ranks.sort_by(|x, y| x.cmp(&y).reverse());
                    Self::Flush(ranks)
                } else if is_straight {
                    Self::Straight(max_straight)
                } else {
                    ranks.sort_by(|x, y| x.cmp(&y).reverse());
                    Self::HighCard(ranks)
                }
            },
        }
    }
}

