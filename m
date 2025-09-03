Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFEF2727E3
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898259; cv=none; b=g1+1ydHrAq9EwMrujmQrMC2szCe4lwbjZimL12KlkAa6R9iKQtR8UKaR3TQrRSRUxIsNDX468AAeHvQcXAXg4gBorntVsNEFxD5pvmkl+T6vpBe1J7YEePcJCLFF3kpbKHGDqNUtGe3nDYy8hu5n/iQqb3XYZqFCYmAb0Srpd4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898259; c=relaxed/simple;
	bh=dkCPKieOphAC18J7rfzpJ8KW4yWUoXdKrfLEgwN7qQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrBopPuYeC2MKYfZm0b2cvmG86PLuf62Z8PEtChNSBp7c2ggG1QL32e7VA4DFqwIEkWKUHYk49LbTpVapj9A9ZvW/QyCRwIt8Gnpm//HFMjy5LndbOI62o/T8CtMbwyufgghyN1fkk1Nlq5KxmfVW4oKZLqwvtvFs77r9cH6QXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EMf7mAnd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dFYBWoz9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMf7mAnd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dFYBWoz9"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XoBz7gwcwuBPv7K5XUz9FcPuIsW760tMOjPjwGxayik=;
	b=EMf7mAndSzFZGpH97PsaSGamMLXNuEqMpPW06kFI+Q5PAdez7vc/sDqEQoXSmO/Gpjvvvs
	pTn3EKPHorkNRSHmxUh3qgFcPcSlpwOCPpMA0uuJutgzwf0/X2JZ9ks5PylviTyXEywMOi
	WcRaB82t+njbd+l5HlRr9R1jSzcndMLYILTpLyjQHD7S+UZLIxJ1N53Dge3HT76QJAOh/o
	843insC86nwg8FzA3zmP9KCXCnl3nDlkfc18NV2M4N+0Tt2fmdmNp63Zj3o1cCW7HaDQNM
	zYTodCqsQB0BBErr/1hCncTf37oC71BB3HUxZQ43k3/g61TmSgML9PDFPTOJlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XoBz7gwcwuBPv7K5XUz9FcPuIsW760tMOjPjwGxayik=;
	b=dFYBWoz9hyJPHALxaaU+RlUE4muOokgfb/3YZv2B+eqZfThM/3ppAUcPA2GIcZLmQ0bq1O
	xsNINMLgQatGfpBA==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/10] sched_deadline: Use tracemark() from rt-utils instead cusstom implementation
Date: Wed,  3 Sep 2025 13:17:15 +0200
Message-ID: <20250903111717.1391196-9-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Somehow cyclicdeadline has its implementation to write to the
trace_marker and it also uses tracemark() from rt-utils.
Since now tracemark() is not stopping the trace anymore it can be used
as-is.
This has the advantage of removing some code and automaticly using
trace_marker from tracefs :)

Remove ftrace_write(), setup_ftrace_marker() and use tracemark()
instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 116 ++--------------------------
 1 file changed, 5 insertions(+), 111 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cycli=
cdeadline.c
index e2f827deb275a..82e640409ecef 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -72,8 +72,6 @@ struct sched_data {
 	int bufmsk;
=20
 	struct thread_stat stat;
-
-	char buff[BUFSIZ+1];
 };
=20
 static int shutdown;
@@ -92,7 +90,6 @@ static int cpu_count;
 static int all_cpus;
 static int nr_threads;
 static int use_nsecs;
-static int mark_fd;
 static int quiet;
 static char jsonfile[MAX_PATH];
=20
@@ -136,107 +133,6 @@ static const char *find_debugfs(void)
 	return debugfs;
 }
=20
-static int my_vsprintf(char *buf, int size, const char *fmt, va_list ap)
-{
-	const char *p;
-	char tmp[100];
-	char *s =3D buf;
-	char *end =3D buf + size;
-	char *str;
-	long long lng;
-	int l;
-	int i;
-
-	end[-1] =3D 0;
-
-	for (p =3D fmt; *p && s < end; p++) {
-		if (*p =3D=3D '%') {
-			l =3D 0;
- again:
-			p++;
-			switch (*p) {
-			case 's':
-				if (l)
-					fatal("Illegal print format l used with %%s\n");
-				str =3D va_arg(ap, char *);
-				l =3D strlen(str);
-				strncpy(s, str, end - s);
-				s +=3D l;
-				break;
-			case 'l':
-				l++;
-				goto again;
-			case 'd':
-				if (l =3D=3D 1) {
-					if (sizeof(long) =3D=3D 8)
-						l =3D 2;
-				}
-				if (l =3D=3D 2)
-					lng =3D va_arg(ap, long long);
-				else if (l > 2)
-					fatal("Illegal print format l=3D%d\n", l);
-				else
-					lng =3D va_arg(ap, int);
-				i =3D 0;
-				while (lng > 0) {
-					tmp[i++] =3D (lng % 10) + '0';
-					lng /=3D 10;
-				}
-				tmp[i] =3D 0;
-				l =3D strlen(tmp);
-				if (!l) {
-					*s++ =3D '0';
-				} else {
-					while (l)
-						*s++ =3D tmp[--l];
-				}
-				break;
-			default:
-				fatal("Illegal print format '%c'\n", *p);
-			}
-			continue;
-		}
-		*s++ =3D *p;
-	}
-
-	return s - buf;
-}
-
-static void ftrace_write(char *buf, const char *fmt, ...)
-{
-	va_list ap;
-	int n;
-
-	if (mark_fd < 0)
-		return;
-
-	va_start(ap, fmt);
-	n =3D my_vsprintf(buf, BUFSIZ, fmt, ap);
-	va_end(ap);
-
-	write(mark_fd, buf, n);
-}
-
-static void setup_ftrace_marker(void)
-{
-	struct stat st;
-	const char *debugfs =3D find_debugfs();
-	char files[strlen(debugfs) + strlen("/tracing/trace_marker") + 1];
-	int ret;
-
-	if (strlen(debugfs) =3D=3D 0)
-		return;
-
-	sprintf(files, "%s/tracing/trace_marker", debugfs);
-	ret =3D stat(files, &st);
-	if (ret >=3D 0)
-		goto found;
-	/* Do nothing if not mounted */
-	return;
-found:
-	mark_fd =3D open(files, O_WRONLY);
-}
-
 /*
  * Return true if file exists
  */
@@ -804,16 +700,15 @@ static u64 do_runtime(struct sched_data *sd, u64 peri=
od)
 		 * preempting us when we started. If that's the case then
 		 * adjust the current period.
 		 */
-		ftrace_write(sd->buff,
-			     "Adjusting period: now: %lld period: %lld delta:%lld%s\n",
-			     now, period, delta, delta > sd->deadline_us / 2 ?
-			     " HUGE ADJUSTMENT" : "");
+		tracemark("Adjusting period: now: %lld period: %lld delta:%lld%s\n",
+			  now, period, delta, delta > sd->deadline_us / 2 ?
+			  " HUGE ADJUSTMENT" : "");
 		period =3D now;
 		next_period =3D period + sd->deadline_us;
 	}
=20
-	ftrace_write(sd->buff, "start at %lld off=3D%lld (period=3D%lld next=3D%l=
ld)\n",
-		     now, now - period, period, next_period);
+	tracemark("start at %lld off=3D%lld (period=3D%lld next=3D%lld)\n",
+		  now, now - period, period, next_period);
=20
=20
 	diff =3D now - period;
@@ -1293,7 +1188,6 @@ int main(int argc, char **argv)
 	if (mlockall(MCL_CURRENT|MCL_FUTURE) =3D=3D -1)
 		warn("mlockall");
=20
-	setup_ftrace_marker();
 	if (tracelimit && trace_marker)
 		enable_trace_mark();
=20
--=20
2.51.0

