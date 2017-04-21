//Todd - The final troll
//Timothy Couch

class Todd extends Movable
{
	//movement path for scenario 1
	int[] pArray = {
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.LEFT,
		GridDir.LEFT,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.DOWN,
		GridDir.DOWN,
		GridDir.DOWN,
		GridDir.DOWN,
		GridDir.DOWN,
		GridDir.DOWN,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.RIGHT,
		GridDir.RIGHT,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.NULL,
		GridDir.UP,
		GridDir.UP,
		GridDir.UP,
		GridDir.UP,
		GridDir.UP,
		GridDir.UP
		};

	Path path;
	PVector dest;
	boolean moved = false;
	
	boolean fighting = false;
	boolean fleeing = false;
	boolean healing = false;
	boolean resting = false;
	
	int energyCap = 600;
	int energy = energyCap;
	boolean tired = false;
	
	int harryDist = 10;
	
	int stepTimeCap = 5;
	int stepTime = stepTimeCap;
	
	int pathUpdateTimeCap = 60;
	int pathUpdateTime = pathUpdateTimeCap;
	
	Todd()
	{
		super();
		
		InitDefault();
	}

	Todd(PVector position)
	{
		super(position);
		
		InitDefault();
	}
	
	Todd(PVector position, int var)
	{
		super(position);
		
		InitDefault();
	}

	void InitDefault()
	{
		dest = calcDestination();
		
		path = MakePath();
		
		c = color(#15538c);
	}
	
	PVector calcDestination()
	{
		if (!tired)
			return bridge;
		else
			switch (variation)
			{
			case 0:
				return safeSpace;
			//case 1:
				//return harry.position;
			case 2:
				return safeSpace;
			default:
				return position;
			}
	}
	
	void step()
	{
		int moveDir = -1;
		stepTime--;
		if (stepTime <= 0)
		{
			stepTime = stepTimeCap;
			moveDir = path.step();
			moved = Move(moveDir);
		}
		
		if (tired)
			c = color(#002020);
		else c = color(#15538c);
		
		fighting = false;
		fleeing = false;
		healing = false;
		resting = false;
		
		if (!tired)
		{
			if (!moved)
			{
				if ((position.x != dest.x || position.y != dest.y) && moveDir != GridDir.NULL)// && finished)
					path = MakePath();
				energy--;
				if (new PVector(player.position.x - position.x, player.position.y - position.y).mag() < 4)
				{
					energy -= 3;
					fighting = true;
				}
			}
			
			if (energy <= 0)
			{
				tired = true;
				dest = calcDestination();
				path = MakePath();
			}
		}
		else
		{
			if (!moved)
			{
				if ((position.x != dest.x || position.y != dest.y) && finished)// && (variation != 1 || new PVector(harry.position.x - position.x, harry.position.y - position.y).mag() > harryDist))
					path = MakePath();
				if (new PVector(dest.x - position.x, dest.y - position.y).mag() <= 1.5)
				{
					if (variation != 1)
					{
						energy += 3;
						resting = true;
					}
					else
					{
						energy += 4;
						healing = true;
					}
				}
			}
			else fleeing = true;
			
			if (energy >= energyCap)
			{
				tired = false;
				dest = calcDestination();
				path = MakePath();
			}
		}
		
		pathUpdateTime--;
		if (pathUpdateTime <= 0 && (variation != 0 || tired))// && (variation != 1 || new PVector(harry.position.x - position.x, harry.position.y - position.y).mag() > harryDist))
		{
			if (variation == 1)
				dest = calcDestination();
			
			path = MakePath();
		}
}
	
	Path MakePath()
	{
		if (variation == 0 && !tired)
			return new Path(pArray, true);
		
		pathUpdateTime = pathUpdateTimeCap;
		Path p = pather.GeneratePath(position, dest);
		return p;
	}
	
	void draw()
	{
		super.draw();
		
		if (debug)
			path.draw();
	}
	
	/**
	 * This method is a simple replacement for animation. I could simply call some animator's method to animate, but that is too pseudocode-y.
	 * A good pseudocode replacement would be animate();
	 */
	void drawGUI()
	{
		String printString = "";
		if (fighting)
			printString = "Combat!";
		else if (fleeing)
			printString = "Fleeing!";
		else if (resting)
			printString = "Resting!";
		else if (healing)
			printString = "Healing!";
		
		fill(0);
		text(printString, (position.x + 5 / 2) * grid.gridSize - 1, (position.y + 3 / 2) * grid.gridSize - 1);
	}
}