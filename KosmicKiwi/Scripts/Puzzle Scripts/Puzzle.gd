extends Node

class_name Puzzle

var m_id : int
var m_solved := false

func _ready():
	# setup puzzle
	ready_puzzle()
	
	# connect to interactable
	$Interactable.connect("interacted",self,"on_interact")

func ready_puzzle():
	m_id = self.get_index()
	print("index: " + str(m_id))
	PuzzleManager.add_puzzle(m_id)
	if PuzzleManager.check_puzzle_solved(m_id):
		solve_puzzle()

func solve_puzzle():
	print("Solved!")
	var already_solved = PuzzleManager.check_puzzle_solved(m_id)
	# play the solving animation
	$AnimatedSprite.play("solved")
	
	# if the puzzle is already solved, play only the last frame of the animation
	if !already_solved:
		print("Puzzle solved for the first time!")
		PuzzleManager.set_puzzle_solved(m_id, true)
		$AnimatedSprite.set_frame($AnimatedSprite.get_sprite_frames().get_frame_count("solved")-1)
	else:
		print("Puzzle " + str(m_id) + " already solved.")

func on_interact():
	solve_puzzle()

func _process(delta):
	if Input.is_action_just_pressed("hotbar_1"):
		solve_puzzle()
