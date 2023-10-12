import os
import unittest
from count_substring import count_substring_in_fasta

class TestCountSubstringInFasta(unittest.TestCase):

    def test_single_sequence(self):
        content = ">TestSeq1\nAACGCTAACGCTAACGCT"
        expected_count = 3
        self.assertEqual(self.run_test(content), expected_count)

    def test_multiple_sequences(self):
        content = ">TestSeq1\nAACGCTAACGCT\n>TestSeq2\nCGTAACGCTGTA"
        expected_count = 3
        self.assertEqual(self.run_test(content), expected_count)

    def test_no_substring(self):
        content = ">TestSeq1\nCGTGTGCGTGTG"
        expected_count = 0
        self.assertEqual(self.run_test(content), expected_count)

    def test_empty_content(self):
        content = ""
        expected_count = 0
        self.assertEqual(self.run_test(content), expected_count)

    def run_test(self, content, substring="AACGCT"):
        with open("temp_test_file.fasta", "w") as file:
            file.write(content)
        result = count_substring_in_fasta("temp_test_file.fasta", substring)
        self.remove_temp_file()
        return result

    def remove_temp_file(self):
        try:
            os.remove("temp_test_file.fasta")
        except FileNotFoundError:
            pass

if __name__ == "__main__":
    unittest.main()
