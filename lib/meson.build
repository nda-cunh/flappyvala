#burger_dep = declare_dependency(link_with : static_library('burger.so'), include_directories : include_directories('include'))

dep_list = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('sdl2'),
  dependency('SDL2_gfx'),
  dependency('SDL2_image'),
  ]

file_burger = ['Window.vala', 'Utils.vala',
  'Sprite.vala', 'Texture.vala',
  'Circle.vala', 'Drawable.vala',
  'Animate.vala']

burger_lib = shared_library('burger', file_burger,
  vala_header: 'burger.h',
  vala_vapi: 'burger.vapi',
  dependencies: dep_list,
  install: true,
  install_dir: [true, true, true])
