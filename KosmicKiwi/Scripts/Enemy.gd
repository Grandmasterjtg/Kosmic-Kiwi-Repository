extends Character

func _ready():
	print("Enemy _ready() called for " + self.name)
	
	#set starting state to FOLLOW
	.set_state(self.CharacterState.STEAL)
