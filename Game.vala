using sf;

private class Tuyau {
	public Texture texture_end;
	public Texture texture_tuyau;
	public Sprite end;
	public Sprite tuyau;
	public Sprite end_top;
	public Sprite tuyau_top;
	private int equart;
	public bool passed = false;

	public Tuyau () throws Error {
		texture_end = load_from_resource("/data/tuyauC.bmp");
		texture_tuyau = load_from_resource("/data/tuyau.bmp");

		equart = Random.int_range (160, 220);
		end = new Sprite() {
			texture = texture_end
		};
		tuyau = new Sprite() {
			texture = texture_tuyau,
			position = {4, 18}
		};
		end_top = new Sprite() {
			texture = texture_end,
			position = {0, 0}
		};
		tuyau_top = new Sprite() {
			texture = texture_tuyau,
			position = {4, 18},
			origin = {0, texture_tuyau.height}
		};
		y = Random.int_range (220, 490);
	}

	public void collide (Flappy flappy) {
		unowned var sprite = flappy.sprite;
		if (sprite.getGlobalBounds ().intersects (tuyau.getGlobalBounds ()))
			flappy.onDeath();
		if (sprite.getGlobalBounds ().intersects (tuyau_top.getGlobalBounds ()))
			flappy.onDeath();

		if (sprite.getGlobalBounds ().intersects (end.getGlobalBounds ()))
			flappy.onDeath();
		if (sprite.getGlobalBounds ().intersects (end_top.getGlobalBounds ()))
			flappy.onDeath();
		if (sprite.position.y < 0 || sprite.position.y > 580)
			flappy.onDeath();
		
	}
	
	
	public void draw (RenderWindow window) {
		window.draw(end_top);
		window.draw(tuyau_top);
		window.draw(end);
		window.draw(tuyau);
	}

	public int x {
		get {
			return (int)end.position.x;
		}
		set {
			end.x = value;
			tuyau.x = value + 4;
			tuyau_top.x = tuyau.x;
			end_top.x = value;
		}
	}

	private int y {
		get {
			return (int)end.position.y;
		}
		set {
			end.y = value;
			tuyau.y = value + 18;
			tuyau_top.y = value - equart + 18;
			end_top.y = tuyau_top.y;
		}
	}

	public void move (int speed) {
		x -= speed;
	}

}

public class Game {
	public bool is_dead = false;
	private const int TUYAU_COUNT = 3;
	private Tuyau tuyau[TUYAU_COUNT];
	public Game () throws Error {
		for (int i = 0; i < TUYAU_COUNT; i++)
		{
			tuyau[i] = new Tuyau() {
				x = 800 + i * 300
			};
		}
	} 

	public signal void onPipe (); // TODO rename it

	public void collide (Flappy flappy) {
		foreach (unowned Tuyau t in tuyau) {
			t.collide(flappy);
			if (t.x < flappy.x && t.passed == false) {
				t.passed = true;
				onPipe();
			}
		}
	}

	private Timer timer = new Timer();
	public void draw (RenderWindow window) {
		if (is_dead == false) {
			if (timer.elapsed () > 0.007) {
				foreach (unowned Tuyau d in tuyau) {
					d.move(2);
					if (d.x < -100) {
						d.x = TUYAU_COUNT * 300 - 100;
						d.passed = false;
					}
				}
				timer.reset();
			}
		}

		foreach (unowned Tuyau tuyau1 in tuyau) {
			tuyau1.draw(window);
		}
	}
}
