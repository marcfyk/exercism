package parsinglogfiles

import (
	"fmt"
	"regexp"
)

func IsValidLine(text string) bool {
    return regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\] `).MatchString(text)
}

func SplitLogLine(text string) []string {
    return regexp.
        MustCompile(`<[^\w^\d]*>`).
        Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
    re := regexp.MustCompile(`(?i)".*password.*"`)
    count := 0
    for _, line := range lines {
        if re.MatchString(line) {
            count += 1
        }
    }
    return count
}

func RemoveEndOfLineText(text string) string {
    return regexp.MustCompile(`end-of-line\d*`).ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
    re := regexp.MustCompile(`User\s+(\w+)`)
    result := make([]string, 0)
    for _, line := range lines {
        if matches := re.FindStringSubmatch(line); matches != nil {
            line = fmt.Sprintf("[USR] %s %s", matches[1], line)
        }
        result = append(result, line)
    }
    return result
}
