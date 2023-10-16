import unittest
import sys
sys.path.append('../substring_lambda')
from lambda_function import count_substring_in_fasta

class TestCountSubstringInFasta(unittest.TestCase):

    def test_single_sequence(self):
        content = ">TestSeq1\nAACGCTAACGCTAACGCT"
        expected_count = 3
        self.assertEqual(count_substring_in_fasta(content), expected_count)

    def test_multiple_sequences(self):
        content = ">TestSeq1\nAACGCTAACGCT\n>TestSeq2\nCGTAACGCTGTA"
        expected_count = 3
        self.assertEqual(count_substring_in_fasta(content), expected_count)

    def test_no_substring(self):
        content = ">TestSeq1\nCGTGTGCGTGTG"
        expected_count = 0
        self.assertEqual(count_substring_in_fasta(content), expected_count)

    def test_empty_content(self):
        content = ""
        expected_count = 0
        self.assertEqual(count_substring_in_fasta(content), expected_count)

if __name__ == "__main__":
    unittest.main()
