From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 4/5] perf-probe: Find versioned symbols from map
Date: Fri, 8 Dec 2017 23:22:49 +0900
Message-ID: <20171208232249.65cd9951e026c9d9c57740be@kernel.org>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
        <151263128603.13843.14383703750561651246.stgit@devbox>
        <034765fc-975a-a210-6ed8-bebd3b1ff9b3@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <034765fc-975a-a210-6ed8-bebd3b1ff9b3@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 8 Dec 2017 12:08:41 +0100
Thomas-Mich Richter <tmricht@linux.vnet.ibm.com> wrote:

> On 12/07/2017 08:21 AM, Masami Hiramatsu wrote:
> > Find versioned symbols correctly from map.
> > Commit d80406453ad4 ("perf symbols: Allow user probes on
> > versioned symbols") allows user to find default versioned
> > symbols (with "@@") in map. However, it did not enable
> > normal versioned symbol (with "@") for perf-probe.
> > E.g.
> > 
> >   =====
> >   # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
> >   Failed to find symbol malloc_get_state in /usr/lib64/libc-2.25.so
> >     Error: Failed to add events.
> >   =====
> > 
> > This solves above issue by improving perf-probe symbol
> > search function, as below.
> > 
> >   =====
> >   # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
> >   Added new event:
> >     probe_libc:malloc_get_state (on malloc_get_state in /usr/lib64/libc-2.25.so)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> > 	  perf record -e probe_libc:malloc_get_state -aR sleep 1
> > 
> >   # ./perf probe -l
> >     probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
> >   =====
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/arch/powerpc/util/sym-handling.c |    8 ++++++++
> >  tools/perf/util/probe-event.c               |   16 +++++++++++++++-
> >  tools/perf/util/symbol.c                    |    5 +++++
> >  tools/perf/util/symbol.h                    |    1 +
> >  4 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> > index 9c4e23d8c8ce..a3613c8d97b6 100644
> > --- a/tools/perf/arch/powerpc/util/sym-handling.c
> > +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> > @@ -64,6 +64,14 @@ int arch__compare_symbol_names_n(const char *namea, const char *nameb,
> > 
> >  	return strncmp(namea, nameb, n);
> >  }
> > +
> > +const char *arch__normalize_symbol_name(const char *name)
> > +{
> > +	/* Skip over initial dot */
> > +	if (*name == '.')
> > +		name++;
> > +	return name;
> > +}
> >  #endif
> > 
> >  #if defined(_CALL_ELF) && _CALL_ELF == 2
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 959c4d2ef455..94acc5846e2a 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2801,16 +2801,30 @@ static int find_probe_functions(struct map *map, char *name,
> >  	int found = 0;
> >  	struct symbol *sym;
> >  	struct rb_node *tmp;
> > +	const char *norm, *ver;
> > +	char *buf = NULL;
> > 
> >  	if (map__load(map) < 0)
> >  		return 0;
> > 
> >  	map__for_each_symbol(map, sym, tmp) {
> > -		if (strglobmatch(sym->name, name)) {
> > +		norm = arch__normalize_symbol_name(sym->name);
> 
> The weak default function arch__normalize_symbol_name() simply returns
> its parameter, so norm can be a NULL ptr when parameter sym->name is a 
> NULL pointer.
> However when sym->name is a NULL pointer (or can be one) then the
> Powerpc version of arch__normalize_symbol_name() dereferences a NULL
> ptr (by checking the symbol's first character is a '.').

Oops, right!
Thank you for pointing out. :)

> 
> > +		if (!norm)
> > +			continue;
> > +
> > +		/* We don't care about default symbol or not */
> > +		ver = strchr(norm, '@');
> > +		if (ver) {
> > +			buf = strndup(norm, ver - norm);
> > +			norm = buf;
> 
> if strndup() returns a NULL pointer (due to lack of memory)
> then variable norm is a NULL ptr and strglobmatch() --> __match_glob()
> derefenences that NULL pointer (1. parameter).

Ah, right. easy miss...

OK, I'll update.

Thank you,

> 
> > +		}
> > +		if (strglobmatch(norm, name)) {
> >  			found++;
> >  			if (syms && found < probe_conf.max_probes)
> >  				syms[found - 1] = sym;
> >  		}
> > +		if (buf)
> > +			zfree(&buf);
> >  	}
> > 
> >  	return found;
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 1b67a8639dfe..cc065d4bfafc 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -94,6 +94,11 @@ static int prefix_underscores_count(const char *str)
> >  	return tail - str;
> >  }
> > 
> > +const char * __weak arch__normalize_symbol_name(const char *name)
> > +{
> > +	return name;
> > +}
> > +
> >  int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
> >  {
> >  	return strcmp(namea, nameb);
> > diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> > index a4f0075b4e5c..0563f33c1eb3 100644
> > --- a/tools/perf/util/symbol.h
> > +++ b/tools/perf/util/symbol.h
> > @@ -349,6 +349,7 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
> >  void arch__sym_update(struct symbol *s, GElf_Sym *sym);
> >  #endif
> > 
> > +const char *arch__normalize_symbol_name(const char *name);
> >  #define SYMBOL_A 0
> >  #define SYMBOL_B 1
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
