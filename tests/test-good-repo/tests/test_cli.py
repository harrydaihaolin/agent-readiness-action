import io
import sys
import unittest
from contextlib import redirect_stdout

from good.cli import main


class TestCli(unittest.TestCase):
    def test_default(self):
        buf = io.StringIO()
        with redirect_stdout(buf):
            self.assertEqual(main([]), 0)
        self.assertIn("hello, world", buf.getvalue())

    def test_named(self):
        buf = io.StringIO()
        with redirect_stdout(buf):
            main(["--name", "agent"])
        self.assertIn("hello, agent", buf.getvalue())


if __name__ == "__main__":
    unittest.main()
