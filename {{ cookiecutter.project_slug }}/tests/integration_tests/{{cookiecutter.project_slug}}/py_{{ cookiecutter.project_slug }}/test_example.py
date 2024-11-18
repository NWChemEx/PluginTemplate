""" Example of how to use the full NWX ecosystem in a test.

In the setUp method for this test we load ALL of the released NWX plugins. We
then load this plugin, i.e., the plugin we are testing.
"""

import nwchemex as nwx
import simde
import pluginplay
import unittest
import {{ cookiecutter.project_slug }}

class AnExampleIntegrationTest(unittest.TestCase):

    def testMoleculeFromString(self):
        mol_pt = simde.MoleculeFromString()
        sys_maker_key = 'ChemicalSystem via QCElemental'

        mol_str = """
        H       -1.958940   -0.032063    0.725554
        H       -0.607485    0.010955    0.056172
        O       -1.538963    0.004548   -0.117331
        H        1.727607    0.762122   -0.351887
        H        1.704312   -0.747744   -0.399151
        O        1.430776   -0.003706    0.113495
        """

        water_dimer = self.mm.run_as(mol_pt, sys_maker_key, mol_str)
        print(water_dimer)

    def setUp(self):
        self.mm = pluginplay.ModuleManager()
        
        nwx.load_modules(self.mm)
        {{ cookiecutter.project_slug}}.load_modules(self.mm) 

