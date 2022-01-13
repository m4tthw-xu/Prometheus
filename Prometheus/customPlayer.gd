extends Node2D

onready var bodySprite = $CompositeSprites/body
onready var faceSprite = $CompositeSprites/face
onready var togaSprite = $CompositeSprites/toga
onready var eyeSprite = $CompositeSprites/eye
onready var hairSprite = $CompositeSprites/hair

const compositeSprites = preload("res://Sprites/Composite/CompositeSprites.gd")



# Called when the node enters the scene tree for the first time.
func _ready():
	bodySprite.texture = compositeSprites.body_spriteSheet[0]
	faceSprite.texture = compositeSprites.face_spriteSheet[0]
	togaSprite.texture = compositeSprites.toga_spriteSheet[0]
	eyeSprite.texture = compositeSprites.eye_spriteSheet[0]
	hairSprite.texture = compositeSprites.hair_spriteSheet[0]
	
	pass # Replace with function body.
