extends Node2D

class_name Puzzle

const FILE_PATH = "res://ArtAssets/SpriteFrames/"
const FILE_TYPE = ".tres"
const DEFAULT_ANIM = "default_"
const SOLVED_ANIM = "solved_"

var m_id : Vector2
var m_planet : String
onready var m_animator = $AnimatedSprite
onready var m_collider = $Collider

func _ready():
	# setup puzzle
	ready_puzzle()

func ready_puzzle():
	m_planet = PlanetManager.get_active_planet().get_planet_name()
	m_id = self.get_global_position()
	PuzzleManager.add_puzzle(m_id)
	if PuzzleManager.check_puzzle_solved(m_id):
		solve_puzzle()
	else:
		m_animator.play(DEFAULT_ANIM + m_planet)

func solve_puzzle():
	var already_solved = PuzzleManager.check_puzzle_solved(m_id)
	
	# play the solving animation
	m_animator.play(SOLVED_ANIM + m_planet)
	m_collider.disabled = true
	
	if already_solved:
		# if the puzzle is already solved, play only the last frame of the animation
		m_animator.set_frame(m_animator.get_sprite_frames().get_frame_count(SOLVED_ANIM + m_planet)-1)
	else:
		# set the puzzle solved
		PuzzleManager.set_puzzle_solved(m_id, true)
