public string IMAGE_DIR;

void main(){
	var h = GLib.Environment.get_home_dir();
	IMAGE_DIR =  h + "/.local/share/flappy/";
	var scene = new Scene();

	scene.run();
}
