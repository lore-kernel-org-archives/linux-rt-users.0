From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 009/124] perf probe: Find versioned symbols
 from map
Date: Mon, 19 Mar 2018 15:47:06 +0000
Message-ID: <20180319154645.11350-9-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 4b3a2716dd785fabb9f6ac80c1d53cb29a88169d ]

Commit d80406453ad4 ("perf symbols: Allow user probes on versioned
symbols") allows user to find default versioned symbols (with "@@") in
map. However, it did not enable normal versioned symbol (with "@") for
perf-probe.  E.g.

  =3D=3D=3D=3D=3D
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Failed to find symbol malloc_get_state in /usr/lib64/libc-2.25.so
    Error: Failed to add events.
  =3D=3D=3D=3D=3D

This solves above issue by improving perf-probe symbol search function,
as below.

  =3D=3D=3D=3D=3D
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Added new event:
    probe_libc:malloc_get_state (on malloc_get_state in /usr/lib64/libc-2.2=
5.so)

  You can now use it in all perf tools, such as:

	  perf record -e probe_libc:malloc_get_state -aR sleep 1

  # ./perf probe -l
    probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/li=
b64/libc-2.25.so)
  =3D=3D=3D=3D=3D

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275049269.24652.1639103455496216255.stgit=
@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c |  8 ++++++++
 tools/perf/util/probe-event.c               | 20 ++++++++++++++++++--
 tools/perf/util/symbol.c                    |  5 +++++
 tools/perf/util/symbol.h                    |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/=
powerpc/util/sym-handling.c
index 9c4e23d8c8ce..53d83d7e6a09 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -64,6 +64,14 @@ int arch__compare_symbol_names_n(const char *namea, cons=
t char *nameb,
=20
 	return strncmp(namea, nameb, n);
 }
+
+const char *arch__normalize_symbol_name(const char *name)
+{
+	/* Skip over initial dot */
+	if (name && *name =3D=3D '.')
+		name++;
+	return name;
+}
 #endif
=20
 #if defined(_CALL_ELF) && _CALL_ELF =3D=3D 2
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b7aaf9b2294d..c3cd3488fee7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2792,16 +2792,32 @@ static int find_probe_functions(struct map *map, ch=
ar *name,
 	int found =3D 0;
 	struct symbol *sym;
 	struct rb_node *tmp;
+	const char *norm, *ver;
+	char *buf =3D NULL;
=20
 	if (map__load(map) < 0)
 		return 0;
=20
 	map__for_each_symbol(map, sym, tmp) {
-		if (strglobmatch(sym->name, name)) {
+		norm =3D arch__normalize_symbol_name(sym->name);
+		if (!norm)
+			continue;
+
+		/* We don't care about default symbol or not */
+		ver =3D strchr(norm, '@');
+		if (ver) {
+			buf =3D strndup(norm, ver - norm);
+			if (!buf)
+				return -ENOMEM;
+			norm =3D buf;
+		}
+		if (strglobmatch(norm, name)) {
 			found++;
 			if (syms && found < probe_conf.max_probes)
 				syms[found - 1] =3D sym;
 		}
+		if (buf)
+			zfree(&buf);
 	}
=20
 	return found;
@@ -2847,7 +2863,7 @@ static int find_probe_trace_events_from_map(struct pe=
rf_probe_event *pev,
 	 * same name but different addresses, this lists all the symbols.
 	 */
 	num_matched_functions =3D find_probe_functions(map, pp->function, syms);
-	if (num_matched_functions =3D=3D 0) {
+	if (num_matched_functions <=3D 0) {
 		pr_err("Failed to find symbol %s in %s\n", pp->function,
 			pev->target ? : "kernel");
 		ret =3D -ENOENT;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1b67a8639dfe..cc065d4bfafc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -94,6 +94,11 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
=20
+const char * __weak arch__normalize_symbol_name(const char *name)
+{
+	return name;
+}
+
 int __weak arch__compare_symbol_names(const char *namea, const char *nameb=
)
 {
 	return strcmp(namea, nameb);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a4f0075b4e5c..0563f33c1eb3 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -349,6 +349,7 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
=20
+const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
=20
--=20
2.14.1
