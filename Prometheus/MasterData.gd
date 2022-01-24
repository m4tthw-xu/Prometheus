extends Node

# this script can be accessed across all the scenes
# currently being used like RAM in a computer: short term memory storage for the player's stats

# has to be accessed by mutliple scenes globally
const enemy_names = ["Slime", "Dionysus", "Golem", "Zeus", "Gaea"]

var player_name = ""
var start_time = 0
var enemies_slain_stage_one = 0
var enemies_slain_stage_two = 0
var enemies_slain_stage_three = 0
var end_time = 0
var final_score = 0

var health = 100

var player_location = "StageOne"

# for multiplayer
var health_p2 = 100
var kills_p1 = 0
var kills_p2 = 0

var player_x_pos = 0
var zeus_x_pos = 0
var zeus_facing = "left"

var golem_count = 0

var spear_charges = 4

var skin_color_index = 0
var facial_hair_index = 0
var toga_color_index = 0
var eye_color_index = 0
var hair_style_index = 0

func _ready():
	pass
