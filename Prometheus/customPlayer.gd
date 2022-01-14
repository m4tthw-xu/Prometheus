extends Node2D

onready var bodySprite = $CompositeSprites/body
onready var faceSprite = $CompositeSprites/face
onready var togaSprite = $CompositeSprites/toga
onready var eyeSprite = $CompositeSprites/eye
onready var hairSprite = $CompositeSprites/hair

const composite_Sprites = preload("res://Sprites/Composite/CompositeSprites.gd")



# Called when the node enters the scene tree for the first time.
func _ready():
	bodySprite.texture = composite_Sprites.body_spriteSheet[0]
	faceSprite.texture = composite_Sprites.face_spriteSheet[0]
	togaSprite.texture = composite_Sprites.toga_spriteSheet[0]
	eyeSprite.texture = composite_Sprites.eye_spriteSheet[0]
	hairSprite.texture = composite_Sprites.hair_spriteSheet[0]
	
