From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 5/5] perf-probe: Support escaped character in parser
Date: Sat,  9 Dec 2017 01:28:41 +0900
Message-ID: <151275052163.24652.18205979384585484358.stgit@devbox>
References: <151275037752.24652.5169845651138876257.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <151275037752.24652.5169845651138876257.stgit@devbox>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Support the special characters escaped by '\' in parser.
This allows user to specify versions directly like below.

  =====
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state\\@GLIBC_2.2.5
  Added new event:
    probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)

  You can now use it in all perf tools, such as:

	  perf record -e probe_libc:malloc_get_state -aR sleep 1

  =====

Or, you can use separators in source filename, e.g.

  =====
  # ./perf probe -x /opt/test/a.out foo+bar.c:3
  Semantic error :There is non-digit character in offset.
    Error: Command Parse Error.
  =====

Usually "+" in source file cause parser error, but

  =====
  # ./perf probe -x /opt/test/a.out foo\\+bar.c:4
  Added new event:
    probe_a:main         (on @foo+bar.c:4 in /opt/test/a.out)

  You can now use it in all perf tools, such as:

	  perf record -e probe_a:main -aR sleep 1
  =====

escaped "\+" allows you to specify that.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 Changes in v2:
  - Add a description and samples in Documentation/perf-probe.txt
 Changes in v3:
  - Update for new series.
---
 tools/perf/Documentation/perf-probe.txt |   16 +++++++++
 tools/perf/util/probe-event.c           |   57 ++++++++++++++++++-------------
 tools/perf/util/string.c                |   46 +++++++++++++++++++++++++
 tools/perf/util/string2.h               |    2 +
 4 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index f96382692f42..b6866a05edd2 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -182,6 +182,14 @@ Note that before using the SDT event, the target binary (on which SDT events are
 For details of the SDT, see below.
 https://sourceware.org/gdb/onlinedocs/gdb/Static-Probe-Points.html
 
+ESCAPED CHARACTER
+-----------------
+
+In the probe syntax, '=', '@', '+', ':' and ';' are treated as a special character. You can use a backslash ('\') to escape the special characters.
+This is useful if you need to probe on a specific versioned symbols, like @GLIBC_... suffixes, or also you need to specify a source file which includes the special characters.
+Note that usually single backslash is consumed by shell, so you might need to pass double backslash (\\) or wrapping with single quotes (\'AAA\@BBB').
+See EXAMPLES how it is used.
+
 PROBE ARGUMENT
 --------------
 Each probe argument follows below syntax.
@@ -277,6 +285,14 @@ Add a USDT probe to a target process running in a different mount namespace
 
  ./perf probe --target-ns <target pid> -x /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.121-0.b13.el7_3.x86_64/jre/lib/amd64/server/libjvm.so %sdt_hotspot:thread__sleep__end
 
+Add a probe on specific versioned symbol by backslash escape
+
+ ./perf probe -x /lib64/libc-2.25.so 'malloc_get_state\@GLIBC_2.2.5'
+
+Add a probe in a source file using special characters by backslash escape
+
+ ./perf probe -x /opt/test/a.out 'foo\+bar.c:4'
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0d6c66d51939..735972e7bc6b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1325,27 +1325,30 @@ static int parse_perf_probe_event_name(char **arg, struct perf_probe_event *pev)
 {
 	char *ptr;
 
-	ptr = strchr(*arg, ':');
+	ptr = strpbrk_esc(*arg, ":");
 	if (ptr) {
 		*ptr = '\0';
 		if (!pev->sdt && !is_c_func_name(*arg))
 			goto ng_name;
-		pev->group = strdup(*arg);
+		pev->group = strdup_esc(*arg);
 		if (!pev->group)
 			return -ENOMEM;
 		*arg = ptr + 1;
 	} else
 		pev->group = NULL;
-	if (!pev->sdt && !is_c_func_name(*arg)) {
+
+	pev->event = strdup_esc(*arg);
+	if (pev->event == NULL)
+		return -ENOMEM;
+
+	if (!pev->sdt && !is_c_func_name(pev->event)) {
+		zfree(&pev->event);
 ng_name:
+		zfree(&pev->group);
 		semantic_error("%s is bad for event name -it must "
 			       "follow C symbol-naming rule.\n", *arg);
 		return -EINVAL;
 	}
-	pev->event = strdup(*arg);
-	if (pev->event == NULL)
-		return -ENOMEM;
-
 	return 0;
 }
 
@@ -1373,7 +1376,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 			arg++;
 	}
 
-	ptr = strpbrk(arg, ";=@+%");
+	ptr = strpbrk_esc(arg, ";=@+%");
 	if (pev->sdt) {
 		if (ptr) {
 			if (*ptr != '@') {
@@ -1387,7 +1390,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 				pev->target = build_id_cache__origname(tmp);
 				free(tmp);
 			} else
-				pev->target = strdup(ptr + 1);
+				pev->target = strdup_esc(ptr + 1);
 			if (!pev->target)
 				return -ENOMEM;
 			*ptr = '\0';
@@ -1421,13 +1424,14 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 	 *
 	 * Otherwise, we consider arg to be a function specification.
 	 */
-	if (!strpbrk(arg, "+@%") && (ptr = strpbrk(arg, ";:")) != NULL) {
+	if (!strpbrk_esc(arg, "+@%")) {
+		ptr = strpbrk_esc(arg, ";:");
 		/* This is a file spec if it includes a '.' before ; or : */
-		if (memchr(arg, '.', ptr - arg))
+		if (ptr && memchr(arg, '.', ptr - arg))
 			file_spec = true;
 	}
 
-	ptr = strpbrk(arg, ";:+@%");
+	ptr = strpbrk_esc(arg, ";:+@%");
 	if (ptr) {
 		nc = *ptr;
 		*ptr++ = '\0';
@@ -1436,7 +1440,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 	if (arg[0] == '\0')
 		tmp = NULL;
 	else {
-		tmp = strdup(arg);
+		tmp = strdup_esc(arg);
 		if (tmp == NULL)
 			return -ENOMEM;
 	}
@@ -1469,12 +1473,12 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 		arg = ptr;
 		c = nc;
 		if (c == ';') {	/* Lazy pattern must be the last part */
-			pp->lazy_line = strdup(arg);
+			pp->lazy_line = strdup(arg); /* let leave escapes */
 			if (pp->lazy_line == NULL)
 				return -ENOMEM;
 			break;
 		}
-		ptr = strpbrk(arg, ";:+@%");
+		ptr = strpbrk_esc(arg, ";:+@%");
 		if (ptr) {
 			nc = *ptr;
 			*ptr++ = '\0';
@@ -1501,7 +1505,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 				semantic_error("SRC@SRC is not allowed.\n");
 				return -EINVAL;
 			}
-			pp->file = strdup(arg);
+			pp->file = strdup_esc(arg);
 			if (pp->file == NULL)
 				return -ENOMEM;
 			break;
@@ -2803,23 +2807,30 @@ static int find_probe_functions(struct map *map, char *name,
 	struct rb_node *tmp;
 	const char *norm, *ver;
 	char *buf = NULL;
+	bool cut_version = true;
 
 	if (map__load(map) < 0)
 		return 0;
 
+	/* If user gives a version, don't cut off the version from symbols */
+	if (strchr(name, '@'))
+		cut_version = false;
+
 	map__for_each_symbol(map, sym, tmp) {
 		norm = arch__normalize_symbol_name(sym->name);
 		if (!norm)
 			continue;
 
-		/* We don't care about default symbol or not */
-		ver = strchr(norm, '@');
-		if (ver) {
-			buf = strndup(norm, ver - norm);
-			if (!buf)
-				return -ENOMEM;
-			norm = buf;
+		if (cut_version) {
+			/* We don't care about default symbol or not */
+			ver = strchr(norm, '@');
+			if (ver) {
+				buf = strndup(norm, ver - norm);
+				if (!buf)
+					return -ENOMEM;
+				norm = buf;
 		}
+
 		if (strglobmatch(norm, name)) {
 			found++;
 			if (syms && found < probe_conf.max_probes)
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index aaa08ee8c717..d8bfd0c4d2cb 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -396,3 +396,49 @@ char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints
 	free(expr);
 	return NULL;
 }
+
+/* Like strpbrk(), but not break if it is right after a backslash (escaped) */
+char *strpbrk_esc(char *str, const char *stopset)
+{
+	char *ptr;
+
+	do {
+		ptr = strpbrk(str, stopset);
+		if (ptr == str ||
+		    (ptr == str + 1 && *(ptr - 1) != '\\'))
+			break;
+		str = ptr + 1;
+	} while (ptr && *(ptr - 1) == '\\' && *(ptr - 2) != '\\');
+
+	return ptr;
+}
+
+/* Like strdup, but do not copy a single backslash */
+char *strdup_esc(const char *str)
+{
+	char *s, *d, *p, *ret = strdup(str);
+
+	if (!ret)
+		return NULL;
+
+	d = strchr(ret, '\\');
+	if (!d)
+		return ret;
+
+	s = d + 1;
+	do {
+		if (*s == '\0') {
+			*d = '\0';
+			break;
+		}
+		p = strchr(s + 1, '\\');
+		if (p) {
+			memmove(d, s, p - s);
+			d += p - s;
+			s = p + 1;
+		} else
+			memmove(d, s, strlen(s) + 1);
+	} while (p);
+
+	return ret;
+}
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index ee14ca5451ab..4c68a09b97e8 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -39,5 +39,7 @@ static inline char *asprintf_expr_not_in_ints(const char *var, size_t nints, int
 	return asprintf_expr_inout_ints(var, false, nints, ints);
 }
 
+char *strpbrk_esc(char *str, const char *stopset);
+char *strdup_esc(const char *str);
 
 #endif /* PERF_STRING_H */
