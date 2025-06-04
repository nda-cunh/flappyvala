project('flappy_vala', ['c', 'vala'])


gnome = import('gnome')

asresources = gnome.compile_resources(
  'as-resources', 'gresource.xml',
  source_dir: 'data',
  c_name: 'as'
)


executable('flappy_vala',
  'main.vala',
  'Scene.vala',
  'Game.vala',
  'Menu.vala',
  'AnimatedSprite.vala',
  'Flappy.vala',
  'GameOver.vala',
  'Score.vala',
  'Ready.vala',
  'Background.vala',
  asresources,
  vala_args: ['--vapidir=' + meson.current_source_dir() + '/vapi', '--disable-assert'],
  c_args: '-w',
  dependencies : [
    dependency('csfml-all'),
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gio-2.0'),
  ],
  install : true)
