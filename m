Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A12FCE16
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635711; cv=none; b=HgKsR3gXsEO/Ee+fvoECHv0UmmaLYeUSXRW5Asf59DYfb3d/o8cdXETMzft/rZZjf3/DwI9sfXZbDd53LNU6Ifyc74zsIaAMeumIFGPjjvpfEXlG75CPUPgVRrKZpvq+vbYSP72qn9jnXUOKVHQisaVyQsriqWqDYZc6sQklZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635711; c=relaxed/simple;
	bh=C+Z0Yct8LTMtOjBi/IHcppm7CPJxUjgRcotdGkZ1axw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwPhXxByc2/InoO1pHWY00PYvEEIpYh+q9qwYc784RVgVrodwwkMM+v/ZKQXJo4HIVixWrJ6qx6jb77jU5eRw3aaossqdabC4iu1GfH9PVm9Hz+D314NV9HvNZ9LmRFEfSqR/7QXlLgwe1hlxits4VdePCogOYyjhIEYWS1eUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LCWIVefA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F8Wm0RGr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LCWIVefA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F8Wm0RGr"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUSK+L/SNwyJa3tbjaNZBBiY8JO8OAJnJnDzZr3Ukgk=;
	b=LCWIVefAM8QNBIk54XdbPQruHfmF93Sq9AGK1svlJmcCmD/+qhUyEMhrV6KGD9To4R1mZp
	H/YIhQAOTLdTmBiFrRQXH5WrfGyH8KNR9Aki/1NgBRvl63c67AtDq4aU9Rn7U9+MQaX9t5
	zdfS9FtqdnXTp8ohPoGnlWk3PWhEMTZa/wprzH2ybIfgBtlyuUMhZAUxiLVYahihAJT3Xr
	h3BJUVjhBrrRMIQcHOPcQL71vZ4sVeo3xhQnHhTqfFUcG11XrHUf0auulEPmu3DwTu5VMp
	CK0qqjEH3eQveXknIJDWrIhjkJ6v1ZhhOQ25cLyMnwrlzhmx79wx2JvC2mj0Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUSK+L/SNwyJa3tbjaNZBBiY8JO8OAJnJnDzZr3Ukgk=;
	b=F8Wm0RGrbvTRnaN9yXesooZ8kqxbQLOdslTbupNzi+IFOkmWQI/Qd7bC5RmJE4GBQ1H1QX
	ZnmbSRRd6D0Qt7Bg==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 17/28] cyclictest.8: Group SMP-related options
Date: Fri,  4 Jul 2025 15:27:10 +0200
Message-ID: <20250704132721.13325-18-darwi@linutronix.de>
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

Put the cyclictest's SMP-related options:

       -S, --smp
       -t, --threads[=NUM]
       --mainaffinity=CPUSET
       -a, --affinity[=PROC-SET]

into their own group.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 46 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 6ab3b19..7fc0420 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -24,6 +24,10 @@ cyclictest \- High resolution test program
 .IR wakeup\-usec ]
 .RB [ \-A\~\c
 .IR alignment\-usec ]
+.RB [ \-t\~\c
+.IR num\-threads ]
+.RB [ \-\-mainaffinity\~\c
+.IR proc-set ]
 .RB [ \-a\~\c
 .IR proc\-set ]
 .RB [ \-b\~\c
@@ -42,14 +46,10 @@ cyclictest \- High resolution test program
 .IR oscope\-red ]
 .RB [ \-p\~\c
 .IR thread\-prio ]
-.RB [ \-t\~\c
-.IR num\-threads ]
 .RB [ \-\-histfile\~\c
 .IR file\-path ]
 .RB [ \-\-json\~\c
 .IR file\-path ]
-.RB [ \-\-mainaffinity\~\c
-.IR proc-set ]
 .RB [ \-\-policy\~\c
 .IR threads\-sched\-policy ]
 .RB [ \-\-spike\~\c
@@ -146,7 +146,24 @@ align thread wakeups to the next full second and apply the optional offset.
 .B \-A, \-\-align=USEC
 Align thread wakeups to a specific offset in microseconds
 .
-.SS "Other options"
+.SS "SMP-related options"
+.
+.TP
+.B \\-S, \-\-smp
+Set options for standard testing on SMP systems. Equivalent to using the
+options: "\-t \-a" as well keeping any specified priority equal across all
+threads
+.
+.TP
+.B \-t, \-\-threads[=NUM]
+Set the number of test threads (default is 1). Create NUM test threads. If
+NUM is not specified, NUM is set to the number of available CPUs. See \-d,
+\-i and \-p for further information.
+.
+.TP
+.B \-\-mainaffinity=CPUSET
+Run the main thread on CPU #N. This only affects the main thread and not
+the measurement threads
 .
 .TP
 .B \-a, \-\-affinity[=PROC-SET]
@@ -163,6 +180,8 @@ field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU
 sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
 v1, PROC-SET, if specified, must be a single CPU number.
 .
+.SS "Other options"
+.
 .TP
 .B \-b, \-\-breaktrace=USEC
 Send break trace command when latency > USEC
@@ -204,11 +223,6 @@ for automated tests with a given number of test cycles. Cyclictest is
 stopped once the number of timer intervals has been reached.
 .
 .TP
-.B \-\-mainaffinity=CPUSET
-Run the main thread on CPU #N. This only affects the main thread and not
-the measurement threads
-.
-.TP
 .B \-m, \-\-mlockall
 Lock current and future memory allocations to prevent being paged out
 .
@@ -247,12 +261,6 @@ Print a summary only on exit. Useful for automated tests, where only the
 summary output needs to be captured.
 .
 .TP
-.B \\-S, \-\-smp
-Set options for standard testing on SMP systems. Equivalent to using the
-options: "\-t \-a" as well keeping any specified priority equal across all
-threads
-.
-.TP
 .B \-\-spike=<trigger>
 record all spikes > trigger
 .
@@ -267,12 +275,6 @@ The default is 1024 if not specified.
 Enable SMI count/detection on processors with SMI count support.
 .
 .TP
-.B \-t, \-\-threads[=NUM]
-Set the number of test threads (default is 1). Create NUM test threads. If
-NUM is not specified, NUM is set to the number of available CPUs. See \-d,
-\-i and \-p for further information.
-.
-.TP
 .B \-\-tracemark
 write a trace mark when \-b latency is exceeded.
 .
-- 
2.49.0

