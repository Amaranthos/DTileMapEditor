module tiles.tile;

import std.stdio;

import derelict.sdl2.sdl;

import textures;
import math.vec2;
import app;

class Tile {

	private Texture texture;
	private SDL_Rect tile;
	private Vec2 position;

	public this(SDL_Rect tile, Texture texture) {
		this.tile = tile;
		this.texture = texture;
	}

	public ~this() {

	}

	public void SetPosition(Vec2 position) {
		this.position = position;
	}

	public void Draw() {
		if(true) //Check on screen, when camera is implemented
			texture.Render(cast(int)position.x, cast(int)position.y, App.Inst.GetWindow, &tile);
	}
}