Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77BB25E448
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898256; cv=none; b=EhmA6jg0+Pv7tMqd26yCYmoOVbSwm0OJsbMVn4cKGsikGQrcal80DGtZi8Gv8QldzsRsk5nTD5DkxoYU1H4HNpGNYmWpihWAzMH7cqqffEBpmvDaqVA8AUz0VXW4M8KXPvCtIqiQbS7EpO0rCGjP5oVXxrPSHeA5URVKPvVaxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898256; c=relaxed/simple;
	bh=h61bqhlHM2l+iSP0IYc6/odYJnUJ/a53KXmH0IezWB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ukc4k3p2ISUYTYxYSp0zxkvtMRepSir4NbJcRYyjc58EX0/JnTsOAX+c2uCrYCDf6qW1PCikNiMnkA54bZYhWJrLaRnNhEYnTHstSfKAmt747DDb8+xnaSuA5tByQBfjwt5IW7GFRbsxM69qx0P4Fo4GICnv4Pa2dEQK6rydEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nVOj3W1o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+tx3feV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nVOj3W1o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+tx3feV"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1bvdUiSa9jT1hiK8KwBqSRpipGs6mEEumMod0e8Vf8=;
	b=nVOj3W1oJiuRwCO+Crzh5VtBItNEqxbsQG5rPNuvNMjusZrMXEGy0i5jSKEknXuBcPk39g
	sNG6edYWEUdnvj9KKCpjRCsBtgHT9ds4T3xSElBmz+B3SGda3ywTvSOWBuq9x4Lhp1SrTl
	J4ORwLLS5ueAydgpTkxKdGtCcTxlvuigBHmq+W/Y6tS1PJrKWQ2rH+1hqLXHJuBrMCfp7c
	9/JZbl0KUPOohJxRrprpSlVnumMvqYPjBFF5iJDisPFYE21tIGnFMkWcgN4f0DlA3a7HF/
	3pz9xGguPTMUpcsqf3KAvM9DawFhQ0CD5IjPmRLIRanFoQoOgTZyuWd7SHUkEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1bvdUiSa9jT1hiK8KwBqSRpipGs6mEEumMod0e8Vf8=;
	b=Z+tx3feV29d7Kiw7EEXdiILMzHwwveV6dvQwLuXnfftLoEfl50v2NirTcjr6jwsQulYLe5
	se1RCMk914lp6BBA==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/10] rt-utils: Rename get_debugfileprefix() and let it look for tracefs
Date: Wed,  3 Sep 2025 13:17:10 +0200
Message-ID: <20250903111717.1391196-4-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

get_debugfileprefix() used to look for debugfs and added the tracing
suffix to it. In the early days it it was not always monted at the same
destination. Later, that function got a fastpath to look directly at
"/sys/kernel/debug/tracing". This avoids parsing the mounted filesystem
and looking for debugfs.

Since about v4.1 (released over 10 years ago) that tracing folder moved
out debugfs and got its own filesystem (tracefs) and is mounted at
/sys/kernel/tracing. Since then that /sys/kernel/debug/tracing folder is
just an automount/ alias to /sys/kernel/tracing.
Since v6.17 that automount can be disabled and is schedulued for
removal.
Strart using tracefs directly instead that alias:
- Replace that "debug" prefix with tracefs since debugfs is no longer
  the thing that is used
- Look directy for /sys/kernel/tracing
- If it is not there, look for tracefs filesystem in case it is mounted
  at an unusual spot.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/backfire/sendme.c         |  2 +-
 src/include/rt-utils.h        |  2 +-
 src/lib/rt-utils.c            | 51 ++++++++++++-----------------------
 src/pmqtest/pmqtest.c         |  2 +-
 src/ptsematest/ptsematest.c   |  2 +-
 src/sigwaittest/sigwaittest.c |  2 +-
 src/svsematest/svsematest.c   |  2 +-
 7 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index da10397846f79..1c3e8b0c4c1b9 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -45,7 +45,7 @@ static int interval =3D 1000;
 static int kernvar(int mode, const char *name, char *value, size_t sizeofv=
alue)
 {
 	char filename[128];
-	char *fileprefix =3D get_debugfileprefix();
+	char *fileprefix =3D get_tracefs_prefix();
 	int retval =3D 1;
 	int path;
 	size_t len_prefix =3D strlen(fileprefix), len_name =3D strlen(name);
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 95964f70a6310..569023c5d3051 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -11,7 +11,7 @@
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
=20
 int check_privs(void);
-char *get_debugfileprefix(void);
+char *get_tracefs_prefix(void);
 int get_tracers(char ***);
 int valid_tracer(char *);
=20
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 7e96950ef9887..696bca2657d18 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -32,7 +32,7 @@
 #define  MAX_COMMAND_LINE 4096
 #define  MAX_TS_SIZE 64
=20
-static char debugfileprefix[MAX_PATH];
+static char tracefs_prefix[MAX_PATH];
 static char *fileprefix;
 static int trace_fd =3D -1;
 static int tracemark_fd =3D -1;
@@ -41,28 +41,21 @@ static char test_cmdline[MAX_COMMAND_LINE];
 static char ts_start[MAX_TS_SIZE];
=20
 /*
- * Finds the tracing directory in a mounted debugfs
+ * Finds the tracing directory
  */
-char *get_debugfileprefix(void)
+char *get_tracefs_prefix(void)
 {
 	char type[100];
 	FILE *fp;
-	int size;
 	int found =3D 0;
 	struct stat s;
=20
-	if (debugfileprefix[0] !=3D '\0')
+	if (tracefs_prefix[0] !=3D '\0')
 		goto out;
=20
 	/* look in the "standard" mount point first */
-	if ((stat("/sys/kernel/debug/tracing", &s) =3D=3D 0) && S_ISDIR(s.st_mode=
)) {
-		strcpy(debugfileprefix, "/sys/kernel/debug/tracing/");
-		goto out;
-	}
-
-	/* now look in the "other standard" place */
-	if ((stat("/debug/tracing", &s) =3D=3D 0) && S_ISDIR(s.st_mode)) {
-		strcpy(debugfileprefix, "/debug/tracing/");
+	if ((stat("/sys/kernel/tracing", &s) =3D=3D 0) && S_ISDIR(s.st_mode)) {
+		strcpy(tracefs_prefix, "/sys/kernel/tracing/");
 		goto out;
 	}
=20
@@ -73,14 +66,8 @@ char *get_debugfileprefix(void)
 	while (fscanf(fp, "%*s %"
 		      STR(MAX_PATH)
 		      "s %99s %*s %*d %*d\n",
-		      debugfileprefix, type) =3D=3D 2) {
-		if (strcmp(type, "debugfs") =3D=3D 0) {
-			found =3D 1;
-			break;
-		}
-		/* stupid check for systemd-style autofs mount */
-		if ((strcmp(debugfileprefix, "/sys/kernel/debug") =3D=3D 0) &&
-		    (strcmp(type, "systemd") =3D=3D 0)) {
+		      tracefs_prefix, type) =3D=3D 2) {
+		if (strcmp(type, "tracefs") =3D=3D 0) {
 			found =3D 1;
 			break;
 		}
@@ -88,15 +75,11 @@ char *get_debugfileprefix(void)
 	fclose(fp);
=20
 	if (!found) {
-		debugfileprefix[0] =3D '\0';
+		tracefs_prefix[0] =3D '\0';
 		goto out;
 	}
-
-	size =3D sizeof(debugfileprefix) - strlen(debugfileprefix);
-	strncat(debugfileprefix, "/tracing/", size);
-
 out:
-	return debugfileprefix;
+	return tracefs_prefix;
 }
=20
 static char **tracer_list;
@@ -113,7 +96,7 @@ int get_tracers(char ***list)
 	int ret;
 	FILE *fp;
 	char buffer[CHUNKSZ];
-	char *prefix =3D get_debugfileprefix();
+	char *prefix =3D get_tracefs_prefix();
 	char *tmpbuf =3D NULL;
 	char *ptr;
 	int tmpsz =3D 0;
@@ -193,7 +176,7 @@ int valid_tracer(char *tracername)
  */
 int setevent(char *event, char *val)
 {
-	char *prefix =3D get_debugfileprefix();
+	char *prefix =3D get_tracefs_prefix();
 	char buffer[MAX_PATH];
 	int fd;
 	int ret;
@@ -417,19 +400,19 @@ static void close_tracemark_fd(void)
 static int trace_file_exists(char *name)
 {
 	struct stat sbuf;
-	char *tracing_prefix =3D get_debugfileprefix();
+	char *tracing_prefix =3D get_tracefs_prefix();
 	char path[MAX_PATH];
 	strcat(strcpy(path, tracing_prefix), name);
 	return stat(path, &sbuf) ? 0 : 1;
 }
=20
-static void debugfs_prepare(void)
+static void tracefs_prepare(void)
 {
-	fileprefix =3D get_debugfileprefix();
+	fileprefix =3D get_tracefs_prefix();
 	if (!trace_file_exists("tracing_enabled") &&
 	    !trace_file_exists("tracing_on"))
 		warn("tracing_enabled or tracing_on not found\n"
-		     "debug fs not mounted");
+		     "tracefs not found");
 }
=20
 void tracemark(char *fmt, ...)
@@ -455,7 +438,7 @@ void tracemark(char *fmt, ...)
=20
 void enable_trace_mark(void)
 {
-	debugfs_prepare();
+	tracefs_prepare();
 	open_tracemark_fd();
 }
=20
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 04e36a1ad9795..a25b5cd2c24a1 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -184,7 +184,7 @@ void *pmqthread(void *param)
 			if (par->tracelimit && par->maxdiff > par->tracelimit) {
 				char tracing_enabled_file[MAX_PATH];
=20
-				strcpy(tracing_enabled_file, get_debugfileprefix());
+				strcpy(tracing_enabled_file, get_tracefs_prefix());
 				strcat(tracing_enabled_file, "tracing_on");
 				int tracing_enabled =3D
 				    open(tracing_enabled_file, O_WRONLY);
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index d21166946f6ac..00871d08df3a8 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -107,7 +107,7 @@ void *semathread(void *param)
 			if (par->tracelimit && par->maxdiff > par->tracelimit) {
 				char tracing_enabled_file[MAX_PATH];
=20
-				strcpy(tracing_enabled_file, get_debugfileprefix());
+				strcpy(tracing_enabled_file, get_tracefs_prefix());
 				strcat(tracing_enabled_file, "tracing_on");
 				int tracing_enabled =3D
 				    open(tracing_enabled_file, O_WRONLY);
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 026cc81510157..e55f7fd2411f6 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -163,7 +163,7 @@ void *semathread(void *param)
 			if (par->tracelimit && par->maxdiff > par->tracelimit) {
 				char tracing_enabled_file[MAX_PATH];
=20
-				strcpy(tracing_enabled_file, get_debugfileprefix());
+				strcpy(tracing_enabled_file, get_tracefs_prefix());
 				strcat(tracing_enabled_file, "tracing_on");
 				int tracing_enabled =3D
 				    open(tracing_enabled_file, O_WRONLY);
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index f3cddf8545757..093f3c473f0a1 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -170,7 +170,7 @@ void *semathread(void *param)
 			if (par->tracelimit && par->maxdiff > par->tracelimit) {
 				char tracing_enabled_file[MAX_PATH];
=20
-				strcpy(tracing_enabled_file, get_debugfileprefix());
+				strcpy(tracing_enabled_file, get_tracefs_prefix());
 				strcat(tracing_enabled_file, "tracing_on");
 				int tracing_enabled =3D
 				    open(tracing_enabled_file, O_WRONLY);
--=20
2.51.0

