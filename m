Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613C2FBFFB
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635705; cv=none; b=C6FzbdQ8vY927OLf9mwSTDI6V7B/2e5iVrNbTdAueuSejn6cHql6pad8MjgPdmXyfBYD66ZlaJlJXrFjUn6oOsWPeaQDynIDT2fHTUL3Bxp5jfK7gsRfU3YAkie4fjW+jc0PZeLMdIePeEYxEAITm2R0M+yYzVzn3iIbLeh3kH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635705; c=relaxed/simple;
	bh=7905xCi3cPOna5KwTVKHj192mNgJBfbLg0atzR829yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9Ri/KolJaXwWuezrCovmbxdwzZXc94limyuBsUoSAx4URTfrx2uQiYUYJcm313FDn5oTozmAWAb9N68rSscdXChwuITYr6eLMdsnPAgj7tkhbtILYsUPNRHo/XlzXI+26WdLAIykPgigDz5TcAqpgWmxU0gjpY8A5AjJiBPhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwcCla5e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=04T/ZUx+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwcCla5e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="04T/ZUx+"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdPRdLHk93dUzjOBzAjoO9tB8Shb3zo38bkD07ul6A=;
	b=zwcCla5el/JcRVp2zGcJFaycFVYpEo/J+Gb+oZvl2xKkTEGCVTCZ62TmgPwAoyGyzeZijA
	NyLZXCIupngzWTIKDW0B90PmLoprU0J5uC98zzbmTiL9qOi14T/uUP0KtRE27OidU+ls5C
	9kVH0DwxfIBXUuVlWIqtGhKFDiHSkWeO88N5JEfE1X7GnLuEh1uAWihM0WZCnH0iillHJM
	+trst8GAkYV1vSO03dMKFSyMLW1C7GJBg2y/ceocf4CY9QLqrYNyip7z8BH45TzlIM9oPO
	MLr2NLe40txh9sQDMpGxnaD6GXiXiO/hElaLILTSOvlcWWtow/t0N+xUUFYBPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdPRdLHk93dUzjOBzAjoO9tB8Shb3zo38bkD07ul6A=;
	b=04T/ZUx+3nWLxLpMe9GHBKAN+M9pHDCG+X/AhlDrzSYeVzx0wk8QwbpbCrtkn9DVSDQVwD
	jXQnBC5NhBCJ6BCA==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 16/28] cyclictest.8: Group thread wakeup timing options
Date: Fri,  4 Jul 2025 15:27:09 +0200
Message-ID: <20250704132721.13325-17-darwi@linutronix.de>
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

Put the cyclictest's thread-wakeup timing options:

       -d, --distance=DIST
       -i, --interval=INTV
       --secaligned [USEC]
       -A, --align=USEC

into their own group.  Adjust the Synopsis accordingly as well.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 52 +++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index eb7d713..6ab3b19 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -16,14 +16,18 @@ cyclictest \- High resolution test program
 .IR idle-state-num ]
 .RB [ \-c\~\c
 .IR clock\-type ]
-.RB [ \-a\~\c
-.IR proc\-set ]
+.RB [ \-d\~\c
+.IR distance\-usec ]
+.RB [ \-i\~\c
+.IR interval\-usec ]
+.RB [ \-\-secaligned\~\c
+.IR wakeup\-usec ]
 .RB [ \-A\~\c
 .IR alignment\-usec ]
+.RB [ \-a\~\c
+.IR proc\-set ]
 .RB [ \-b\~\c
 .IR break\-usec ]
-.RB [ \-d\~\c
-.IR distance\-usec ]
 .RB [ \-D\~\c
 .IR duration\-mhd ]
 .RB [ \-f\~\c
@@ -32,8 +36,6 @@ cyclictest \- High resolution test program
 .IR max\-latency\-usec ]
 .RB [ \-H\~\c
 .IR max\-latency\-usec ]
-.RB [ \-i\~\c
-.IR interval\-usec ]
 .RB [ \-l\~\c
 .IR num\-loops ]
 .RB [ \-o\~\c
@@ -50,8 +52,6 @@ cyclictest \- High resolution test program
 .IR proc-set ]
 .RB [ \-\-policy\~\c
 .IR threads\-sched\-policy ]
-.RB [ \-\-secaligned\~\c
-.IR wakeup\-usec ]
 .RB [ \-\-spike\~\c
 .IR trigger\-point-usec ]
 .RB [ \-\-spike\-nodes\~\c
@@ -127,6 +127,25 @@ not be used for reproducible tests.
 Check clock resolution, calling clock_gettime() many times. List of
 lock_gettime() values will be reported with -X
 .
+.SS "Thread-waekup timing options"
+.
+.TP
+.B \-d, \-\-distance=DIST
+Distance of thread intervals in us, default = 500
+.
+.TP
+.B \-i, \-\-interval=INTV
+Set the base interval of the thread(s) in microseconds (default is
+1000us). This sets the interval of the first thread. See also \-d.
+.
+.TP
+.B \-\-secaligned [USEC]
+align thread wakeups to the next full second and apply the optional offset.
+.
+.TP
+.B \-A, \-\-align=USEC
+Align thread wakeups to a specific offset in microseconds
+.
 .SS "Other options"
 .
 .TP
@@ -145,18 +164,10 @@ sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
 v1, PROC-SET, if specified, must be a single CPU number.
 .
 .TP
-.B \-A, \-\-align=USEC
-Align thread wakeups to a specific offset in microseconds
-.
-.TP
 .B \-b, \-\-breaktrace=USEC
 Send break trace command when latency > USEC
 .
 .TP
-.B \-d, \-\-distance=DIST
-Distance of thread intervals in us, default = 500
-.
-.TP
 .B \-D, \-\-duration=TIME
 Specify a length for the test run.
 .br
@@ -183,11 +194,6 @@ runs a single thread only, the -H option is equivalent to -h.
 Dump the latency histogram to <path> instead of stdout.
 .
 .TP
-.B \-i, \-\-interval=INTV
-Set the base interval of the thread(s) in microseconds (default is
-1000us). This sets the interval of the first thread. See also \-d.
-.
-.TP
 .B \-\-json=FILENAME
 Write final results into FILENAME, JSON formatted.
 .
@@ -241,10 +247,6 @@ Print a summary only on exit. Useful for automated tests, where only the
 summary output needs to be captured.
 .
 .TP
-.B \-\-secaligned [USEC]
-align thread wakeups to the next full second and apply the optional offset.
-.
-.TP
 .B \\-S, \-\-smp
 Set options for standard testing on SMP systems. Equivalent to using the
 options: "\-t \-a" as well keeping any specified priority equal across all
-- 
2.49.0

