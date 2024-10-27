using sf;

public class GameOver {
	private Texture texture;
	private Sprite sprite;

	public GameOver () throws Error  {
		texture = load_from_resource("/data/gameover.bmp");
		sprite = new Sprite() {
			texture = texture,
			position = {50, 90}
		};
	}

	public void draw (RenderWindow window) {
		window.draw(sprite);
	}
}
