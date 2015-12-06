module layer;

import derelict.sdl2.sdl;

import textures.texture;
import util.grid;
import util.log;
import app;

class Layer {
private:
	Grid!int layer;

	uint width;
	uint height;
	uint tileSize;

public:
	this(uint layerWidth, uint layerHeight, uint layerTileSize) {
		width = layerWidth;
		height = layerHeight;
		tileSize = layerTileSize;

		// Create grid
		layer = new Grid!int(width, height, tileSize);
		Initialise();
	}

	~this() {
		delete layer;
	}

	void SetTile(uint x, uint y, int tile) {
		layer.Set(tile, x, y);
	}

	void Initialise() {
		// Set grid's values to -1 to represent unset tiles
		for(int i = 0; i < layer.cols; i++) {
			for(int j = 0; j < layer.rows; j++) {
				layer.Set(-1, i, j);
			}
		}
	}

	void Draw(Texture tileset, SDL_Rect[] tiles, uint xOffset, uint yOffset) {
		for(int i = 0; i < layer.cols; i++) {
			for(int j = 0; j < layer.rows; j++) {
				int index = layer.grid[i + j * layer.cols];
				if(index >= 0 && index < tiles.length) {
					tileset.Render(i * tileSize, j * tileSize, App.Inst.AppWindow, &tiles[1]);
				}
			}
		}
	}
}