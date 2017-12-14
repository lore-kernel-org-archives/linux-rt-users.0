From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/34] perf string: Add {strdup,strpbrk}_esc()
Date: Thu, 14 Dec 2017 14:42:38 -0300
Message-ID: <20171214174247.16841-26-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

To support the special characters escaped by '\' in 'perf probe' event parser.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275052163.24652.18205979384585484358.stgit@devbox
[ Split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/string.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/string2.h |  2 ++
 2 files changed, 48 insertions(+)

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
-- 
2.13.6
