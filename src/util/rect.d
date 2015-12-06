module util.rect;

import std.algorithm;

import derelict.sdl2.sdl;

public SDL_Rect BuildRect (ref SDL_Rect rect) {
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

public bool MouseOver (SDL_Rect rect, float scale = 1){
	int x, y = 0;

	SDL_GetMouseState(&x, &y);

	bool isIn = true;

	if(x < rect.x * cast(int)scale) isIn = false;
	else if(x > (rect.x + rect.w) * cast(int)scale) isIn = false;
	else if (y < rect.y * cast(int)scale) isIn = false;
	else if (y > (rect.y + rect.h) * cast(int)scale) isIn = false;
	
	return isIn;
}