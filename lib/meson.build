#burger_dep = declare_dependency(link_with : static_library('burger.so'), include_directories : include_directories('include'))
burger_lib = shared_library('burger', 'burger.vala',
                  vala_header: 'burger.h',
                  vala_vapi: 'burger.vapi',
                  dependencies: [glib_dep, sdl_dep, gobject_dep, sdlgfx_dep],
                  install: true,
                  install_dir: [true, true, true])
