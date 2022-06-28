module LogLevels

let message (logLine: string): string =
    logLine.IndexOf(":") + 1
    |> logLine.Substring
    |> fun result -> result.Trim()


let logLevel(logLine: string): string =
    let start = logLine.IndexOf("[") + 1
    let stop = logLine.IndexOf("]") - 1
    logLine.Substring(start, stop).ToLower()

let reformat(logLine: string): string =
    sprintf "%s (%s)" (message logLine) (logLevel logLine)
