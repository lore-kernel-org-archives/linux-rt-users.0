Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3730206D
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635724; cv=none; b=K3CEePJXYCMeUMn8X0Et63WIIKB206B53wUiFksUJYpBnyh+/csfd/rZFQvRjHyIto2jZPazAILVCCZpxnFf9qDIf4NEpupbUB1zxBptPE/CeK8pJWM3htEk3KvIf2LxkRrJ/vT/ME2AiPko6hBp8t0KYfW7EajsZEi5XYtB7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635724; c=relaxed/simple;
	bh=u1XNmNNJI/Ix5eVRjfQClNmZUE7OrDfHMG9QcqRhwZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTXxHsDN6EQ5pyI0ql+bBEK925Pll9a6xjXfQu5eUoJ7idqmttpjBGZ3PyMEU0xYSuWrjGzW1T2LwZvu/gHIoBf3Cw3ObtuHoBoT8Pb1cFJQ86u9Dzn2NvbWTdLtBata0A8ImbchbB+cmENLc6EdYoMY3qsiB8zVBcfNLcLgXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jF6Y7lkJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KghPni3D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jF6Y7lkJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KghPni3D"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5V21gI0vhuC7EgGrbTV/ZpVxN0oEn1Q+efKoRZ45Yg=;
	b=jF6Y7lkJFqCt5tzwmT35ELjaXBv8byzRdiY7G19Pxr8O6dV0JciuC4Ue+6GeYG+Aju6ToT
	muPFr5QQTOG5jOD5Nv4/yp/iBQqwlwwvMWT2o/GcOp154veui0OOR6RWaYZj3FQdXxofXr
	wdQ0sNEtoMPp+5PbHcdpOZf+aBcEvsoFcd52HJE/EGXI1Fuj2JG/F+wCcytKCXJj+PMcoG
	EgyYcTP6OxFXjmg6dN+Z0GltYoPIquTi0Qi6ga4joPGaV0l+EmuoJQGMjIEQq/N7rBG7c/
	Q+c76KIHEci3Winy6d9ACfc7ZyHqbecC9QfffvcJl/lI0R4XCK20msDR3bE1BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5V21gI0vhuC7EgGrbTV/ZpVxN0oEn1Q+efKoRZ45Yg=;
	b=KghPni3DpfABFPce5JZVsHsrlxWvsFZm+0wF3jZ8Uh5mSFUoQhEQwVsJl653+vJ1I80HsW
	eg9P9YJXOGN+kODw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 21/28] cyclictest.8: Group test duration options
Date: Fri,  4 Jul 2025 15:27:14 +0200
Message-ID: <20250704132721.13325-22-darwi@linutronix.de>
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

       -D, --duration=TIME
       -l, --loops=LOOPS

into their own group.  Adjust the Synopsis accordingly as well.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 964996f..c2c963c 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -40,14 +40,14 @@ cyclictest \- High resolution test program
 .RB [ \-\-tracemark ]
 .RB [ \-D\~\c
 .IR duration\-mhd ]
+.RB [ \-l\~\c
+.IR num\-loops ]
 .RB [ \-f\~\c
 .IR fifo\-path ]
 .RB [ \-h\~\c
 .IR max\-latency\-usec ]
 .RB [ \-H\~\c
 .IR max\-latency\-usec ]
-.RB [ \-l\~\c
-.IR num\-loops ]
 .RB [ \-o\~\c
 .IR oscope\-red ]
 .RB [ \-\-histfile\~\c
@@ -196,7 +196,7 @@ Send break trace command when latency > USEC
 .B \-\-tracemark
 write a trace mark when \-b latency is exceeded.
 .
-.SS "Other options"
+.SS "Test-duration options"
 .
 .TP
 .B \-D, \-\-duration=TIME
@@ -205,6 +205,14 @@ Specify a length for the test run.
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .
 .TP
+.B \-l, \-\-loops=LOOPS
+Set the number of loops. The default is 0 (endless). This option is useful
+for automated tests with a given number of test cycles. Cyclictest is
+stopped once the number of timer intervals has been reached.
+.
+.SS "Other options"
+.
+.TP
 .B \-F, \-\-fifo=<path>
 Create a named pipe at path and write stats to it
 .
@@ -229,12 +237,6 @@ Dump the latency histogram to <path> instead of stdout.
 Write final results into FILENAME, JSON formatted.
 .
 .TP
-.B \-l, \-\-loops=LOOPS
-Set the number of loops. The default is 0 (endless). This option is useful
-for automated tests with a given number of test cycles. Cyclictest is
-stopped once the number of timer intervals has been reached.
-.
-.TP
 .B \\-M, \-\-refresh_on_max
 Delay updating the screen until a new max latency is hit. (useful for
 running cyclictest on low-bandwidth connections)
-- 
2.49.0

