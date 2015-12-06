module app;

import std.stdio;
import std.math;
import std.conv;
import std.file;
import std.string;

import derelict.sdl2.sdl;

import util;
import textures;
import tiles;
import ui;
import math;

enum wWidth = 960;
enum wHeight = 720;

enum tileSize = 32;

class App {

private:
	// Member variables
	static App inst;
	Window window = new Window();	
	TextureManager textureMan = new TextureManager();
	File file; //Logging output file, write a better logger
	bool mouseLHeld = false;

	// UI elements
	enum tileUIPadding = 5;
	enum tileUISepX = 2 * tileUIPadding + tileSize;
	enum tileUISepY1 = 0;
	enum tileUISepY2 = wHeight;

	SDL_Rect canvas = SDL_Rect(2 * tileUISepX + 2, tileUISepY1, wWidth - tileUISepX, wHeight);
	Button[] tileButtons;
	string selectedTile = "";

	bool mouseOverCanvas = false;


public:
	// Getter and Setters
	Window AppWindow(){
		return window;
	}

	TextureManager TextureMan(){
		return textureMan;
	}

	// Member functions
	static App Inst() {
		if(!inst) inst = new App();
		return inst;
	}

	bool Init() {
		Log(Level.event,"Initialising");

		bool success = true;

		if(SDL_Init(SDL_INIT_EVERYTHING) <0) {
			Log(Level.error, "SDL could not initialise! SDL Error: ", SDL_GetError());
			success = false;
		}
		else {
			if(!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "0")) Log(Level.warning, "Point texture filtering not enabled!");

			if(!window.Init(wWidth, wHeight, "Tile Map Editor", Colour(0,0,0))) success = false;
		}

		Log(Level.user, "Hello World!");

		//tileMan.LoadTileset("maps/tileset.xml");
		return success;
	}

	void Update() {
		bool quit = false;
		SDL_Event event;

		while(!quit) {
			stdout.flush();
			Log(Level.update, "Polling events");
			while(SDL_PollEvent(&event) != 0) {
				if(event.type == SDL_QUIT) quit = true;
				else if (event.type == SDL_KEYDOWN) {
					switch(event.key.keysym.sym){
						case SDLK_ESCAPE: 
							quit = true; 
							break;

						default: 
							break;
					}
				}
				else if(event.type == SDL_MOUSEBUTTONDOWN && event.button.button == SDL_BUTTON_LEFT){
					mouseLHeld = true;
					foreach(i; 0..tileButtons.length){
						if(MouseOver(tileButtons[i].position, 2)){
							foreach(j; 0..tileButtons.length){
								tileButtons[j].selected = false;
							}
							tileButtons[i].selected = true;
						}
					}

					PaintTile();
				}
				else if(event.type == SDL_MOUSEBUTTONUP && event.button.button == SDL_BUTTON_LEFT){
					mouseLHeld = false;
				}
				else if(event.type == SDL_MOUSEMOTION){
					if(mouseLHeld){
						PaintTile();
					}
				}

				mouseOverCanvas = MouseOver(canvas);

				Log(Level.update, "Window handling events");
				window.HandleEvent(event);
			}

			Log(Level.update, "Clear Window");
			window.Clear();
			
			Draw();

			Log(Level.update, "Rendering window");	
			window.Render();
		}
	}

	void Close() {
		Log(Level.event, "Closing application");

		delete window;
		delete textureMan;

		SDL_Quit();
	}

private:
	void Draw() {
		foreach(i; 0..tileButtons.length){
			tileButtons[i].Render(window, 2);
		}

		SDL_SetRenderDrawColor(window.Renderer, Colour.Red.r, Colour.Red.g, Colour.Red.b, Colour.Red.a);
		SDL_RenderDrawLine(window.Renderer, 2 * tileUISepX, tileUISepY1, 2 * tileUISepX, tileUISepY2);

		if(mouseOverCanvas && selectedTile != ""){
			int x, y = 0;
			SDL_GetMouseState(&x, &y);

			x -= canvas.x;
			y -= canvas.y;

			x /= 32;
			y /= 32;

			//Tile* tile = tileMan.Get(selectedTile);

			//tile.position = new Vec2(x * tileSize + canvas.x, y * tileSize + canvas.y);
			//tile.Draw(window);

		}

		//for(int i = 0; i < grid.cols; i++){
		//	for(int j = 0; j < grid.rows; j++){
		//		if(grid.grid[i + j * grid.cols]){
		//			grid.grid[i + j * grid.cols].position = new Vec2(i * tileSize + canvas.x, j * tileSize + canvas.y);
		//			grid.grid[i + j * grid.cols].Draw(window);
		//		}
		//	}
		//}

		//textureMan.Get("img/tileset.png").Render(50, 100, window, null);
	}

	void PaintTile(){
		if(mouseOverCanvas && selectedTile != ""){
			int x, y = 0;
			SDL_GetMouseState(&x, &y);

			x -= canvas.x;
			y -= canvas.y;

			x /= 32;
			y /= 32;

			//Tile tile = tileMan.Get(selectedTile);
			//grid.Set(tileMan.Get(selectedTile), cast(uint)x, cast(uint)y);
		}
	}
}