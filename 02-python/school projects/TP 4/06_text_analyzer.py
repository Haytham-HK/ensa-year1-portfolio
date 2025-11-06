def analyze_phrases(phrases):
    all_words = []
    for phrase in phrases:
        words_low = phrase.lower()
        words_clean = words_low.split()
        all_words.extend(words_clean)

    unique_words = set(all_words)

    total_count = len(all_words)
    unique_count = len(unique_words)

    if unique_words:
        longest_word = max(unique_words, key=len)
        longest_length = len(longest_word)
    else:
        longest_word = None
        longest_length = 0

    max_count = 0
    most_frequent_word = None

    for current_word in unique_words:
        count = all_words.count(current_word)
        if count > max_count:
            max_count = count
            most_frequent_word = current_word

    results = {
        "total_count": total_count,
        "unique_count": unique_count,
        "longest_word": longest_word,
        "longest_length": longest_length,
        "most_frequent_word": most_frequent_word,
        "frequency_max": max_count,
    }

    return results


phrase_list = []
print("Enter phrases one by one. Type 'exit' to stop.")

while True:
    words = input("> ")
    if words.lower() == "exit":
        break
    if words:
        phrase_list.append(words)

if not phrase_list:
    print("No phrases entered. Exiting.")
else:
    result = analyze_phrases(phrase_list)
    print("\n--- Analysis Results ---")
    print(f"Total number of words: {result['total_count']}")
    print(f"Number of unique words: {result['unique_count']}")
    print(f"Longest word: '{result['longest_word']}' (Length: {result['longest_length']})")
    print(f"Most frequent word: '{result['most_frequent_word']}' (Frequency: {result['frequency_max']})")