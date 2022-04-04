extends Node

var m_puzzles : Dictionary

func _ready():
	# gather all of the puzzles?
	# set ids?
	pass

func add_puzzle(puzzle_id: int):
	m_puzzles[puzzle_id] = false
	pass

func check_puzzle_solved(puzzle_id: int) -> bool:
	if (m_puzzles.has(puzzle_id)):
		return m_puzzles[puzzle_id]
	else:
		printerr("No puzzle was found for puzzle_id:")
		printerr(puzzle_id)
		return false

func set_puzzle_solved(puzzle_id: int, state: bool):
	if (m_puzzles.has(puzzle_id)):
		m_puzzles[puzzle_id] = state
	else:
		printerr("No puzzle was found for puzzle_id:")
		printerr(puzzle_id)
