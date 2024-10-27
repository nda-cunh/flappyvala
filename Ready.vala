using sf;
public class Ready {
	private Flappy flappy;
	private Texture texture_getready;
	private Sprite getready;
	private Texture texture_tapme;
	private Sprite tapme;
	private Timer timer = new Timer ();
	
	public Ready () throws Error {
			flappy = new Flappy () {
			x = 150,
			y = 250
		};
		texture_getready = load_from_resource ("/data/get_ready.bmp");
		getready = new Sprite () {
			texture = texture_getready,
			x = 60,
			y = 120
		};
		texture_tapme = load_from_resource ("/data/tap_me.bmp");
		tapme = new Sprite () {
			texture = texture_tapme,
			x = 153,
			y = 310
		};
	}

	private bool tapme_visible = true;

	public void draw (RenderWindow window) {
		flappy.draw (window);
		window.draw (getready);
		if (timer.elapsed () > 0.5) {
			tapme_visible = !tapme_visible;
			timer.reset ();
		}
		if (tapme_visible)
			window.draw (tapme);
	}
}
