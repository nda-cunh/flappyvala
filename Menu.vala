using sf;

class Menu {
	private Texture texture_titre;
	private Sprite titre;
	private Flappy flappy;

	public Menu() throws Error {
		texture_titre = load_from_resource("/data/titre.bmp");
		titre = new Sprite() {
			texture = texture_titre
		};
		titre.setPosition ({55, 100});
		flappy = new Flappy() {
			x = 150,
			y = 250
		};
	}

	public void draw (RenderWindow window) {
		window.draw(titre);
		flappy.draw (window);
	}
}
