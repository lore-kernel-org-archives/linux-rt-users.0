From: Remy Bohmer <remy@bohmer.net>
Subject: [patch 1/3] Add generic routine for parsing map-like options on
	kernel cmd-line
Date: Tue, 18 Dec 2007 23:05:06 +0100
Message-ID: <4768450f.1636440a.6de8.596a@mx.google.com>
References: <20071218220505.828395321@bohmer.net>>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	Darren Hart <dvhltc@us.ibm.com>,
	linux-rt-users@vger.kernel.org, Remy Bohmer <linux@bohmer.net>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:3058 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431AbXLRWJW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Dec 2007 17:09:22 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2266787fkz.5
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Dec 2007 14:09:21 -0800 (PST)
Content-Disposition: inline; filename=add-map-functionality-to-kernel-cmdline.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch adds a generic routine to the kernel, so that a map of
settings can be entered on the kernel commandline.

Signed-off-by: Remy Bohmer <linux@bohmer.net>

---
---
 include/linux/kernel.h |    1 
 lib/cmdline.c          |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

Index: linux-2.6.24-rc5-rt1/include/linux/kernel.h
===================================================================
--- linux-2.6.24-rc5-rt1.orig/include/linux/kernel.h	2007-12-18 21:32:09.000000000 +0100
+++ linux-2.6.24-rc5-rt1/include/linux/kernel.h	2007-12-18 21:33:58.000000000 +0100
@@ -164,6 +164,7 @@ extern int vsscanf(const char *, const c
 
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);
+extern int get_map_option(const char *str, const char *key, int *pint);
 extern unsigned long long memparse(char *ptr, char **retptr);
 
 extern int core_kernel_text(unsigned long addr);
Index: linux-2.6.24-rc5-rt1/lib/cmdline.c
===================================================================
--- linux-2.6.24-rc5-rt1.orig/lib/cmdline.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.24-rc5-rt1/lib/cmdline.c	2007-12-18 21:33:58.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <asm/setup.h>
 
 /*
  *	If a hyphen was found in get_option, this will handle the
@@ -114,6 +115,63 @@ char *get_options(const char *str, int n
 }
 
 /**
+ *	get_map_option - Parse integer from an option map
+ *
+ *	This function parses an integer from an option map like
+ *           some_map=key1:99,key2:98,...,keyN:NN,NN
+ *	Only the value of the first match is returned, or if no
+ *	key option is given (key = NULL) the value of the first
+ *	field without a ':' is returned.
+ *
+ *	@str: option string
+ *	@key: The key inside the map, can be NULL
+ *	@pint: (output) integer value parsed from the map @str
+ *
+ *	Return values:
+ *	0 - no int in string
+ *	1 - int found
+ */
+int get_map_option(const char *str, const char *key, int *pint)
+{
+	char  buf[COMMAND_LINE_SIZE];
+	char  *p, *substr;
+	int   found = 0;
+
+	/* We must copy the string to the stack, because strsep()
+	   changes it.*/
+	strncpy(buf, str, COMMAND_LINE_SIZE);
+	buf[COMMAND_LINE_SIZE-1] = '\0';
+
+	p = buf;
+	substr = strsep(&p, ",");
+	while ((!found) && (substr != NULL)) {
+		if (strlen(substr) != 0) {
+			if (key == NULL) {
+				/* Check for the absence of any ':' */
+				if (strchr(substr, ':') == NULL) {
+					sscanf(substr, "%d", pint);
+					found = 1;
+				}
+			} else {
+				/* check if the first part of the key matches */
+				if (!strncmp(substr, key, strlen(key))) {
+					substr += strlen(key);
+					/* Now the next char must be a ':',
+					   if not, search for the next match */
+					if (*substr == ':') {
+						substr++;
+						sscanf(substr, "%d", pint);
+						found = 1;
+					}
+				}
+			}
+		}
+		substr = strsep(&p, ",");
+	}
+	return found;
+}
+
+/**
  *	memparse - parse a string with mem suffixes into a number
  *	@ptr: Where parse begins
  *	@retptr: (output) Pointer to next char after parse completes

-- 
