using sf;


public class Scene {
	private enum Activity {
		Menu,
		Play,
		Ready,
		GameOver
	}

	private Activity activity = Activity.Menu;
	private RenderWindow window;
	private Flappy flappy;
	private GameOver gameover;
	private Game game;
	private Menu menu;
	private Ready ready;
	private Score score;
	private Background background;

	public Scene () throws Error {
		background = new Background();
		window = new RenderWindow(VideoMode(background.width, background.height), "Flappy Vala !") {
			fps = 300
		};

		gameover = new GameOver();
		menu = new Menu();
		score = new Score();
		ready = new Ready();

		restart ();
		activity = Activity.Menu;
	}


	public void restart () throws Error {
		/* FLAPPY (Personnage) */
		flappy = new Flappy() {
			x = 150,
			y = 250
		};
		flappy.onDeath.connect (() => {
			this.activity = Activity.GameOver;
			background.freeze = true;
			game.is_dead = true;
			score.is_game_over = true;
			gameover.init_cooldown ();
		});
		game = new Game();
		game.onPipe.connect (() => {
			score.score++;
		});

		background.freeze = false;
		score.score = 0;
		activity = Activity.Ready;
		score.is_game_over = false;
	}


	/******************
	 *     LOOP       *
	 ******************/
	private void loop_event () throws Error {
		Event event;
		while (window.pollEvent(out event))
		{
			if (event.type == EventType.Closed)
				window.close();
			if (event.type == EventType.KeyPressed && event.key.code == sf.KeyCode.Escape)
				window.close();
			switch (this.activity) {
				case Activity.Menu:
					if (event.type == EventType.KeyPressed || event.type == EventType.MouseButtonPressed) {
						if (event.key.code == sf.KeyCode.Space || event.type == EventType.MouseButtonPressed) {
							this.activity = Activity.Ready;
						}
					}
					break;
				case Activity.Ready:
					if (event.type == EventType.KeyPressed || event.type == EventType.MouseButtonPressed) {
						if (event.key.code == sf.KeyCode.Space || event.type == EventType.MouseButtonPressed) {
							this.activity = Activity.Play;
							flappy.onJump ();
						}
					}
					break;
				case Activity.Play:
					// right click or space
					if (event.type == EventType.KeyPressed)
						if (event.key.code == sf.KeyCode.Space)
							flappy.onJump ();
					if (event.type == EventType.MouseButtonPressed)
						flappy.onJump ();
					break;
				case Activity.GameOver:
					if (event.key.code == sf.KeyCode.Space || event.type == EventType.MouseButtonPressed) {
						if (gameover.cooldown() == true)
							restart();
					}
					break;
			}
		}
	}

	public void loop () throws Error {
		while (window.isOpen())
		{
			loop_event ();

			window.clear();

			/* Drawing Background and Fixed Sprites */
			background.draw(window);

			switch (this.activity) {
				case Activity.Menu:
					menu.draw(window);
					break;
				case Activity.Ready:
					ready.draw(window);
					break;
				case Activity.Play:
					flappy.is_playing = true;
					game.collide (flappy);
					game.draw(window);
					score.draw (window);
					flappy.draw(window);
					break;
				case Activity.GameOver:
					game.draw(window);
					gameover.draw(window);
					score.draw (window);
					flappy.draw(window);
					break;
			}
			window.display();
		}
	}
}
