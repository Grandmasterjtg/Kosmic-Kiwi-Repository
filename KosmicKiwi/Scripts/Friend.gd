extends Character


var ability = FriendAbility.new()

func _ready():
	print("Friend _ready() called for " + self.name)
	
	#set starting state to FOLLOW
	.set_state(self.CharacterState.FOLLOW)

func _on_Button_pressed():
	ability.use_ability()
	
