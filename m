Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C45D2FCFC7
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635717; cv=none; b=c7FFWNl2WYJml1/sDNkbCtlhVFt3hCBl+rWRYYzfRDcEb09o8Bv2Vm+24sQjxcI0uLTWLKMdqUIBjQQw2waVMnCwTkslenSTRRGh2Wzd1kq7vIgWUmtlKBqKRpQ580SE69SvMOhsnswgFx7FTNs3epNLFo88T7I0KmbPziXIvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635717; c=relaxed/simple;
	bh=ZFOkCkdCfxc4CjypBiphxFFqljzGCPgF2/7k++RJdkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMnkNP0Sz29Mpyz6i99C8r0JdlSh35ddMngsr558+C6IAEax1qRunVWzoJME+G3FOgVf5h+/fKliXYkHAFeZs857AjbzCuXnsMGwfgYgGiibRBAEl8y5GQJ4cWFSWfAEOB/RCsDtC7DDU8bPkX0H7tyC0rXmntFe3mX7eofYMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r0zmxk8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r5urs5LZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r0zmxk8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r5urs5LZ"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKMUKSpbLd8m2gDwn8ecf5p71Yk5MuOm0rDGub+9740=;
	b=r0zmxk8iUemSBWcdvC17Wce8fUPIMbh/5mFcBK52nNkNxpTSrA7zWdxctbH/tWjX7quKWI
	WXEkDweZYKDmyhynC22R1h6ABryvRmMCjU1txNzN1keVFHFO+8otG2M+nec+OK5HcpBloT
	3L73YM6ecEeSlPlx9psXT6PIT5KILJNO68EzM1iQ3CSCbyZNOLLCAwGZ8stm/UkGbol8qc
	s6HUSbjEWEG/rKFL1ic/vSSiptM/ppulkx8gpc1FQkm1AFJ/pYmmOf4Wzu1JUydIhEMK+X
	wFl4UUIaWc8aBZHXq1+HsLI2ezlGvN7I5Eknxhypy/xWg6fHlrYbs8YIeMHKAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKMUKSpbLd8m2gDwn8ecf5p71Yk5MuOm0rDGub+9740=;
	b=r5urs5LZm6Jeub/n26bfyprwRaTelfwmvhEgd+TMRZcFcA7IIbBtpRXRvBM6d0eNZ5AyGD
	2ggQ2p95ELYS6eDA==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 19/28] cyclictest.8: Group thread priority options
Date: Fri,  4 Jul 2025 15:27:12 +0200
Message-ID: <20250704132721.13325-20-darwi@linutronix.de>
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

Put the cyclictest's thread priority options:

       --policy=NAME
       -p, --prio=PRIO
       --priospread

into their own group.  Adjust the Synopsis accordingly as well.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index a099416..90a3e08 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -30,6 +30,11 @@ cyclictest \- High resolution test program
 .IR proc-set ]
 .RB [ \-a\~\c
 .IR proc\-set ]
+.RB [ \-\-policy\~\c
+.IR threads\-sched\-policy ]
+.RB [ \-p\~\c
+.IR thread\-prio ]
+.RB [ \-\-priospread ]
 .RB [ \-b\~\c
 .IR break\-usec ]
 .RB [ \-D\~\c
@@ -44,20 +49,15 @@ cyclictest \- High resolution test program
 .IR num\-loops ]
 .RB [ \-o\~\c
 .IR oscope\-red ]
-.RB [ \-p\~\c
-.IR thread\-prio ]
 .RB [ \-\-histfile\~\c
 .IR file\-path ]
 .RB [ \-\-json\~\c
 .IR file\-path ]
-.RB [ \-\-policy\~\c
-.IR threads\-sched\-policy ]
 .RB [ \-\-spike\~\c
 .IR trigger\-point-usec ]
 .RB [ \-\-spike\-nodes\~\c
 .IR num\-nodes ]
 .RB [ \-\-dbg_cyclictest ]
-.RB [ \-\-priospread ]
 .RB [ \-\-smi ]
 .RB [ \-\-tracemark ]
 .YS
@@ -243,21 +243,6 @@ unit.
 Oscilloscope mode, reduce verbose output by RED.
 .
 .TP
-.B \-p, \-\-prio=PRIO
-Set the priority of the first thread. The given priority is set to the
-first test thread. Each further thread gets a lower priority:
-Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
-.
-.TP
-.B \-\-policy=NAME
-set the scheduler policy of the measurement threads where NAME is one of:
-other, normal, batch, idle, fifo, rr
-.
-.TP
-.B \-\-priospread
-spread priority levels starting at a specified value
-.
-.TP
 .B \-q, \-\-quiet
 Print a summary only on exit. Useful for automated tests, where only the
 summary output needs to be captured.
-- 
2.49.0

