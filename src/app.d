module app;

import std.stdio;
import std.algorithm;
import std.math;
import std.conv;
import std.file;
import std.string;

import derelict.sdl2.sdl;

import window;
import texture;
import colour;
import button;

static bool isLogging = false;
static int wWidth = 960;
static int wHeight = 720;

class App {
	//Member variables
	static App inst;

	Window window = new Window();
	
	Colour drawColour = Colour(236, 85, 142);

	File file;

	//Member functions
	static public App Inst() {
		if(!inst) inst = new App();
		return inst;
	}

	public bool Init() {
		if(isLogging) file = File("log.txt", "w");
		if(isLogging) file.writeln(stderr, "Initialising");

		bool success = true;

		if(SDL_Init(SDL_INIT_EVERYTHING) <0) {
			writeln("Warning: SDL could not initialise! SDL Error: ", SDL_GetError());
			success = false;
		}
		else {
			if(!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1")) writeln("Warning: Linear texture filtering not enabled!");

			if(!window.Init(wWidth, wHeight, "Tile Map Editor", Colour(0,0,0))) success = false;
		}

		if(isLogging) file.writeln(stderr, "Initialisation successful: ", success);

		return success;
	}

	public void Update() {
			
		bool quit = false;
		SDL_Event event;

		while(!quit) {
			stdout.flush();
			if(isLogging) file.writeln(stderr, "Polling events");
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

				if(isLogging) file.writeln(stderr, "Window handling events");
				window.HandleEvent(event);
			}

			if(isLogging) file.writeln(stderr, "Clear Window");
			window.Clear();
			
			if(isLogging) file.writeln(stderr, "Rendering window");	
			window.Render();
		}
	}

	private SDL_Rect BuildRect (ref SDL_Rect rect) {
		int x1 = rect.x;
		int y1 = rect.y;
		int x2 = rect.w;
		int y2 = rect.h;

		rect.x = min(x1, x2);
		rect.y = min(y1, y2);

		rect.w = max(x1, x2) - rect.x;
		rect.h = max(y1, y2) - rect.y;

		return rect;
	}

	public void Close() {
		if(isLogging) file.writeln(stderr, "Closing application");

		delete window;

		SDL_Quit();
	}
}