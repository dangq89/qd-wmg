def count_substring_in_fasta(filename, substring):
    count = 0
    sequence = ""

    with open(filename, 'r') as file:
        for line in file:
            # If it's not a description line, append it to the sequence.
            if not line.startswith('>'):
                sequence += line.strip()

    count = sequence.count(substring)
    return count

if __name__ == "__main__":
    
    filename = "random_sequences.fasta"
    substring="AACGCT"
    count = count_substring_in_fasta(filename, substring)
    print(f"The substring 'AACGCT' appears {count} times in {filename}.")