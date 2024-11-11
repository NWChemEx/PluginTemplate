"""Driver for integration tests.

This file drives your integration tests. To run the integration tests (assuming
your Python path is setup correctly) simply type:

.. code-block:: terminal

   python test_{{ cookiecutter.project_slug }}.py


The driver assumes that your integration tests live in importable Python
modules next to this file.
"""

import os
import parallelzone as pz
import sys
import unittest

if __name__ == '__main__':

    # Ensure a RuntimeView object persists through all tests
    rv = pz.runtime.RuntimeView()

    # Works out the path to the directory containing the driver
    my_dir = os.path.dirname(os.path.realpath(__file__))

    #Find and run the tests, then return the result
    loader = unittest.TestLoader()
    tests = loader.discover(my_dir)
    testrunner = unittest.runner.TextTestRunner()
    ret = not testrunner.run(tests).wasSuccessful()
    sys.exit(ret)
