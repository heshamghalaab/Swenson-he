import Foundation

/*
 II. Write a function/method utilizing Swift to determine whether two strings are anagrams or not (examples of anagrams: debit card/bad credit, punishments/nine thumps, etc.)
 */

extension String{
    func isAnagram(of word: String) -> Bool {
        return sortLetters(in: self) == sortLetters(in: word)
    }

    private func sortLetters(in word: String) -> String {
        return String(word.lowercased().sorted()).trimmingCharacters(in: .whitespaces)
    }
}

let isAnagram = "debit card".isAnagram(of: "bad credit")

if isAnagram{
    print("the two words are anagrams")
}else{
    print("the two words are not anagrams")
}


