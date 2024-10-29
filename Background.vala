using sf;


public class Star {
	private RectangleShape rect;

	private Vector2f speed = {0.5f, 0.5f};
	public Star () {
		rect = new RectangleShape() {
			color = sf.Color(255, 255, 255, 200),
			outlineColor = sf.Color(255, 255, 255, 80),
			outlineThickness = 1
		};
		reset ();
		rect.position = {Random.int_range(-400, 600), Random.int_range(0, 500)};
	}

	private void reset () {
		rect.position = {Random.int_range(-500, 300), Random.int_range(-500, 0)};
		int size_value = Random.int_range(2, 5);
		rect.size = {size_value, size_value};
		if (Random.int_range(0, 25) == 1) {
			size_value = Random.int_range(20, 40);
			rect.size = {size_value, size_value};
		}
		float speed_value = (float)Random.double_range(0.1, 0.7);
		speed = {speed_value, speed_value};

	}

	public void gravity () {
		rect.move(speed);
		if (rect.position.x > 500 || rect.position.y > 500)
			reset ();
	}

	public void draw (RenderWindow window) {
		window.draw (rect);
	}
}

public class Background {
	public Texture texture_bg;
	public Sprite background;
	private AnimateSprite building;
	private AnimateSprite grass;
	private const int NB_STARS = 22;
	private Star stars[NB_STARS];


	public Background () throws Error {
		texture_bg = load_from_resource("/data/back.bmp");
		background = new Sprite() {
			texture = texture_bg
		};
		/* ANIMATIONS Grass and Building*/
		grass = new AnimateSprite("/data/grass.bmp") {
			y = height,
			speed = 0.007
		};
		building = new AnimateSprite("/data/building.bmp") {
			y = height - grass.height + 28,
			speed = 0.021
		};

		/* STARS */
		for (int i = 0; i < NB_STARS; i++)
		{
			stars[i] = new Star();
		}
	}


	public bool freeze {
		set {
			building.is_freeze = value;
			grass.is_freeze = value;
		}
	}

	public int width {
		get {
			return (int)texture_bg.width;
		}
	}

	public int height {
		get {
			return (int)texture_bg.height;
		}
	}


	Timer timer_stars = new Timer();
	public void draw (RenderWindow window) {
		window.draw(background);
		foreach (unowned var star in stars)
			star.draw(window);
		if (timer_stars.elapsed() > 0.02) {
			foreach (unowned var star in stars)
				star.gravity();
			timer_stars.reset();
		}
		building.draw(window);
		grass.draw(window);
	}
}
