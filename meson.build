project('flappy-vala', 'c', 'vala',
  version : '1.0',
  default_options : ['warning_level=1'])

subproject('burger')

file_vala = [
	'main.vala',
	'Scene.vala',
	'Background.vala',
	'Personnage.vala',
	'Tuyau.vala',
	'Score.vala'
]

list_vala_dep = [
  dependency('burger-2.0'),
  dependency('sdl2'),
  dependency('SDL2_gfx'),
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

subdir('src')
subdir('data')
