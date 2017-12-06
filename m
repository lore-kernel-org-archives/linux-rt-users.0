From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/5] perf-probe: Find versioned symbols from map
Date: Wed,  6 Dec 2017 12:08:15 +0900
Message-ID: <151252969529.12861.15385115001254086477.stgit@devbox>
References: <151252958056.12861.954203514347167563.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754350AbdLFDIj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Dec 2017 22:08:39 -0500
In-Reply-To: <151252958056.12861.954203514347167563.stgit@devbox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Find versioned symbols correctly from map.
Commit d80406453ad4 ("perf symbols: Allow user probes on
versioned symbols") allows user to find default versioned
symbols (with "@@") in map. However, it did not enable
normal versioned symbol (with "@") for perf-probe.
E.g.

  =====
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Failed to find symbol malloc_get_state in /usr/lib64/libc-2.25.so
    Error: Failed to add events.
  =====

This solves above issue by improving perf-probe symbol
search function, as below.

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
---
 tools/perf/arch/powerpc/util/sym-handling.c |    8 ++++++++
 tools/perf/util/probe-event.c               |   16 +++++++++++++++-
 tools/perf/util/symbol.c                    |    5 +++++
 tools/perf/util/symbol.h                    |    1 +
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 9c4e23d8c8ce..a3613c8d97b6 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -64,6 +64,14 @@ int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 
 	return strncmp(namea, nameb, n);
 }
+
+const char *arch__normalize_symbol_name(const char *name)
+{
+	/* Skip over initial dot */
+	if (*name == '.')
+		name++;
+	return name;
+}
 #endif
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 959c4d2ef455..94acc5846e2a 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2801,16 +2801,30 @@ static int find_probe_functions(struct map *map, char *name,
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
 

