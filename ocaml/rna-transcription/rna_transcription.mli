(** Rna-transcription exercise *)

type dna = [ `A | `C | `G | `T ]
type rna = [ `A | `C | `G | `U ]

val to_rna : dna list -> rna list
(** Transcribe DNA to RNA by replacing 'T' with 'U'. *)
