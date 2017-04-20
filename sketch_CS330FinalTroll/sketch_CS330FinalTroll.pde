//sketch_CS330TinaPathfinding - runs the game, adds stuff to the map, etc.
//Timothy Couch

/**
 * Change this to enable/disable grid drawing and stuff
 **/
boolean debug = true;

/**
 * This variable controls the demo instance
 * 0 - basic path, 1 - path to harry, 2 - path around obstacles
 **/
int variation = 0;

Menu mainMenu = new Menu();

boolean gameStart = false;

Grid grid = new Grid(29, 38, 16);
Pather pather = new Pather();

Objects objects = new Objects();
Keys keys = new Keys();

Tina tina;
Player player;
Harry harry;

PVector safeSpace = new PVector(19, 5);
PVector bridge = new PVector(5, 31);

void settings()
{
	size(grid.gridWidth * grid.gridSize, grid.gridHeight * grid.gridSize);
}

void setup()
{
	mainMenu.add(new Button(new PVector(width / 2, height / 4), "Variation 1"){
		public void clicked()
		{
			StartGame(0);
			mainMenu.setActive(false);
		}
	});
	mainMenu.add(new Button(new PVector(width / 2, height * 2 / 4), "Variation 2"){
		public void clicked()
		{
			StartGame(1);
			mainMenu.setActive(false);
		}
	});
	mainMenu.add(new Button(new PVector(width / 2, height * 3 / 4), "Variation 3"){
		public void clicked()
		{
			StartGame(2);
			mainMenu.setActive(false);
		}
	});
}

void StartGame(int var)
{
	variation = var;

	gameStart = true;

	player = (Player) objects.addGrid(new Player(new PVector(17, 31)));
	tina = (Tina) objects.addGrid(new Tina(bridge));

	if (variation == 1)
		harry = (Harry) objects.addGrid(new Harry(new PVector(19, 8)));

	if (variation == 2)
	{
		objects.addGrid(new Block(new PVector(12, 4)));
		objects.addGrid(new Block(new PVector(12, 5)));
		objects.addGrid(new Block(new PVector(12, 6)));
		objects.addGrid(new Block(new PVector(12, 7)));
		objects.addGrid(new Block(new PVector(12, 8)));
		objects.addGrid(new Block(new PVector(12, 9)));
		objects.addGrid(new Block(new PVector(12, 10)));
		objects.addGrid(new Block(new PVector(13, 11)));

		objects.addGrid(new Block(new PVector(7, 15)));
		objects.addGrid(new Block(new PVector(8, 15)));
		objects.addGrid(new Block(new PVector(9, 15)));
		objects.addGrid(new Block(new PVector(10, 15)));
		objects.addGrid(new Block(new PVector(11, 15)));
		objects.addGrid(new Block(new PVector(12, 15)));
		objects.addGrid(new Block(new PVector(13, 15)));
		objects.addGrid(new Block(new PVector(14, 15)));
		objects.addGrid(new Block(new PVector(15, 16)));
		objects.addGrid(new Block(new PVector(15, 17)));
		objects.addGrid(new Block(new PVector(16, 18)));
		objects.addGrid(new Block(new PVector(17, 19)));
		objects.addGrid(new Block(new PVector(17, 20)));

		objects.addGrid(new Block(new PVector(17, 10)));
		objects.addGrid(new Block(new PVector(18, 11)));
		objects.addGrid(new Block(new PVector(19, 12)));
		objects.addGrid(new Block(new PVector(20, 12)));
		objects.addGrid(new Block(new PVector(21, 12)));
	}
}

void draw()
{
	objects.KeysDown(keys);
	objects.draw();
}

void mousePressed()
{
	objects.MousePressed();
}

void keyPressed()
{
	if (keys.KeyPressed(key))
	{
		objects.KeyPressed(key);
	}
}

void keyReleased()
{
	if (keys.KeyReleased(key))
	{
		objects.KeyReleased(key);
	}
}
