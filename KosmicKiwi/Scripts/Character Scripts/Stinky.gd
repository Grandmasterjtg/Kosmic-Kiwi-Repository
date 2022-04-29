extends Friend

const STINKY_THINKING_TEXTURE = preload("res://ArtAssets/Characters/emotes/friendthinking.png")
const STINKY_SAD_TEXTURE = preload("res://ArtAssets/Characters/emotes/friendsad.png")

onready var m_ability_timer = $AbilityTimer

var m_stinking = false;

func _ready() -> void:
	self.friend_id = 2
	m_ability_timer.connect("timeout",self,"end_stinking")

func _physics_process(delta):
	if m_stinking and !m_detected_bodies.empty():
		for body in m_detected_bodies:
			if body.is_in_group("enemy") and body.get_state() != body.CharacterState.HOME:
				body.stink_detected()

func use_ability():
	if FriendManager.get_current_friend_id() == self.friend_id and !FriendManager.friend_ability_on_cooldown():
		FriendManager.start_friend_ability()
		print("Stinky ability used!")
		start_stinking()

func meet_player():
	.meet_player()
	set_state(CharacterState.FOLLOW)

func start_stinking():
	m_ability_timer.start()
	m_stinking = true
	$EmoteBubble.open_bubble_with_texture(STINKY_THINKING_TEXTURE)

func end_stinking():
	m_stinking = false
	$EmoteBubble.open_bubble_with_texture(STINKY_SAD_TEXTURE)
	
