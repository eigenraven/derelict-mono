using System;
using System.Runtime.CompilerServices;

class DPrinter
{
	[MethodImplAttribute(MethodImplOptions.InternalCall)]
	extern static string whichLang();

	static void Main()
	{
		Console.WriteLine ("Hello from " + whichLang () + "+C#!");
	}
}
