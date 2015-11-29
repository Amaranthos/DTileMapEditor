module ui.button;

import std.stdio;
import std.string;

import derelict.sdl2.sdl;

import app;
import window;
import colour;
import textures.texture;
import textures.manager;
import tiles.tile;
import math.vec2;

class Button {
private:
	SDL_Rect pos;
	Texture image = null;
	Tile tile_ = null;
	bool isSelected = false;

public:
	Colour fillColour;
	Colour outlineColour;
	Colour selectColour;


	// Getters and Setters
	void selected(bool selected) @property{
		isSelected = selected;
	}

	const(SDL_Rect) position() const @property{
		return pos;
	}

	const(Tile) tile() const @property{
		return tile_;
	}

	void position(SDL_Rect position) @property{
		pos = position;
	}

	void SetImage(string image){
		this.image = App.Inst.TextureMan().Get(image);
	}

	void SetTile(string tile) {
		this.tile_ = App.Inst.TileMan.Get(tile);
	}

	// Member functions
	this(SDL_Rect pos = SDL_Rect(0,0,0,0), Colour fill = Colour(0,0,0), Colour outline = Colour(255, 255, 255), Colour select = Colour.Yellow) {
		this.pos = pos;
		fillColour = fill;
		outlineColour = outline;
		selectColour = select;
	}

	~this() {

	}

	void HandleEvent(ref SDL_Event e) {

	}

	bool LoadButtonImage(string path, Window window) {
		image = new Texture();
		return image.LoadFromFile(path, window);
	}

	void Render(Window window, float scale = 1) {
		SDL_SetRenderDrawColor(window.Renderer, fillColour.r, fillColour.g, fillColour.b, fillColour.a);
		
		// Scale button fill
		SDL_RenderSetScale(window.Renderer, scale, scale);
		SDL_RenderFillRect(window.Renderer, &pos);
		SDL_RenderSetScale(window.Renderer, 1, 1);
		
		if(image)
			image.Render(pos.x, pos.y, window, null);
		else if(tile_){
			tile_.position(new Vec2(pos.x, pos.y));
			tile_.Draw(window, scale);
		}

		if(isSelected)
			SDL_SetRenderDrawColor(window.Renderer, selectColour.r, selectColour.g, selectColour.b, selectColour.a);
		else
			SDL_SetRenderDrawColor(window.Renderer, outlineColour.r, outlineColour.g, outlineColour.b, outlineColour.a);

		// Scale button outline
		SDL_RenderSetScale(window.Renderer, scale, scale);
		SDL_RenderDrawRect(window.Renderer, &pos);
		SDL_RenderSetScale(window.Renderer, 1, 1);
	}
}