module ValentinesDay

type Approval = Yes | No | Maybe

type Cuisine = Korean | Turkish

type Genre = Crime | Horror | Romance | Thriller

type Activity = BoardGame | Chill | Movie of Genre | Restaurant of Cuisine | Walk of int
 
let rateActivity (activity: Activity): Approval =
    match activity with
    | Movie m when m = Romance -> Yes
    | Restaurant r when r = Korean -> Yes
    | Restaurant r when r = Turkish -> Maybe
    | Walk n when n < 3 -> Yes
    | Walk n when n < 5 -> Maybe
    | otherwise -> No

