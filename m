Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9C24468A
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898256; cv=none; b=YqSqS8GjDyh3dMjJDlvmDugQGVpSTcMnZuR91E3F6DnkXLaGpuppk9cGVIDo1wNnK5gwm1AqLhBECQDmUPh+Bg+JEP8lq/r4DuYevmVIoWWEBkDNunNqM5e97sU63cFXay347Tg7SCgyyCLoA0tGAsVvX696RN99+rT6mpWTL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898256; c=relaxed/simple;
	bh=five72JiftwGmoEeFj7mcQ++K1zpyBGvm5sUEZqxeOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JI2Ox2TKTw2hc5n239JyJLgQMrpmBmq51XXg9taKlxVTV20bDt1Ul+tcEzI0QnnM2Zp/hWp+YLATpluxWuSYe3pAKhaChtQY39jHk6avkQklMqrVwyTJ0eyXXmZRP13DaX1MDCehgHbu5nqcYTcFcXrl2W+rXtY4P6tBGR0C/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nnY8ntBy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tsnfXPWg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nnY8ntBy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tsnfXPWg"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVFjmsoEAV6YDtvrHxHDaA0/+GofqzfNHHlGN0OV9oA=;
	b=nnY8ntBy3JMUovPlro4n2NJ3G0Zdq7Ns3D7hcy8MJjUMpAl/XIaZV95VSC3npt+ZdQciNg
	QIdaTAMqrDgKUFRffXJI5QwhTKJxtqojL166dFU6yBNEcisG500ZfQ4mx0SWbO+HHw6r6O
	f2Vzx3pKf89zXUwNyh5MaVT9CgLcw9EoUE/Yc8Rr+0kEVOzDdfA2y54B/DfFQwFu63+/hB
	DmFK/0lQHqV0YTo+f6MS1RN2AR+EWoKbk3ibQddwrHCmbxuZew40O0uSzf/Yiw8Yt69eAy
	GfVShzg7ZZHaEjRF9DKJ8i7Zz8aslao25gSLdlEXhGowwDYHuU8P/DEbH5Ei8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVFjmsoEAV6YDtvrHxHDaA0/+GofqzfNHHlGN0OV9oA=;
	b=tsnfXPWgX89U1DUNqyv4E3VHyWlScBdws6A7yYuePkGyX2VYtkaG+gRFUZlWmlvZwDlapc
	cxW524ERrJ2k1bCA==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/10] rt-utils: Remove mount_debugfs()
Date: Wed,  3 Sep 2025 13:17:09 +0200
Message-ID: <20250903111717.1391196-3-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The requirement to mount debugfs is very old. It originated from a time
where it was "fairly new" and was not mounted by distros at the time.
These days debugfs gets mounted during boot and more importantly the
tracing directory moved out over 10years ago.

Don't try to mount debugfs anymore.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/include/rt-utils.h |  1 -
 src/lib/rt-utils.c     | 29 -----------------------------
 2 files changed, 30 deletions(-)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index f6b3fede06f7b..95964f70a6310 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -12,7 +12,6 @@
=20
 int check_privs(void);
 char *get_debugfileprefix(void);
-int mount_debugfs(char *);
 int get_tracers(char ***);
 int valid_tracer(char *);
=20
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 6bbd25a8ba53f..7e96950ef9887 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -99,32 +99,6 @@ char *get_debugfileprefix(void)
 	return debugfileprefix;
 }
=20
-int mount_debugfs(char *path)
-{
-	char *mountpoint =3D path;
-	char cmd[MAX_PATH];
-	char *prefix;
-	int ret;
-
-	/* if it's already mounted just return */
-	prefix =3D get_debugfileprefix();
-	if (strlen(prefix) !=3D 0) {
-		info(1, "debugfs mountpoint: %s\n", prefix);
-		return 0;
-	}
-	if (!mountpoint)
-		mountpoint =3D "/sys/kernel/debug";
-
-	sprintf(cmd, "mount -t debugfs debugfs %s", mountpoint);
-	ret =3D system(cmd);
-	if (ret !=3D 0) {
-		fprintf(stderr, "Error mounting debugfs at %s: %s\n",
-			mountpoint, strerror(errno));
-		return -1;
-	}
-	return 0;
-}
-
 static char **tracer_list;
 static char *tracer_buffer;
 static int num_tracers;
@@ -451,9 +425,6 @@ static int trace_file_exists(char *name)
=20
 static void debugfs_prepare(void)
 {
-	if (mount_debugfs(NULL))
-		fatal("could not mount debugfs");
-
 	fileprefix =3D get_debugfileprefix();
 	if (!trace_file_exists("tracing_enabled") &&
 	    !trace_file_exists("tracing_on"))
--=20
2.51.0

