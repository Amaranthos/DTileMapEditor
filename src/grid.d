module grid;

import std.stdio;

public class Grid(T) {
private:
	T[] grid_;
	uint col;
	uint row;
	uint bucketSize;

public:
		
	T[] grid() @property {
		return grid_;
	}

	const(int) cols() const @property {
		return col;
	}

	const(int) rows() const @property {
		return row;
	}

	this(uint col, uint row, uint bucketSize) {
		this.col = col;
		this.row = row;
		this.bucketSize = bucketSize;

		//grid_ = new T[col][row];

		for(uint i = 0; i < col * row; i++){
			grid_ ~= null;
		}
	}

	void Set(T element, uint x, uint y){
		if(x < col && y < row){
			grid_[x + y * col] = element;
		}
		else {
			writeln("Error: grid index out of range!");
		}
	}

	void Clear() {
		foreach(i; 0..col){
			foreach(j; 0..row){
				delete grid_[i + j * col];
				grid_[i + j * col] = null;
			}
		}
	}
}