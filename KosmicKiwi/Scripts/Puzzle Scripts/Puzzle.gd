extends Node2D

class_name Puzzle

var m_id : Vector2
export var type : String

func _ready():
	# setup puzzle
	ready_puzzle()

func ready_puzzle():
	m_id = self.get_global_position()
	PuzzleManager.add_puzzle(m_id)
	if PuzzleManager.check_puzzle_solved(m_id):
		solve_puzzle()

func solve_puzzle():
	var already_solved = PuzzleManager.check_puzzle_solved(m_id)
	
	# play the solving animation
	$AnimatedSprite.play("solved")
	$Collider.disabled = true
	
	if already_solved:
		# if the puzzle is already solved, play only the last frame of the animation
		$AnimatedSprite.set_frame($AnimatedSprite.get_sprite_frames().get_frame_count("solved")-1)
	else:
		# set the puzzle solved
		PuzzleManager.set_puzzle_solved(m_id, true)
