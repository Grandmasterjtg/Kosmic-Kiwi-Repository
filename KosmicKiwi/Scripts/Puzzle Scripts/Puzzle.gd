extends Node

class_name Puzzle

var m_id : int
var m_solved := false

func _ready():
	PuzzleManager.add_puzzle(m_id)
	if PuzzleManager.check_puzzle_solved(m_id):
		solve_puzzle()

func solve_puzzle():
	print("Solved!")
	# play the solving animation
	$AnimatedSprite.play("left")
	
	# if the puzzle is already solved, play only the last frame of the animation
	if PuzzleManager.check_puzzle_solved(m_id):
		$AnimatedSprite.set_frame($AnimatedSprite.get_sprite_frames().get_frame_count("left")-1)
	else: 
		PuzzleManager.set_puzzle_solved(m_id, true)

func ready_puzzle():
	pass

func _process(delta):
	if Input.is_action_just_pressed("hotbar_1"):
		solve_puzzle()
