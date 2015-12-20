module map;

import std.xml;
import std.file;
import std.conv;
import std.string;

import derelict.sdl2.sdl;

import textures.texture;
import ui.button;
import layer;
import util.log;
import app;

class Map {
private:
	uint posX;
	uint posY;
	uint width;
	uint height;
	uint tileSize;

	Layer foreground;
	Layer background;
	Layer* currentLayer;

	int selectedTile = 0;

	SDL_Rect[] tiles;
	Texture tileset;

public:
	void SelectedTile(int tile) @property {
		if(tile >= 0 && tile < tiles.length){
			selectedTile = tile;
			Log(Level.user, "Selected tile: ", tile);
		}
		else {
			Log(Level.user, "Selected out of range: ", tile);
		}
	}

	const(int) SelectedTile() const @property {
		return selectedTile;
	}

	Texture Tileset() @property {
		return tileset;
	}

	SDL_Rect[] Tiles() @property {
		return tiles;
	}

	SDL_Rect MapRect() const @property {
		return SDL_Rect(posX, posY, width * tileSize, height * tileSize);
	}

	this(uint positionX, uint positionY, uint mapWidth, uint mapHeight, uint mapTileSize) {
		posX = positionX;
		posY = positionY;
		width = mapWidth;
		height = mapHeight;
		tileSize = mapTileSize;

		foreground = new Layer(width, height, tileSize);
		background = new Layer(width, height, tileSize);

		currentLayer = &background;
	}

	~this() {
		currentLayer = null;
		delete foreground;
		delete background;
	}

	void Draw() {
		background.Draw(tileset, tiles, posX, posY);
		foreground.Draw(tileset, tiles, posX, posY);
	}

	void PaintTile(uint x, uint y) {
		currentLayer.SetTile(selectedTile, x, y);
	}

	void LoadTileset(string path) {
		if(path != ""){
			auto content = cast(string) read(path);

			if(content != ""){

				check(content);

				auto xml = new DocumentParser(content);
				
				xml.onStartTag["image"] = (ElementParser xml) {
					tileset = App.Inst.TextureMan.Get(xml.tag.attr["path"]);
					
					SDL_Rect tile = SDL_Rect();
					string name;
					tile.w = to!int(xml.tag.attr["tilesize"]);
					tile.h = to!int(xml.tag.attr["tilesize"]);

					xml.onStartTag["tile"] = (ElementParser e){
						tile.x = to!int(e.tag.attr["x"]) * tile.w;
						tile.y = to!int(e.tag.attr["y"]) * tile.h;

						tiles ~= tile;
					};
					xml.parse();
				};
				xml.parse();

			}
			else Log(Level.warning, "Could not read file: ", path);
		}
		else Log(Level.warning, "Invalid path");
	}

	void LoadMap(string path) {

	}

	void SaveMap(string path) {

	}

	Button[] CreateButtons(int startX, int startY, int padX, int padY, bool incrX, bool incrY) {
		Button[] ret;
		
		int x = 0;
		int y = 0;

		foreach(tile; tiles){
			auto b =  new Button();
			b.position = SDL_Rect(startX + x * (tileSize + padX), startY + y * (tileSize + padY), tileSize, tileSize);
			b.SetImage(tileset, tile);
			ret ~= b;

			if(incrX){
				x++;
			}
			if(incrY){
				y++;
			}
		}

		return ret;
	}
}