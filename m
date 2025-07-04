Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA62F94B4
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635700; cv=none; b=d8LkdQPFn89p+tmC3k9aN7e3uiaOU1owSJ+jgbZk/BPGCHezXCqE+RdxfwW3lyfjuOs5Lu2FVf29SuJs6058yPIsI6h+//RrSwUzmCTCRHM54Qmfg7A7l8yw8TkC7dq0FlU4D7rSc2PEDa+C2TX35zxdNDlcQHeBX6ooWz41M7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635700; c=relaxed/simple;
	bh=e7g3cikeviLueEh3oFsvPaSt7YYPQKF23Pn5XFHnT9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AehsRdXexvyl9hh6ivEZSCf/14F3ejtNfX3W5n16+oIZOB/mPanzt/tZkLodyrjXGQDenPwuGz+J3CH1vLrgnNnMR1bacTS2c5C06C/AqS7xPdI9L42KY/h4enjj1njA16MdNSW9VMaUFIFVBYn8XI6cGfBR+fuPkwzwsU30ZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdHIOnfL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+f+hHg0x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdHIOnfL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+f+hHg0x"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQCq6ThfDh09QsQ6xW4htGNmVumKwIWwC92HhfAb7gA=;
	b=YdHIOnfLoUDb0oBe/X9K3rfRSZvv0ysJyU0RGxngwiyjlUBo2rn26foM23ZdRssvKbj0/q
	DO2gO/PhIlp0o1VSblwQ5/N0kV1aGCVnRWf/a/V4vyLnATz55EGk/2JC4+3+HTzPmSzk3A
	s642g0HrwZ+uWGcxMXj+vmvVdc/0Jf08JiBmkhyBDE3SjJITEYi0ri7ahtZwcWg5utD8M/
	5D69n39dQkLSiNErA/HpUU/+f0k2DMbPW2l9Lit0xCDQTORhgNla+QiDt5xs79ls196FWr
	wPf50f7kFPEvXGcVRWGKY3Fq38ozSv6OSwNMVv1hDDF6CNKfSaMwGeBm5+6tkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQCq6ThfDh09QsQ6xW4htGNmVumKwIWwC92HhfAb7gA=;
	b=+f+hHg0xH6v4n92xteGnce8kggqT2JbP3wH8UyBmhBl5Fx2QZ+mKxVnL8Xmk8YMSzYNLUl
	+t7sD3F6yViHq4Dw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 15/28] cyclictest.8: Group sleep-mechanism (clock) options
Date: Fri,  4 Jul 2025 15:27:08 +0200
Message-ID: <20250704132721.13325-16-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number and breadth of cyclictest's options is huge, and just
exploring them in sequence can get the manpage reader lost.

Put the cyclictest's sleep-mechanism related options:

       -c, --clock=CLOCK
       -x, --posix_timers
       -s, --system
       -r, --relative
       -R, --resolution

into their own group.  Adjust the Synopsis accordingly as well.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 66 +++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 0bc2fc1..eb7d713 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -14,14 +14,14 @@ cyclictest \- High resolution test program
 .IR pm\-c\-state ]
 .RB [ \-\-deepest\-idle\-state\~\c
 .IR idle-state-num ]
+.RB [ \-c\~\c
+.IR clock\-type ]
 .RB [ \-a\~\c
 .IR proc\-set ]
 .RB [ \-A\~\c
 .IR alignment\-usec ]
 .RB [ \-b\~\c
 .IR break\-usec ]
-.RB [ \-c\~\c
-.IR clock\-type ]
 .RB [ \-d\~\c
 .IR distance\-usec ]
 .RB [ \-D\~\c
@@ -95,6 +95,38 @@ cpus.
 Save battery when running cyclictest. This will give you poorer realtime
 results, but will not drain your battery so quickly.
 .
+.SS "Sleep-mechanism clock options"
+.
+.TP
+.B \-c, \-\-clock=CLOCK
+select clock
+.br
+0 = CLOCK_MONOTONIC (default)
+.br
+1 = CLOCK_REALTIME
+.
+.TP
+.B \-x, \-\-posix_timers
+Use POSIX timers instead of clock_nanosleep.
+.
+.TP
+.B \-s, \-\-system
+Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s
+can only be used with one thread because itimers are per process and not
+per thread. \-s uses the nanosleep syscall and is not restricted to one
+thread.
+.
+.TP
+.B \-r, \-\-relative
+Use relative timers instead of absolute. The default behaviour of the tests
+is to use absolute timers. This option is there for completeness and should
+not be used for reproducible tests.
+.
+.TP
+.B \-R, \-\-resolution
+Check clock resolution, calling clock_gettime() many times. List of
+lock_gettime() values will be reported with -X
+.
 .SS "Other options"
 .
 .TP
@@ -121,14 +153,6 @@ Align thread wakeups to a specific offset in microseconds
 Send break trace command when latency > USEC
 .
 .TP
-.B \-c, \-\-clock=CLOCK
-select clock
-.br
-0 = CLOCK_MONOTONIC (default)
-.br
-1 = CLOCK_REALTIME
-.
-.TP
 .B \-d, \-\-distance=DIST
 Distance of thread intervals in us, default = 500
 .
@@ -217,28 +241,10 @@ Print a summary only on exit. Useful for automated tests, where only the
 summary output needs to be captured.
 .
 .TP
-.B \-r, \-\-relative
-Use relative timers instead of absolute. The default behaviour of the tests
-is to use absolute timers. This option is there for completeness and should
-not be used for reproducible tests.
-.
-.TP
-.B \-R, \-\-resolution
-Check clock resolution, calling clock_gettime() many times. List of
-lock_gettime() values will be reported with -X
-.
-.TP
 .B \-\-secaligned [USEC]
 align thread wakeups to the next full second and apply the optional offset.
 .
 .TP
-.B \-s, \-\-system
-Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s
-can only be used with one thread because itimers are per process and not
-per thread. \-s uses the nanosleep syscall and is not restricted to one
-thread.
-.
-.TP
 .B \\-S, \-\-smp
 Set options for standard testing on SMP systems. Equivalent to using the
 options: "\-t \-a" as well keeping any specified priority equal across all
@@ -283,10 +289,6 @@ the count, and v is the latency value in microseconds.
 .B \-\-dbg_cyclictest
 Print info userful for debugging cyclictest
 .
-.TP
-.B \-x, \-\-posix_timers
-Use POSIX timers instead of clock_nanosleep.
-.
 .SH "See also"
 .BR numa (3),
 .BR numactl (8),
-- 
2.49.0

