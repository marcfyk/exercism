module TisburyTreasureHunt

let getCoordinate (line: string * string): string = snd line

let convertCoordinate (coordinate: string): int * char = 
    let chars = Seq.toList coordinate
    let number = chars[0] |> string |> int
    let letter = chars[1]
    (number, letter)

let compareRecords (azarasData: string * string) (ruisData: string * (int * char) * string) : bool = 
    let (_, coordinate, _) = ruisData
    azarasData
    |> getCoordinate
    |> convertCoordinate
    |> fun c -> c = coordinate

let createRecord (azarasData: string * string) (ruisData: string * (int * char) * string) : (string * string * string * string) =
    if compareRecords azarasData ruisData then
        let (treasure, coordinate) = azarasData
        let (location, _, quadrant) = ruisData
        (coordinate, location, quadrant, treasure)
    else
        ("", "", "", "")
