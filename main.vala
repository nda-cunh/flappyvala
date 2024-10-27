using sf;


public Texture load_from_resource(string path) throws Error 
{
	var data = resources_lookup_data(path, NONE);
	var texture = new Texture.fromMemory(data.get_data(), data.length);
	if (texture == null)
		throw new ConvertError.FAILED("Failed to load texture from resource");
	return texture;
}

void main() {
	try {
		var scene = new Scene();
		scene.loop();
	}
	catch (Error e) {
		printerr("An error occurred: %s\n", e.message);
	}
}

