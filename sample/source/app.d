import derelict.mono;
import std.string;
import core.runtime : Runtime;

enum ModuleName = "printer.exe";
enum ClassName = "DPrinter";

extern (C) private MonoString* whichLang() nothrow
{
	return mono_string_new(mono_domain_get(), __VENDOR__.ptr);
}

void main()
{
	DerelictMono.load;
	MonoDomain* domain;

	mono_config_parse(null);

	domain = mono_jit_init(ModuleName);
	scope (exit)
		mono_jit_cleanup(domain);
	
	mono_add_internal_call(toStringz(ClassName ~ "::whichLang"), &whichLang);

	MonoAssembly* assembly = mono_domain_assembly_open(domain, ModuleName);
	if(assembly is null)
		throw new Exception("Assembly could not be opened.");
	
	auto args = Runtime.cArgs;
	mono_jit_exec(domain, assembly, args.argc, args.argv);
}
