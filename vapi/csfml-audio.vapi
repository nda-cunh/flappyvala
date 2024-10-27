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

[CCode (cheader_filename = "SFML/Audio.h")]
namespace sf {
	[CCode (cprefix = "sfListener_")]
	namespace Listener {
		public void setGlobalVolume(float volume);
		public float getGlobalVolume();
		public void setPosition(Vector3f position);
		public Vector3f getPosition();
		public void setDirection(Vector3f direction);
		public Vector3f getDirection();
		public void setUpVector(Vector3f upVector);
		public Vector3f getUpVector();
	}

	[Compact]
	[CCode (free_function = "sfMusic_destroy", cprefix="sfMusic_", cheader_filename = "SFML/Audio.h")]
	public class Music {
		[CCode (cname = "sfMusic_createFromFile")]
		public Music.fromFile(string filename);

		[CCode (cname = "sfMusic_createFromMemory")]
		public Music.fromMemory(void *data, size_t sizeInBytes);

		[CCode (cname = "sfMusic_createFromStream")]
		public Music.fromStream(InputStream stream);

		public void setLoop(bool loop);
		public bool getLoop();
		public Time getDuration();
		public TimeSpan getLoopPoints();
		public void setLoopPoints(TimeSpan timePoints);
		public void play();
		public void pause();
		public void stop();
		public uint getChannelCount();
		public uint getSampleRate();
		public SoundStatus getStatus();
		public Time getPlayingOffset();
		public void setPitch(float pitch);
		public void setVolume(float volume);
		public void setPosition(Vector3f position);
		public void setRelativeToListener(bool relative);
		public void setMinDistance(float distance);
		public void setAttenuation(float attenuation);
		public void setPlayingOffset(Time timeOffset);
		public float getPitch();
		public float getVolume();
		public Vector3f getPosition();
		public bool isRelativeToListener();
		public float getMinDistance();
		public float getAttenuation();
	}

	[Compact]
	[CCode (free_function = "sfSound_destroy", cprefix="sfSound_", cheader_filename = "SFML/Audio.h")]
	public class Sound
	{
		[CCode (cname = "sfSound_create")]
		public Sound();

		public Sound copy();
		public void play();
		public void pause();
		public void stop();
		public void setBuffer(SoundBuffer buffer);
		public unowned SoundBuffer getBuffer();
		public void setLoop(bool loop);
		public bool getLoop();
		public SoundStatus getStatus();
		public void setPitch(float pitch);
		public void setVolume(float volume);
		public void setPosition(Vector3f position);
		public void setRelativeToListener(bool relative);
		public void setMinDistance(float distance);
		public void setAttenuation(float attenuation);
		public void setPlayingOffset(Time timeOffset);
		public float getPitch();
		public float getVolume();
		public Vector3f getPosition();
		public bool isRelativeToListener();
		public float getMinDistance();
		public float getAttenuation();
		public Time getPlayingOffset();
	}

	[Compact]
	[CCode (free_function = "sfSoundBuffer_destroy", cprefix="sfSoundBuffer_", cheader_filename = "SFML/Audio.h")]
	public class SoundBuffer {
		[CCode (cname = "createFromFile")]
		public SoundBuffer.fromFile(string filename);

		[CCode (cname = "createFromMemory")]
		public SoundBuffer.fromMemory(void* data, size_t sizeInBytes);

		[CCode (cname = "createFromStream")]
		public SoundBuffer.fromStream(InputStream stream);

		[CCode (cname = "createFromSamples")]
		public SoundBuffer.fromSamples(int16 []samples, uint64 sampleCount, uint channelCount, uint sampleRate);


		public SoundBuffer copy();
		public bool saveToFile(string filename);
		public int16 []getSamples();
		public uint64 getSampleCount();
		public uint getSampleRate();
		public uint getChannelCount();
		public Time getDuration();
	}

	[Compact]
	[CCode (free_function = "sfSoundBufferRecorder_destroy", cprefix="sfSoundBufferRecorder_", cheader_filename = "SFML/Audio.h")]
	public class SoundBufferRecorder {
		[CCode (cname = "sfSoundBufferRecorder_create")]
		public SoundBufferRecorder();

		bool start(uint sampleRate);
		void stop();
		uint getSampleRate();
		unowned SoundBuffer getBuffer();
		bool setDevice(string name);
		string getDevice();
	}

	[Compact]
	[CCode (free_function = "sfSoundRecorder_destroy", cprefix="sfSoundRecorder_", cheader_filename = "SFML/Audio.h")]
	public class SoundRecorder {

		[CCode (cname = "sfSoundRecorder_create")]
		SoundRecorder(StartCallback? onStart = null, ProcessCallback onProcess, StopCallback? onStop = null, void* userData);

		public static string []getAvailableDevices(size_t []count);
		public static string getDefaultDevice();
		public static bool isAvailable();

		public bool start(uint sampleRate);
		public void stop();
		public uint getSampleRate(SoundRecorder soundRecorder);
		public void setProcessingInterval(Time interval);
		public bool setDevice(string name);
		public string getDevice();
		public void setChannelCount(uint channelCount);
		public uint getChannelCount(SoundRecorder soundRecorder);

		[CCode (cname = "sfSoundRecorderStartCallback")]
		public delegate bool StartCallback(void* todo1);
		[CCode (cname = "SoundRecorderProcessCallback")]
		public delegate bool ProcessCallback(int16[] todo1, size_t todo2, void* todo3);
		[CCode (cname = "SoundRecorderStopCallback")]
		public delegate void StopCallback(void* todo1);
	}

	[CCode (cname = "sfSoundStatus", cprefix = "sf")]
	public enum SoundStatus
	{
		/** music is not playing*/
		Stopped,
		/** music is paused*/
		Paused,
		/** music is playing*/
		Playing
	}

	[CCode (cname = "sfTimeSpan")]
	public struct TimeSpan
	{
		Time offset;
		Time length;
	}
}
