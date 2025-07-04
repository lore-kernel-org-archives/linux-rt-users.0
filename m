Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC352FC000
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635697; cv=none; b=M6edhl9q48jpQSLKbeeKVCEwqhS5ZgIJrSWXiZvS9pDMWj2LTW60eTah9sqcZAn58mU7jobmO8ykjqMP4XgKvyptvWqp5E6IDcDqS33gPlrMG1kFyIWPX4zfW1K7zSNkO+6Ic1C1grWVJ4AU9AGcBfEOWACgA7eqDXojaYVXoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635697; c=relaxed/simple;
	bh=psX39e/q82R9kap+cyYkKbUmqKVYRhJEfyXcWtmiz28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiGcbOiz2SFLQfq0wU+Ts0m+AlmXmVbtu47tWqULHNjAL926DLaJ7pwRazi/KoMajMBIQvQK3X9Ujyht3I63t3Tm6GnCPOBVjTdOQSJr/+tGlGp8XN0bAGBMJv/aYPcGoWdoD9cEqf+vKjspG6i1oPafsubUq0E6iIOklnl3DBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dBOqhVqY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cNxh9Fvw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dBOqhVqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cNxh9Fvw"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYDts4LUGXGgVvRCYB+voQQgTY2oJLNF0k24J5yDsjA=;
	b=dBOqhVqYlOiL5RAwg/DmiZ55RGzhpjbQOYXxzD8Wa9ZUd7UO3XWh9J6/56AX2axJ+V5lhK
	oMfUH0ZXxIdn9DGoMFzmSELhmDGROyAkXrn5fBcI0zuFJc8WCGaZMAlaV9r9Gp3Og552YP
	cCudnbUtdXs5lYWyTSWGQizF1vWEtMN7xrHq1k8W2XPXd3xPN+TNhrlVFlpAOkU9NWIiRq
	ZxlWO0Zh9sIIP71QxmVUKWBW4OXU2BT2szpHEnplGpAO7i64Q04h56wfoTFLXqorHOsCp4
	2I7jLfmDn/b58cH5N8FinWBarKcc9vBrCAwWtdB8ffCpur8htOagKm+mDpgvIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYDts4LUGXGgVvRCYB+voQQgTY2oJLNF0k24J5yDsjA=;
	b=cNxh9FvwXvzLGOMcDZ0bMpx/SnbgrImz5kXoOgWfm3MCBWzc3dpW4YsFQ0W/aAKZhvg7SU
	2xUlNzBMZugKSCBw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 14/28] cyclictest.8: Group system-altering options
Date: Fri,  4 Jul 2025 15:27:07 +0200
Message-ID: <20250704132721.13325-15-darwi@linutronix.de>
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

Put the cyclictest's system-altering options:

       --default-system
       --latency=PM_QOS
       --deepest-idle-state=n
       --laptop

into their own group.  Adjust the Synopsis accordingly as well.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 58 ++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 1fd550f..0bc2fc1 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -9,6 +9,11 @@ cyclictest \- High resolution test program
 .
 .SY cyclictest
 .RB [ \-mMNqrRsSuvx ]
+.RB [ \-\-default\-system ]
+.RB [ \-\-latency\~\c
+.IR pm\-c\-state ]
+.RB [ \-\-deepest\-idle\-state\~\c
+.IR idle-state-num ]
 .RB [ \-a\~\c
 .IR proc\-set ]
 .RB [ \-A\~\c
@@ -37,14 +42,10 @@ cyclictest \- High resolution test program
 .IR thread\-prio ]
 .RB [ \-t\~\c
 .IR num\-threads ]
-.RB [ \-\-deepest\-idle\-state\~\c
-.IR idle-state-num ]
 .RB [ \-\-histfile\~\c
 .IR file\-path ]
 .RB [ \-\-json\~\c
 .IR file\-path ]
-.RB [ \-\-latency\~\c
-.IR pm\-c\-state ]
 .RB [ \-\-mainaffinity\~\c
 .IR proc-set ]
 .RB [ \-\-policy\~\c
@@ -56,7 +57,6 @@ cyclictest \- High resolution test program
 .RB [ \-\-spike\-nodes\~\c
 .IR num\-nodes ]
 .RB [ \-\-dbg_cyclictest ]
-.RB [ \-\-default\-system ]
 .RB [ \-\-priospread ]
 .RB [ \-\-smi ]
 .RB [ \-\-tracemark ]
@@ -71,6 +71,32 @@ cyclictest \- High resolution test program
 .B \-\-help
 display a usage message and exit.
 .
+.SS "System-altering options"
+.
+.TP
+.B \-\-default\-system
+Don't attempt to tune the system from cyclictest. Power management is not
+suppressed. This might give poorer results, but will allow you to discover
+if you need to tune the system.
+.
+.TP
+.B \-\-latency=PM_Q0S
+power management latency target value. This value is written to
+/dev/cpu_dma_latency and affects c-states. The default is 0
+.
+.TP
+.B \-\-deepest\-idle\-state=n
+Reduce exit from idle latency by limiting idle state up to n on used cpus
+(-1 disables all idle states). Power management is not suppresed on other
+cpus.
+.
+.TP
+.B \-\-laptop
+Save battery when running cyclictest. This will give you poorer realtime
+results, but will not drain your battery so quickly.
+.
+.SS "Other options"
+.
 .TP
 .B \-a, \-\-affinity[=PROC-SET]
 Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
@@ -103,18 +129,6 @@ select clock
 1 = CLOCK_REALTIME
 .
 .TP
-.B \-\-deepest\-idle\-state=n
-Reduce exit from idle latency by limiting idle state up to n on used cpus
-(-1 disables all idle states). Power management is not suppresed on other
-cpus.
-.
-.TP
-.B \-\-default\-system
-Don't attempt to tune the system from cyclictest. Power management is not
-suppressed. This might give poorer results, but will allow you to discover
-if you need to tune the system.
-.
-.TP
 .B \-d, \-\-distance=DIST
 Distance of thread intervals in us, default = 500
 .
@@ -154,16 +168,6 @@ Set the base interval of the thread(s) in microseconds (default is
 Write final results into FILENAME, JSON formatted.
 .
 .TP
-.B \-\-laptop
-Save battery when running cyclictest. This will give you poorer realtime
-results, but will not drain your battery so quickly.
-.
-.TP
-.B \-\-latency=PM_Q0S
-power management latency target value. This value is written to
-/dev/cpu_dma_latency and affects c-states. The default is 0
-.
-.TP
 .B \-l, \-\-loops=LOOPS
 Set the number of loops. The default is 0 (endless). This option is useful
 for automated tests with a given number of test cycles. Cyclictest is
-- 
2.49.0

