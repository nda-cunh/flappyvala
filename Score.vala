using sf;


class Number {
	private const int padding = 35;
	private Texture texture;
	public Sprite sprite;

	public Number () throws Error {
		texture = load_from_resource("/data/font.bmp");
		sprite = new Sprite() {
			texture = texture
		};
		sprite.y = 20;
		setNumber (0);
	}
	public void setNumber (int number) {
		sprite.setTextureRect ({padding * number, 0, padding, 45});
	}

	public void draw (RenderWindow target) {
		target.draw(sprite);
	}

	public Vector2f scale {
		set {
			sprite.scale = value;
		}
		get {
			return sprite.scale;
		}
	}
	public int x {
		set {
			sprite.x = value;
		}
	}
	public int y {
		set {
			sprite.y = value;
		}
	}
}

class Score {
	Number numberU;
	Number numberD;
	Number numberC;

	public Score () throws Error {
		numberU = new Number() {
			x = 410
		};
		numberD = new Number() {
			x = 375
		};
		numberC = new Number() {
			x = 340
		};
	}

	private bool _is_game_over;
	public bool is_game_over {
		get {
			return _is_game_over;
		}
		set {
			_is_game_over = value;
			if (_is_game_over) {
				numberU.x = 270;
				numberD.x = 200;
				numberC.x = 130;
				numberU.y = 280;
				numberD.y = 280;
				numberC.y = 280;
				numberU.scale = {2, 2};
				numberD.scale = {2, 2};
				numberC.scale = {2, 2};
			}
			else {
				numberU.x = 410;
				numberD.x = 375;
				numberC.x = 340;
				numberU.y = 20;
				numberD.y = 20;
				numberC.y = 20;
				numberU.scale = {1, 1};
				numberD.scale = {1, 1};
				numberC.scale = {1, 1};
			}
		}
	} 

	public void draw (RenderWindow target) {
		if (_is_game_over)
		{
			numberU.draw (target);
			numberD.draw (target);
			numberC.draw (target);
			return;
		}
		numberU.draw (target);
		if (score >= 10)
			numberD.draw (target);
		if (score >= 100)
			numberC.draw (target);
	}

	private int _score;

	public int score {
		get {
			return _score;
		}
		set {
			_score = value;
			numberU.setNumber (_score % 10);
			numberD.setNumber ((_score / 10) % 10);
			numberC.setNumber ((_score / 100) % 10);
		}
	}
}
