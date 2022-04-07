extends Node

# TODO
# each level needs its own puzzle Dictionary!
var m_puzzles : Dictionary
#var m_puzzles : Dictionary # { PlanetName: { PuzzleIndex: IsSolved } }

func _ready():
	var planets = PlanetManager.get_planets()
	for planet in planets:
		m_puzzles[planet.get_planet_name()] = {}
	

func add_puzzle(puzzle_id: int):
	var active_planet_name = PlanetManager.get_active_planet().get_planet_name()
	
	# make sure not to add the same puzzle twice
	if m_puzzles.has(active_planet_name) and !m_puzzles[active_planet_name].has(puzzle_id):
		m_puzzles[active_planet_name][puzzle_id] = false

func check_puzzle_solved(puzzle_id: int) -> bool:
	var active_planet = PlanetManager.get_active_planet().get_planet_name()
	
	
	if m_puzzles.has(active_planet) and m_puzzles[active_planet].has(puzzle_id):
		return m_puzzles[active_planet][puzzle_id]
	else:
		printerr("No puzzle was found for puzzle_id: " + active_planet + " " + str(puzzle_id))
		return false

func set_puzzle_solved(puzzle_id: int, state: bool):
	var active_planet = PlanetManager.get_active_planet().get_planet_name()
	if m_puzzles.has(active_planet) and m_puzzles[active_planet].has(puzzle_id):
		m_puzzles[active_planet][puzzle_id] = state
	else:
		printerr("No puzzle was found for puzzle_id: " + active_planet + " " + str(puzzle_id))
