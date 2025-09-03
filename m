Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9D2F9C29
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898258; cv=none; b=ApBorPuEB0dda/cUTBcSP2loQvRcBd7/LPuWvZKYb/Z6VnCZrxjFy2rtL/t0GIWFvVpUVWo6nroKSau67dUbzwOmP59mnJstqfffH2MZZoYrQoEyZonzFbiY8iQ4EG3OK5aYbOStzG0xBnV484CFtmAswLTYjvdledLZ4HmbF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898258; c=relaxed/simple;
	bh=smH7qb4a3x9PA6xXFQQ3xGpWB9QVMWpiyeI6fjRB44I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JftFzSXapJOXHp3l/Y3+87l60uDIuvAaCIbX8MQxNSv8P8LzsruS+1+RbRO/1mpFkWOmrQFqB3bv5JPyxi/iIvQNe8cdJTYrvIOXdVQw4xgYXwdj2ubkyaMc0af5TL+KTcTYXvOKIBDTfpRcN2q5GqXkJLMe60XAkNMNLsiUH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JK5saXlj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k4C6njOc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JK5saXlj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k4C6njOc"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TxChm2hWWnuYOqDZSu65+d0/5lhXqvEya4ECcD3F/M=;
	b=JK5saXlj4+KeF5TrY6A+LghqSWX/l4I00TKpBRIsL2BOuESNgq94TyyEOPw7Y3ELEBt16o
	MztI6HKragRmh8YUUIXsFjnlFCZIK2HEdh76N28il1AyK3S5TeqS2zNOLGyNdCyVIKdgLC
	5LfV4j4xSOmmZElw7Egk0jpsMwBrMILYsbQc67ansv4Cn6zdAHiJlj33Rg7tsl1rAGXtL4
	cDChpmbLgnslKgm6vn5cF3z5on+tkZmC4to4IqKPXEO4Y07kUJpcEM+o2ZFKJ2rokfivD+
	w9iklUvS54iEAS03B6zemAgqyYcXYFPQn4feH9OKotojTVKgQ6huh7p6P/KbAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TxChm2hWWnuYOqDZSu65+d0/5lhXqvEya4ECcD3F/M=;
	b=k4C6njOc5UvjH1bIK/kotg6mfotB2GUxcGRwXBzXziu7tiMM4RDHNJqKP734prykcZO1J9
	9Wq2Wrep0T6pthBg==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/10] rt-utils: Remove fileprefix.
Date: Wed,  3 Sep 2025 13:17:12 +0200
Message-ID: <20250903111717.1391196-6-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove fileprefix and use tracefs_prefix directly.
There is no need for having both.
Since sprintf() will complain that output buffer has the same size as
the first input buffer so it could write more bytes use snprintf() and
catch that possible overflow.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/lib/rt-utils.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 696bca2657d18..0e6e6056a4392 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -33,7 +33,6 @@
 #define  MAX_TS_SIZE 64
=20
 static char tracefs_prefix[MAX_PATH];
-static char *fileprefix;
 static int trace_fd =3D -1;
 static int tracemark_fd =3D -1;
 static __thread char tracebuf[TRACEBUFSIZ];
@@ -363,12 +362,17 @@ int parse_mem_string(char *str, uint64_t *val)
 static void open_tracemark_fd(void)
 {
 	char path[MAX_PATH];
+	int n;
=20
 	/*
 	 * open the tracemark file if it's not already open
 	 */
 	if (tracemark_fd < 0) {
-		sprintf(path, "%s/%s", fileprefix, "trace_marker");
+		n =3D snprintf(path, sizeof(path), "%s/%s", tracefs_prefix, "trace_marke=
r");
+		if (n >=3D sizeof(path)) {
+			warn("tracefs path too long\n");
+			return;
+		}
 		tracemark_fd =3D open(path, O_WRONLY);
 		if (tracemark_fd < 0) {
 			warn("unable to open trace_marker file: %s\n", path);
@@ -382,7 +386,11 @@ static void open_tracemark_fd(void)
 	 * if we hit a breaktrace threshold
 	 */
 	if (trace_fd < 0) {
-		sprintf(path, "%s/%s", fileprefix, "tracing_on");
+		n =3D snprintf(path, sizeof(path), "%s/%s", tracefs_prefix, "tracing_on"=
);
+		if (n >=3D sizeof(path)) {
+			warn("tracefs path too long\n");
+			return;
+		}
 		if ((trace_fd =3D open(path, O_WRONLY)) < 0)
 			warn("unable to open tracing_on file: %s\n", path);
 	}
@@ -408,7 +416,7 @@ static int trace_file_exists(char *name)
=20
 static void tracefs_prepare(void)
 {
-	fileprefix =3D get_tracefs_prefix();
+	get_tracefs_prefix();
 	if (!trace_file_exists("tracing_enabled") &&
 	    !trace_file_exists("tracing_on"))
 		warn("tracing_enabled or tracing_on not found\n"
--=20
2.51.0

