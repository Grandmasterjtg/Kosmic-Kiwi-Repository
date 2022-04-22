extends Node

var m_resources : Dictionary
#var m_puzzles : Dictionary # { PlanetName: { PuzzleIndex: IsSolved } }

func _ready():
	var planets = PlanetManager.get_planets()
	for planet in planets:
		m_resources[planet.get_planet_name()] = {}

# takes an id (Vector2)
# add the id to the resources dictionary
# value as not destoryed
func add_resource(puzzle_id: Vector2):
	var active_planet_name = PlanetManager.get_active_planet().get_planet_name()
	# make sure not to add the same puzzle twice
	if m_resources.has(active_planet_name) and !m_resources[active_planet_name].has(puzzle_id):
		m_resources[active_planet_name][puzzle_id] = false
		
# takes an id
# returns true if the resource has been destroyed
func check_resource_destroyed(puzzle_id: Vector2) -> bool:
	var active_planet = PlanetManager.get_active_planet().get_planet_name()
	
	if m_resources.has(active_planet) and m_resources[active_planet].has(puzzle_id):
		return m_resources[active_planet][puzzle_id]
	else:
		return false
		
# takes a buzzle id and whether or not the resource should be destroyed
# sets the state of the resource
func set_resource_destroyed(puzzle_id: Vector2, state: bool):
	var active_planet = PlanetManager.get_active_planet().get_planet_name()
	if m_resources.has(active_planet) and m_resources[active_planet].has(puzzle_id):
		m_resources[active_planet][puzzle_id] = state
