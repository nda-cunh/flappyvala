/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2024 SFML VAPI Authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Authors:
 *  Hydral (Nathan) <nathan.dacunha.nd@gmail.com>
 */

namespace sf {
/* ****************************  VECTOR2-3 rect  *************************************/

	[CCode (cname = "sfVector2i", cheader_filename = "SFML/System.h")]
	[SimpleType]
	public struct Vector2i
	{
		int x;
		int y;
		public string to_string() {
			return @"x: $x y: $y";
		}
		public Vector2u to_vector2u() {
			return { (uint)x, (uint)y };
		}
		public Vector2f to_vector2f() {
			return { (float)x, (float)y };
		}
	}
	[CCode (cname = "sfVector2u", cheader_filename = "SFML/System.h")]
	[SimpleType]
	public struct Vector2u
	{
		uint x;
		uint y;
		public string to_string() {
			return @"x: $x y: $y";
		}
		public Vector2i to_vector2i() {
			return { (int)x, (int)y };
		}
		public Vector2f to_vector2f() {
			return { (float)x, (float)y };
		}
	}
	[CCode (cname = "sfVector2f", cheader_filename = "SFML/System.h")]
	[SimpleType]
	public struct Vector2f
	{
		float x;
		float y;
		public string to_string() {
			return @"x: $x y: $y";
		}
		public Vector2u to_vector2u() {
			return { (uint)x, (uint)y };
		}
		public Vector2i to_vector2i() {
			return { (int)x, (int)y };
		}
	}
	[CCode (cname = "sfVector3f", cheader_filename = "SFML/System.h")]
	[SimpleType]
	public struct Vector3f
	{
		public string to_string() {
			return @"x: $x y: $y z: $z";
		}
		float x;
		float y;
		float z;
	}

	[CCode (cname = "sfBuffer", free_function="sfBuffer_destroy")]
	[Compact]
	public class Buffer {
		[CCode (cname = "sfBuffer_create")]
		public Buffer ();

		[CCode (cname = "sfBuffer_getSize")]
		public size_t getSize();

		[CCode (cname = "sfBuffer_getData")]
		public uint8* getData();
	}
	

	[Compact]
	[CCode (cname = "sfClock", free_function="sfClock_destroy", cheader_filename = "SFML/System/Clock.h")]
	public class Clock {
		[CCode (cname = "sfClock_create")]
		public Clock ();

		[CCode (cname = "sfClock_copy")]
		public Clock copy ();

		[CCode (cname = "sfClock_getElapsedTime")]
		public Time getElapsedTime();

		[CCode (cname = "sfClock_restart")]
		public Time restart();
	}

	/** Represents a time value */
	[CCode (cname = "sfTime", cprefix = "sfTime_")]
	[SimpleType]
	public struct Time
	{
		[CCode (cname = "microseconds")]
		public int64 microseconds;

		public float asSeconds();
		public int32 asMilliseconds();
		public int64 asMicroseconds();

		/** Construct a time value from a number of seconds.*/
		[CCode (cname = "sfSeconds")]
		public static Time Seconds(float amount);

		/** Construct a time value from a number of milliseconds.*/
		[CCode (cname = "sfMilliseconds")]
		public static Time Milliseconds(int32 amount);

		/** Construct a time value from a number of microseconds.*/
		[CCode (cname = "sfMicroseconds")]
		public static Time Microseconds(int64 amount);

		/** Sets the time value to zero.*/
		[CCode (cname = "sfTime_Zero")]
		public const Time Zero;
		[CCode (cname = "sfSleep", cheader_filename = "SFML/System/Time.h")]
		public void sleep();
	}
	
	[CCode (cname = "sfSleep", cheader_filename = "SFML/System/Time.h")]
	public void sleep(Time duration);
	
	public delegate int64 InputStreamReadFunc(void* data, int64 size, void* userData);
	public delegate int64 InputStreamSeekFunc(int64 position, void* userData);
	public delegate int64 InputStreamTellFunc(void* userData);
	public delegate int64 InputStreamGetSizeFunc(void* userData);

	[CCode (cname = "sfInputStream")]
	public struct InputStream
	{
		/** Function to read data from the stream*/
		InputStreamReadFunc		read;
		/** Function to set the current read position*/
		InputStreamSeekFunc		seek;
		/** Function to get the current read position*/
		InputStreamTellFunc		tell;
		/** Function to get the total number of bytes in the stream*/
		InputStreamGetSizeFunc	getSize;
		/** User data that will be passed to the callbacks*/
		void*					userData;
	}
}

/** Vector2f constructor */
public inline sf.Vector2f Vector2f(float x, float y){
	return {x, y};
}

/** Vector2i constructor */
public inline sf.Vector2i Vector2i(int x, int y){
	return {x, y};
}

/** Vector2u constructor */
public inline sf.Vector2u Vector2u(uint x, uint y){
	return {x, y};
}

/** Vector3f constructor */
public inline sf.Vector3f Vector3f(float x, float y, float z){
	return {x, y, z};
}
