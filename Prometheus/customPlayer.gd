extends Node2D

onready var bodySprite = $CompositeSprites/body
onready var faceSprite = $CompositeSprites/face
onready var togaSprite = $CompositeSprites/toga
onready var eyeSprite = $CompositeSprites/eye
onready var hairSprite = $CompositeSprites/hair

const composite_Sprites = preload("res://Sprites/Composite/CompositeSprites.gd")

var bodyIdx = 0
var faceIdx = 0
var togaIdx = 0
var eyeIdx = 0
var hairIdx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	bodySprite.texture = composite_Sprites.body_spriteSheet[MasterData.skin_color_index]
	faceSprite.texture = composite_Sprites.face_spriteSheet[MasterData.facial_hair_index]
	togaSprite.texture = composite_Sprites.toga_spriteSheet[MasterData.toga_color_index]
	eyeSprite.texture = composite_Sprites.eye_spriteSheet[MasterData.eye_color_index]
	hairSprite.texture = composite_Sprites.hair_spriteSheet[MasterData.hair_style_index]
	
#get functions for any storage purposes
func getBody():
	return bodyIdx
func getFace():
	return faceIdx
func getToga():
	return togaIdx
func getEye():
	return eyeIdx
func getHair():
	return hairIdx

#functions to change the character
func setBody(idx):
	bodyIdx = idx
	bodySprite.texture = composite_Sprites.body_spriteSheet[bodyIdx]
	MasterData.skin_color_index = idx

func setFace(idx):
	faceIdx = idx
	faceSprite.texture = composite_Sprites.face_spriteSheet[faceIdx]
	MasterData.facial_hair_index = idx

func setToga(idx):
	togaIdx = idx
	togaSprite.texture = composite_Sprites.toga_spriteSheet[togaIdx]
	MasterData.toga_color_index = idx

func setEye(idx):
	eyeIdx = idx
	eyeSprite.texture = composite_Sprites.eye_spriteSheet[eyeIdx]
	MasterData.eye_color_index = idx

func setHair(idx):
	hairIdx = idx
	hairSprite.texture = composite_Sprites.hair_spriteSheet[hairIdx]
	MasterData.hair_style_index = idx


func _on_ButtonPink_pressed():
	setBody(0)
func _on_ButtonPurple_pressed():
	setBody(1)
func _on_ButtonBlue_pressed():
	setBody(2)
func _on_ButtonGreen_pressed():
	setBody(3)
func _on_ButtonBeige1_pressed():
	setBody(4)
func _on_ButtonBeige2_pressed():
	setBody(5)
func _on_ButtonBeige3_pressed():
	setBody(6)
func _on_ButtonBeige4_pressed():
	setBody(7)

func _on_Fh1_pressed():
	setFace(0)
func _on_Fh2_pressed():
	setFace(1)
func _on_Fh3_pressed():
	setFace(2)
func _on_Fh4_pressed():
	setFace(3)

func _on_Toga_pressed():
	setToga(0)
func _on_Toga2_pressed():
	setToga(1)
func _on_Toga3_pressed():
	setToga(2)
func _on_Toga4_pressed():
	setToga(3)
func _on_Toga5_pressed():
	setToga(4)
func _on_Toga6_pressed():
	setToga(5)
func _on_Toga7_pressed():
	setToga(6)

func _on_Eye_pressed():
	setEye(5)
func _on_Eye2_pressed():
	setEye(0)
func _on_Eye3_pressed():
	setEye(1)
func _on_Eye4_pressed():
	setEye(2)
func _on_Eye5_pressed():
	setEye(3)
func _on_Eye6_pressed():
	setEye(4)

func _on_Hair_pressed():
	setHair(3)
func _on_Hair2_pressed():
	setHair(2)
func _on_Hair3_pressed():
	setHair(0)
func _on_Hair4_pressed():
	setHair(1)
