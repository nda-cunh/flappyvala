using sf;

public class Flappy {
	private Texture texture_flappy[3];
	public Sprite sprite;
	public CircleShape circle;
	private Timer timer = new Timer();
	private const int nb_flappy_max = 3;
	private int nb_flappy = 0;
	public bool is_playing = false;

	public Flappy () throws Error {
		circle = new CircleShape();
		texture_flappy[0] = load_from_resource("/data/flappy1.bmp");
		texture_flappy[1] = load_from_resource("/data/flappy2.bmp");
		texture_flappy[2] = load_from_resource("/data/flappy3.bmp");
		sprite = new Sprite() {
			texture = texture_flappy[0]
		};
		onDeath.connect (() => {
			is_dead = true;
			if (my_speed_gravity < 0)
				my_speed_gravity = 0.0f;
		});
		sprite.origin = {0, texture_flappy[0].height / 2};
		circle.radius = 14.0f;
		circle.origin = {-3, 16.0f};
	}

	public float x {
		get { return sprite.x; }
		set { sprite.x = value; }
	}

	public float y {
		get { return sprite.y; }
		set { sprite.y = value;}
	}


	public void onJump () {
		my_speed_gravity = -7f;
		my_rotate = -25.0f;
		sprite.setRotation(my_rotate);
		circle.setRotation(my_rotate);
	}

	private float my_rotate_max = 45.0f;
	private float my_rotate = 0.0f;
	private float my_speed_gravity_max = 10.0f;
	private float my_speed_gravity = 0.0f;

	Timer timer_gravity = new Timer();
	private void gravity () {
		if (timer_gravity.elapsed() > 0.015) {
			timer_gravity.reset();
			if (my_speed_gravity_max > my_speed_gravity)
				my_speed_gravity += 0.33f;
			if (this.y < 520)
				sprite.move({0.0f, my_speed_gravity});
			if (my_rotate < my_rotate_max) {
				my_rotate += 1.2f;
			}
			sprite.setRotation(my_rotate);
			circle.setRotation(my_rotate);
		}
	}

	private bool is_dead = false;
	public signal void onDeath ();

	public void draw (RenderWindow window) {
		circle.position = {sprite.x, sprite.y};
		circle.fillColor = sf.Color.Red;
		if (is_dead == false) {
			if (is_playing)
				gravity ();
			if (timer.elapsed () > 0.087) {
				timer.reset();
				nb_flappy++;
				if (nb_flappy >= nb_flappy_max)
					nb_flappy = 0;
				sprite.texture = texture_flappy[nb_flappy];

			}
			if (sprite.y > window.height - 150)
				onDeath();
		}
		else {
			if (is_playing)
				gravity ();
		}
		window.draw(sprite);
	}
}
