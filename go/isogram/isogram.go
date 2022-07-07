package isogram

import "strings"

func IsIsogram(word string) bool {
    frequencies := make(map[rune]struct{})
    formatted_word := strings.ToUpper(word)
    formatted_word = strings.ReplaceAll(formatted_word, "-", "")
    formatted_word = strings.ReplaceAll(formatted_word, " ", "")
    runes := []rune(formatted_word)
    for _, c := range runes {
        if _, ok := frequencies[c]; ok {
            return false
        }
        frequencies[c] = struct{}{}
    }
    return true
}
