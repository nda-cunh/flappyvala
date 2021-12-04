project('flappy-vala', 'c', 'vala',
  version : '0.1',
  default_options : ['warning_level=1'])
add_project_arguments(['--pkg', 'posix'], language: 'vala')
add_project_arguments(['-X', '-llibm'], language: 'vala')

sdl_dep = dependency('sdl2', fallback : ['sdl2', 'sdl2_dep'])
sdlgfx_dep = dependency('SDL2_gfx')

glib_dep = dependency('glib-2.0')
gobject_dep = dependency('gobject-2.0')

subdir('lib')
burger_dep = declare_dependency(link_with : burger_lib, include_directories : include_directories('lib'))

#math_dep = dependency('m')

file_vala = [
	'main.vala',
	'Scene.vala',
	'Background.vala',
	'Personnage.vala',
	'Tuyau.vala',
	'Score.vala'
]


list_vala_dep = [
	sdl_dep,
	glib_dep,
	gobject_dep,
	burger_dep,
	#math_dep,
	sdlgfx_dep
]

subdir('src')
subdir('data')
source = join_paths(meson.source_root(), 'image')
dest = join_paths(meson.build_root(), 'image')
r = run_command('cp','-rf', source, dest)
if r.returncode() != 0
  warning('Command failed')
endif
