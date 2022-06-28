module QueenAttack

let inRange index = 
  0 <= index && index <= 7  

let create (x, y) =
  inRange x && inRange y

let canAttack (queen1: int * int) (queen2: int * int) =
  let diffX = abs ((fst queen1) - (fst queen2))
  let diffY = abs ((snd queen1) - (snd queen2))
  diffX = 0 || diffY = 0 || diffX = diffY

