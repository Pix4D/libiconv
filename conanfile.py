from conans import ConanFile, CMake

class libiconvConan(ConanFile):
    name = 'libiconv'
    lib_version = '1.15.0'
    revision = '1'
    version = '{}-{}'.format(lib_version, revision)
    settings = 'os', 'compiler', 'build_type', 'arch'
    description = 'Convert text to and from Unicode'
    url = 'https://github.com/Pix4D/libiconv'
    license = 'LGPL-3.0'
    generators = 'cmake'
    exports_sources = '*'

    def build(self):
        cmake = CMake(self, parallel=True)
        cmake.definitions['BUILD_SHARED_LIBS'] = True
        cmake.configure()
        cmake.build(target='install')

    def package_info(self):
        self.cpp_info.libs = ['iconv']
   
    def package_id(self):
        # Make all options and dependencies (direct and transitive) contribute
        # to the package id
        self.info.requires.full_package_mode()
