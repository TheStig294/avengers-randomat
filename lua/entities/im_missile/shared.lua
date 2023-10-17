ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Repulsor Missile"
ENT.Author = "darky"
ENT.Information = "Repulsor Missile"
ENT.Spawnable = false
ENT.AdminSpawnable = false

sound.Add({
	name = "rocket_explode",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 100,
	pitch = {75, 110},
	sound = "avengers_ironman/rocket_explode.wav"
})

sound.Add({
	name = "rocket_loop",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 100,
	pitch = {75, 110},
	sound = "avengers_ironman/jetpack_loop.wav"
})