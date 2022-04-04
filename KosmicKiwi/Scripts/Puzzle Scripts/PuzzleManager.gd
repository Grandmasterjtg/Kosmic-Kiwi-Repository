extends Node

var m_puzzles : Dictionary

signal test

func _ready():
	emit_signal("test")

func add_puzzle(puzzle_id: int):
	if !m_puzzles.has(puzzle_id):
		m_puzzles[puzzle_id] = false
	else:
		printerr("Puzzle attempted to add twice:")
		printerr(puzzle_id)

func check_puzzle_solved(puzzle_id: int) -> bool:
	if m_puzzles.has(puzzle_id):
		return m_puzzles[puzzle_id]
	else:
		printerr("No puzzle was found for puzzle_id:")
		printerr(puzzle_id)
		return false

func set_puzzle_solved(puzzle_id: int, state: bool):
	if m_puzzles.has(puzzle_id):
		m_puzzles[puzzle_id] = state
	else:
		printerr("No puzzle was found for puzzle_id:")
		printerr(puzzle_id)
