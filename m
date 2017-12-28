From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/35] perf probe: Find versioned symbols from map
Date: Thu, 28 Dec 2017 11:30:16 -0300
Message-ID: <20171228143027.30547-25-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Commit d80406453ad4 ("perf symbols: Allow user probes on versioned
symbols") allows user to find default versioned symbols (with "@@") in
map. However, it did not enable normal versioned symbol (with "@") for
perf-probe.  E.g.

  =====
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Failed to find symbol malloc_get_state in /usr/lib64/libc-2.25.so
    Error: Failed to add events.
  =====

This solves above issue by improving perf-probe symbol search function,
as below.

  =====
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Added new event:
    probe_libc:malloc_get_state (on malloc_get_state in /usr/lib64/libc-2.25.so)

  You can now use it in all perf tools, such as:

	  perf record -e probe_libc:malloc_get_state -aR sleep 1

  # ./perf probe -l
    probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
  =====

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275049269.24652.1639103455496216255.stgit@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c |  8 ++++++++
 tools/perf/util/probe-event.c               | 20 ++++++++++++++++++--
 tools/perf/util/symbol.c                    |  5 +++++
 tools/perf/util/symbol.h                    |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 9c4e23d8c8ce..53d83d7e6a09 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -64,6 +64,14 @@ int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 
 	return strncmp(namea, nameb, n);
 }
+
+const char *arch__normalize_symbol_name(const char *name)
+{
+	/* Skip over initial dot */
+	if (name && *name == '.')
+		name++;
+	return name;
+}
 #endif
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a68141d360b0..0d6c66d51939 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2801,16 +2801,32 @@ static int find_probe_functions(struct map *map, char *name,
 	int found = 0;
 	struct symbol *sym;
 	struct rb_node *tmp;
+	const char *norm, *ver;
+	char *buf = NULL;
 
 	if (map__load(map) < 0)
 		return 0;
 
 	map__for_each_symbol(map, sym, tmp) {
-		if (strglobmatch(sym->name, name)) {
+		norm = arch__normalize_symbol_name(sym->name);
+		if (!norm)
+			continue;
+
+		/* We don't care about default symbol or not */
+		ver = strchr(norm, '@');
+		if (ver) {
+			buf = strndup(norm, ver - norm);
+			if (!buf)
+				return -ENOMEM;
+			norm = buf;
+		}
+		if (strglobmatch(norm, name)) {
 			found++;
 			if (syms && found < probe_conf.max_probes)
 				syms[found - 1] = sym;
 		}
+		if (buf)
+			zfree(&buf);
 	}
 
 	return found;
@@ -2856,7 +2872,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	 * same name but different addresses, this lists all the symbols.
 	 */
 	num_matched_functions = find_probe_functions(map, pp->function, syms);
-	if (num_matched_functions == 0) {
+	if (num_matched_functions <= 0) {
 		pr_err("Failed to find symbol %s in %s\n", pp->function,
 			pev->target ? : "kernel");
 		ret = -ENOENT;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1b67a8639dfe..cc065d4bfafc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -94,6 +94,11 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
 
+const char * __weak arch__normalize_symbol_name(const char *name)
+{
+	return name;
+}
+
 int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
 {
 	return strcmp(namea, nameb);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a4f0075b4e5c..0563f33c1eb3 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -349,6 +349,7 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
 
+const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
-- 
2.13.6
