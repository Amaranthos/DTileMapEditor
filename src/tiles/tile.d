module tiles.tile;

import std.stdio;

import derelict.sdl2.sdl;

import textures;
import math.vec2;
import app;

class Tile {
private:
	Texture texture_;
	SDL_Rect tile_;
	Vec2 position_;

public:
	this(SDL_Rect tile, Texture texture) {
		tile_ = tile;
		texture_ = texture;
	}

	~this() {

	}

	const(Texture) texture() const @property{
		return texture_;
	}

	const(Vec2) position() const @property{
		return position_;
	}

	void position(Vec2 position) @property{
		position_ = position;
	}

	void Draw() {
		if(true) //Check on screen, when camera is implemented
			texture_.Render(cast(int)position_.x, cast(int)position_.y, App.Inst.AppWindow, &tile_);
	}
}