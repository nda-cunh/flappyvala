using sf;


/**
* AnimatedSprite class to animate a sprite left to right
* used for the grass and the building texture
*/	
public class AnimateSprite {
	private Texture texture;
	private Sprite sprites[nb];
	private const int nb = 6;
	private Timer timer;
	public bool is_freeze = false;

	public AnimateSprite (string texture_path) throws Error {
		texture = load_from_resource(texture_path);
		timer = new Timer();
		for (int i = 0; i < nb; i++)
		{
			sprites[i] = new Sprite() {
				texture = texture,
				x = i * texture.width,
				origin = {0, texture.height},
			};
		}
	}


	public double speed {get; set;}

	public uint height {
		get {
			return texture.height;
		}
	}

	public uint y {
		set {
			foreach (unowned var d in sprites)
				d.position = {d.x, value};
		}
	}

	public void draw (RenderWindow window) {
		if (is_freeze == false && timer.elapsed () >= speed) {
			foreach (unowned var d in sprites)
				d.move({-1.0f, 0.0f});
			timer.reset();
		}
		foreach (unowned var d in sprites) {
			if (d.x < - (float)texture.width) {
				d.x = (nb - 1) * texture.width - 1;
			}
		}
		foreach (unowned var d in sprites)
			window.draw(d);
	}
}
