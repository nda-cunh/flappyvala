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

[CCode (cheader_filename="SFML/Network.h")]
namespace sf {

	[CCode (cname="HttpMethod", cprefix="sfHttp")]
	public enum HttpMethod
	{
		Get,   
		Post,  
		Head,  
		Put,   
		Delete 
	}

	[CCode (cname="sfHttpStatus", cprefix="sfHttp")]
	public enum HttpStatus
	{
		// 2xx: success
		Ok, 
		Created, 
		Accepted, 
		NoContent, 
		ResetContent, 
		PartialContent, 

		// 3xx: redirection
		MultipleChoices, 
		MovedPermanently, 
		MovedTemporarily, 
		NotModified, 

		// 4xx: client error
		BadRequest, 
		Unauthorized, 
		Forbidden, 
		NotFound, 
		RangeNotSatisfiable, 

		// 5xx: server error
		InternalServerError, 
		NotImplemented, 
		BadGateway, 
		ServiceNotAvailable, 
		GatewayTimeout, 
		VersionNotSupported, 

		// 10xx: SFML custom codes
		InvalidResponse, 
		ConnectionFailed
	}

	[CCode (cname="sfHttpRequest", free_function="sfHttpRequest_destroy", cprefix="sfHttpRequest_")]
	[Compact]
	public class HttpRequest
	{
		[CCode(cname="sfHttpRequest_create")]
		public HttpRequest();

		public void setField(string field, string value);

		public void setMethod(HttpMethod method);

		public void setUri(out HttpRequest httpRequest, string uri);

		public void setHttpVersion(HttpRequest httpRequest, uint major, uint minor);

		public void setBody(out HttpRequest httpRequest, string body);

	}

	[CCode (cname="sfHttpResponse", free_function="sfHttpResponse_destroy", cprefix="sfHttpResponse_")]
	[Compact]
	public class HttpResponse {
		public string sfHttpResponse_getField(string field);
		public HttpStatus sfHttpResponse_getStatus();
		public uint sfHttpResponse_getMajorVersion();
		public uint sfHttpResponse_getMinorVersion();
		public string sfHttpResponse_getBody();
	}
		
	[CCode (cname="sfHttp", free_function="sfHttp_destroy", cprefix="sfHttp_")]
	[Compact]
	public class Http{
		[CCode (cname="sfHttp_create")]
		public Http();
		public void setHost(string host, ushort port);
		public HttpResponse sendRequest(HttpRequest request, Time timeout);
	}

	[CCode(cname="sfSocketStatus", cprefix="sfSocket")]
	public enum SocketStatus
	{
		Done,         ///< The socket has sent / received the data
		NotReady,     ///< The socket is not ready to send / receive data yet
		Partial,      ///< The socket sent a part of the data
		Disconnected, ///< The TCP socket has been disconnected
		Error         ///< An unexpected error happened
	}

	[CCode(cname="sfIpAddress")]
	[SimpleType]
	public struct IpAddress
	{
		/* Const */
		[CCode(cname="sfIpAddress_None")]
		public const IpAddress None;
		[CCode(cname="sfIpAddress_Any")]
		public const IpAddress Any;
		[CCode(cname="sfIpAddress_LocalHost")]
		public const IpAddress LocalHost;
		[CCode(cname="sfIpAddress_Broadcast")]
		public const IpAddress Broadcast;

		/* Function */
		[CCode (cname="sfIpAddress_fromString")]
		public IpAddress.fromString(string address);
		[CCode (cname="sfIpAddress_getPublicAddress")]
		public IpAddress.getPublicAddress(Time timeout);
		[CCode (cname="sfIpAddress_fromBytes")]
		public IpAddress.fromBytes(uint8 byte0, uint8 byte1, uint8 byte2, uint8 byte3);
		[CCode (cname="sfIpAddress_fromInteger")]
		public IpAddress.fromInteger(uint32 address);
		[CCode (cname="sfIpAddress_getLocalAddress")]
		public IpAddress.getLocalAddress();

		[CCode (cname="sfIpAddress_toString")]
		public void toString(out string str);
		[CCode (cname="sfIpAddress_toInteger")]
		public uint32 toInteger();
		
		/* property */
		uint8 address[16];
	}


	[CCode(cname="sfPacket", free_function="sfPacket_destroy", cprefix="sfPacket_")]
	[Compact]
	public class Packet {
		[CCode(cname="sfPacket_create")]
		public Packet();

		public Packet copy();

		public void append(void* data, size_t sizeInBytes);
		public size_t getReadPosition();
		public void clear();
		public void* getData();
		public size_t getDataSize();
		public bool endOfPacket();
		public bool canRead();

		public bool readBool();
		public int8 readInt8();
		public uint8 readUint8();
		public int16 readInt16();
		public uint16 readUint16();
		public int32 readInt32();
		public uint32 readUint32();
		public float readFloat();
		public double readDouble();
		public void readString(string str);

		public void writeBool(bool value);
		public void writeInt8(int8 value);
		public void writeUint8(uint8 value);
		public void writeInt16(int16 value);
		public void writeUint16(uint16 value);
		public void writeInt32(int32 value);
		public void writeUint32(uint32 value);
		public void writeFloat(float value);
		public void writeDouble(double value);
		public void writeString(string str);
	}

	[CCode (cname="sfUdpSocket", free_function="sfUdpSocket_destroy", cprefix="sfUdpSocket_")]
	[Compact]
	public class UdpSocket{

		[CCode(cname="sfUdpSocket_create")]
		public UdpSocket();

		public void setBlocking(bool blocking);
		public bool isBlocking();
		public ushort getLocalPort();
		public SocketStatus bind(ushort port, IpAddress address);
		public void unbind();
		public SocketStatus send(void* data, size_t size, IpAddress remoteAddress, ushort remotePort);
		public SocketStatus receive(void* data, size_t size, out size_t received, IpAddress remoteAddress, out ushort remotePort);
		public SocketStatus sendPacket(Packet packet, IpAddress remoteAddress, ushort remotePort);
		public SocketStatus receivePacket(Packet packet, IpAddress remoteAddress, ushort* remotePort);
		public uint maxDatagramSize();
	}

	[CCode (cname="sfTcpSocket", free_function="sfTcpSocket_destroy", cprefix="sfTcpSocket_")]
	[Compact]
	public class TcpSocket{
		[CCode(cname="sfTcpSocket_create")]
		public TcpSocket ();

		public void setBlocking(bool blocking);
		public bool isBlocking();
		public ushort getLocalPort();
		public IpAddress getRemoteAddress();
		public ushort getRemotePort();
		public SocketStatus connect(IpAddress remoteAddress, ushort remotePort, Time timeout);
		public void disconnect();
		public SocketStatus send(void* data, size_t size);
		public SocketStatus sendPartial(void* data, size_t size, out size_t sent);
		public SocketStatus receive(void* data, size_t size, out size_t received);
		public SocketStatus sendPacket(Packet packet);
		public SocketStatus receivePacket(Packet packet);
	}

	[CCode (cname="sfTcpListener", free_function="sfTcpListener_destroy", cprefix="sfTcpListener_")]
	[Compact]
	public class TcpListener{
		[CCode(cname="sfTcpListener_create")]
		public TcpListener();

		public void setBlocking(bool blocking);
		public bool isBlocking();
		public ushort getLocalPort();
		public SocketStatus listen(ushort port, IpAddress address);
		public SocketStatus accept(out TcpSocket[] connected);
	}

	[CCode(cname="sfFtpTransferMode", cprefix="sfFtp")]
	public enum FtpTransferMode
	{
		Binary, ///< Binary mode (file is transfered as a sequence of bytes)
		Ascii,  ///< Text mode using ASCII encoding
		Ebcdic  ///< Text mode using EBCDIC encoding
	} 

	[CCode(cname="sfFtpStatus", cprefix="sfFtp")]
	public enum FtpStatus
	{
		// 1xx: the requested action is being initiated,
		// expect another reply before proceeding with a new command
		RestartMarkerReply, ///< Restart marker reply
		ServiceReadySoon, ///< Service ready in N minutes
		DataConnectionAlreadyOpened, ///< Data connection already opened, transfer starting
		OpeningDataConnection, ///< File status ok, about to open data connection

		// 2xx: the requested action has been successfully completed
		Ok, ///< Command ok
		PointlessCommand, ///< Command not implemented
		SystemStatus, ///< System status, or system help reply
		DirectoryStatus, ///< Directory status
		FileStatus, ///< File status
		HelpMessage, ///< Help message
		SystemType, ///< NAME system type, where NAME is an official system name from the list in the Assigned Numbers document
		ServiceReady, ///< Service ready for new user
		ClosingConnection, ///< Service closing control connection
		DataConnectionOpened, ///< Data connection open, no transfer in progress
		ClosingDataConnection, ///< Closing data connection, requested file action successful
		EnteringPassiveMode, ///< Entering passive mode
		LoggedIn, ///< User logged in, proceed. Logged out if appropriate
		FileActionOk, ///< Requested file action ok
		DirectoryOk, ///< PATHNAME created

		// 3xx: the command has been accepted, but the requested action
		// is dormant, pending receipt of further information
		NeedPassword, ///< User name ok, need password
		NeedAccountToLogIn, ///< Need account for login
		NeedInformation, ///< Requested file action pending further information

		// 4xx: the command was not accepted and the requested action did not take place,
		// but the error condition is temporary and the action may be requested again
		ServiceUnavailable, ///< Service not available, closing control connection
		DataConnectionUnavailable, ///< Can't open data connection
		TransferAborted, ///< Connection closed, transfer aborted
		FileActionAborted, ///< Requested file action not taken
		LocalError, ///< Requested action aborted, local error in processing
		InsufficientStorageSpace, ///< Requested action not taken; insufficient storage space in system, file unavailable

		// 5xx: the command was not accepted and
		// the requested action did not take place
		CommandUnknown, ///< Syntax error, command unrecognized
		ParametersUnknown, ///< Syntax error in parameters or arguments
		CommandNotImplemented, ///< Command not implemented
		BadCommandSequence, ///< Bad sequence of commands
		ParameterNotImplemented, ///< Command not implemented for that parameter
		NotLoggedIn, ///< Not logged in
		NeedAccountToStore, ///< Need account for storing files
		FileUnavailable, ///< Requested action not taken, file unavailable
		PageTypeUnknown, ///< Requested action aborted, page type unknown
		NotEnoughMemory, ///< Requested file action aborted, exceeded storage allocation
		FilenameNotAllowed, ///< Requested action not taken, file name not allowed

		// 10xx: SFML custom codes
		InvalidResponse, ///< Response is not a valid FTP one
		ConnectionFailed, ///< Connection with server failed
		ConnectionClosed, ///< Connection with server closed
		InvalidFile ///< Invalid file to upload / download
	}
	
	[CCode (cname="sfFtpListingResponse", free_function="sfFtpListingResponse_destroy", cprefix="sfFtpListingResponse_")]
	[Compact]
	public class FtpListingResponse{
		public bool isOk();
		public FtpStatus getStatus();
		public unowned string getMessage();
		public size_t getCount();
		public unowned string getName(size_t index);
	}

	[CCode (cname="sfFtpDirectoryResponse", free_function="sfFtpDirectoryResponse_destroy", cprefix="sfFtpDirectoryResponse_")]
	[Compact]
	public class FtpDirectoryResponse{
		public bool isOk();
		public FtpStatus getStatus();
		public unowned string getMessage();
		public unowned string getDirectory();
		public uint32[] getDirectoryUnicode();
	}

	[CCode (cname="sfFtpResponse", free_function="sfFtpResponse_destroy", cprefix="sfFtpResponse_")]
	[Compact]
	public class FtpResponse{
		[CCode(cname="sfFtp_createDirectory")]
		public FtpResponse(Ftp ftp, string name);
		public bool isOk();
		public FtpStatus getStatus();
		public unowned string getMessage();
	}

	[CCode (cname="sfFtp", free_function="sfFtp_destroy", cprefix="sfFtp_")]
	[Compact]
	public class Ftp{

		[CCode(cname="sfFtp_create")]
		public Ftp();

		public FtpResponse connect(IpAddress server, ushort port, Time timeout);
		public FtpResponse loginAnonymous();
		public FtpResponse login(string name, string password);
		public FtpResponse disconnect();
		public FtpResponse keepAlive();
		public FtpDirectoryResponse getWorkingDirectory();
		public FtpListingResponse getDirectoryListing(string directory);
		public FtpResponse changeDirectory(string directory);
		public FtpResponse parentDirectory();
		public FtpResponse createDirectory(string name);
		public FtpResponse deleteDirectory(string name);
		public FtpResponse renameFile(string file, string newName);
		public FtpResponse deleteFile(string name);
		public FtpResponse download(string remoteFile, string localPath, FtpTransferMode mode);
		public FtpResponse upload(string localFile, string remotePath, FtpTransferMode mode, bool append);
		public FtpResponse sendCommand(string command, string parameter);
	}

}
