#this file includes the creation of the various julian meshes, returning true if all of
#them are creates succesfully with no errors

using FEniCS


test_pytriangle = pyUnitTriangleMesh()
test_pytetrahedron = pyUnitTetrahedronMesh()
test_pyquadmesh =pyUnitQuadMesh(10,10) # is one of the experimental meshes, but
#works directly as a PyObject. Investigate this at a later stage?
test_pyinterval = pyUnitIntervalMesh(10)
test_pysquare = pyUnitSquareMesh(10,10,"crossed")
test_pycube = pyUnitCubeMesh(10,10,10)
test_pybox = pyBoxMesh(Point([0.0,0.0,0.0]),Point([1.0,1.0,1.0]),10,10,10)
test_pyrectangle = pyRectangleMesh(Point([0.0, 0.0]), Point([10.0, 4.0]), 10, 10)
test_meshcopy = pyMesh("./dolphin.xml")
true
