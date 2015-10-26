module app;

import std.stdio;
import std.math;
import std.conv;
import std.file;
import std.string;

import derelict.sdl2.sdl;

import window;
import textures;
import tiles;
import colour;
import rect;
import ui;

enum isLogging = false;
enum wWidth = 960;
enum wHeight = 720;

class App {
	//Member variables
	private static App inst;
	private	Window window = new Window();	
	private TextureManager textureMan = new TextureManager();
	private TileManager tileMan = new TileManager();
	private Colour drawColour = Colour(236, 85, 142);
	private Button[] tiles;
	File file; //Logging output file, write a better logger

	//Getter functions
	public Window AppWindow(){
		return window;
	}

	public TextureManager TextureMan(){
		return textureMan;
	}

	public TileManager TileMan(){
		return tileMan;
	}

	//Member functions
	static public App Inst() {
		if(!inst) inst = new App();
		return inst;
	}

	public bool Init() {
		if(isLogging) file = File("log/log.txt", "w");
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

		SDL_Rect rect = SDL_Rect(0,0,0,0);

		BuildRect(rect);

		return success;
	}

	public void Update() {
			
		bool quit = false;
		SDL_Event event;

		tileMan.LoadTileset("maps/tileset.xml");

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

	public void Close() {
		if(isLogging) file.writeln(stderr, "Closing application");

		delete window;
		delete tileMan;
		delete textureMan;

		SDL_Quit();
	}
}