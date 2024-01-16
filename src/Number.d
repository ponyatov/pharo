module number;

import std.conv;

import protocol;

class Magnitude : Object {
}

class Number : Magnitude {
}

class Float : Number, protocol.converting {
    float value;
    this(float V) {
        value = V;
    }

    Float asFloat() {
        return this;
    }
}

/// common abstract superclass for all Integer implementations
class Integer : Number, protocol.converting {
    int value;
    this(int V) {
        value = V;
    }

    Float asFloat() {
        return new Float(value);
    }
}

class Hex : Integer {
    this(int V) {
        super(V);
    }
}

class Bin : Integer {
    this(int V) {
        super(V);
    }
}
