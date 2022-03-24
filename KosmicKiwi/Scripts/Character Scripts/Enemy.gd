extends Character

func _ready():
	#set starting state to FOLLOW
	.set_state(self.CharacterState.STEAL)
