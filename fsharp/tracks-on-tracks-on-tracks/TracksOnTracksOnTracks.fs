module TracksOnTracksOnTracks

let newList: string list = []

let existingList: string list = [ "F#"; "Clojure"; "Haskell" ]

let addLanguage (language: string) (languages: string list): string list = language::languages

let countLanguages (languages: string list): int = 
    List.fold (fun acc _ -> acc + 1) 0 languages

let reverseList(languages: string list): string list = 
    List.fold (fun acc elem -> elem::acc) [] languages

let excitingList (languages: string list): bool =
    match languages with
    | l::_ | [ _; l] | [ _; l ; _] when l = "F#" -> true
    | _ -> false
