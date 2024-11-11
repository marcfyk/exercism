type dna = [ `A | `C | `G | `T ]
type rna = [ `A | `C | `G | `U ]

let rna_to_dna = function `A -> `U | `C -> `G | `G -> `C | `T -> `A
let to_rna = List.map rna_to_dna
