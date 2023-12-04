import os
from conans import ConanFile, CMake, tools

class LibraryTestConan(ConanFile):
    settings = 'os', 'compiler', 'build_type', 'arch'
    generators = 'cmake'

    def imports(self):
        self.copy('*.dll',   src='bin', dst=os.path.join('install', 'bin'))
        self.copy('*.dylib', src='lib', dst=os.path.join('install', 'lib'))
        self.copy('*.so*',   src='lib', dst=os.path.join('install', 'lib'))

    def build(self):
        cmake = CMake(self)
        cmake.configure(defs={'CMAKE_INSTALL_PREFIX':'install'})
        cmake.build(target='install')

    def test(self):
        self.run(os.path.join('install', 'bin', 'testApp'))
