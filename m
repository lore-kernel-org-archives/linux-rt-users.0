Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748402FCE2A
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635720; cv=none; b=LG96PTtGpI4gRXDOcT710QLV8ByIb+5gSVZmKF48hBUEd6kcuOHD/1iCrlJ+JkROuH0UfdBpA2CHC9H4NKTuuPJeSzIs7WRk3Rc7/J1tl6FoVCje2AxtYI3j7eBMCNdrhZCPBcDz/PAoMsDwRQJAd2/pUdYq+u1Beuj6rYYoo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635720; c=relaxed/simple;
	bh=0ZsNt2EhcFut+KWG/5yk0Mzrke0cKHSyW/Z/MON9ir4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG6Q7oQ6ekkYKJfCg0Y5sT4FPVPfYc7PsGwcQAH8QqzUUsdzz/laITdMYuzmpe3KqpLqYjI+GphgCTqjojnTDHBaANKHXfD+C8yeCGxiaXi2mUG8Rm8Is9Y2JPtPSWaaPoz4Iu0avoZU6v8SrqqVsOt3PfWaa8NYZWMjW4MCtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iVRpwkU+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oH+UD5ab; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVRpwkU+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oH+UD5ab"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WX7FnrGPicYZfQVYhIJUnU1ZusBQzfKCHxqfym9r5Sw=;
	b=iVRpwkU+kNmcfDrn0vWOltYv2FryFV5K7uFs56PHr5Y+S0Tgr3xrcA5ov84XtVvAig8UQ9
	h8SiAENl75R2K0xyWLeuYaMGSJyiiuvWsDPsl2MI0NJ/HqntC0bakGLN22vqjSh/n+J5JQ
	89IdSAAsa1qEjQncf8Rq/yjmBpZYjMgaASRmEQFVqD1BcayIlGKCO9K/OXy4sMfJzSqj9x
	57EbPOcbFFV0EzDxoAHrasSxDgb4+yAmqfqcdoRPJMuQ1YtbfVM1W4fKCLMEKBTPn0prfz
	r1FzYnEXzwv2Ao23UFoLkIapetUazGroruhDiP9b51TG5R1ytDpWDAjGTA4rAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WX7FnrGPicYZfQVYhIJUnU1ZusBQzfKCHxqfym9r5Sw=;
	b=oH+UD5abQkSf8kIkJa2wLMLnFRtC0dlqFiA0/wPHABPPi5IbXV5Yut/j7HKzb5o7FZXcZj
	BiGViN+c5L8x4rCQ==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 20/28] cyclictest.8: Group tracing options
Date: Fri,  4 Jul 2025 15:27:13 +0200
Message-ID: <20250704132721.13325-21-darwi@linutronix.de>
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

       -b, --breaktrace=USEC
       --tracemark

into their own group.  Adjust the Synopsis accordingly as well.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 90a3e08..964996f 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -37,6 +37,7 @@ cyclictest \- High resolution test program
 .RB [ \-\-priospread ]
 .RB [ \-b\~\c
 .IR break\-usec ]
+.RB [ \-\-tracemark ]
 .RB [ \-D\~\c
 .IR duration\-mhd ]
 .RB [ \-f\~\c
@@ -59,7 +60,6 @@ cyclictest \- High resolution test program
 .IR num\-nodes ]
 .RB [ \-\-dbg_cyclictest ]
 .RB [ \-\-smi ]
-.RB [ \-\-tracemark ]
 .YS
 .
 .SY cyclictest
@@ -186,13 +186,19 @@ v1, PROC-SET, if specified, must be a single CPU number.
 .B \-m, \-\-mlockall
 Lock current and future memory allocations to prevent being paged out
 .
-.SS "Other options"
+.SS "Tracing options"
 .
 .TP
 .B \-b, \-\-breaktrace=USEC
 Send break trace command when latency > USEC
 .
 .TP
+.B \-\-tracemark
+write a trace mark when \-b latency is exceeded.
+.
+.SS "Other options"
+.
+.TP
 .B \-D, \-\-duration=TIME
 Specify a length for the test run.
 .br
@@ -262,10 +268,6 @@ The default is 1024 if not specified.
 Enable SMI count/detection on processors with SMI count support.
 .
 .TP
-.B \-\-tracemark
-write a trace mark when \-b latency is exceeded.
-.
-.TP
 .B \-u, \-\-unbuffered
 force unbuffered output for live processing
 .
-- 
2.49.0

