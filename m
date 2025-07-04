Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EF30748B
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635726; cv=none; b=IduqawHnI4nDYp3qdPH5OmWfNh6dMKv7eLm5E5Aui8dN6hIqSjH0CUNbbDHivIJJb1xBsjaaTyzBTa1vI0JYut1V5RYoPc8wsn3iu0BzGOm0qdvOGGqzNFI/JDcqwtIMRLdZNbcty9JZsb1adJQNz0iTVVyg+MzQhp0E6sDBDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635726; c=relaxed/simple;
	bh=EWwfYOw4JFQcts3mOs3YJWVg4VHX9zEVgoV+QwJ7130=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV7BMhmr8QznqoaFtca1JITMwPTCxkkJpYO6k0ipz+oiVhFN3TzxvqW5bqcCDC+rW9r7wJOHceJzeREr5DVAmukVjN8ydzb08LKfV02mEgmDPNo8nwkbSkD2TjcZfdEyRaVyrdBFFZaUabDAk5Vmcwc8s5v4aiaylbHywoc67v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jz0O0AuG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vTvydmxM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jz0O0AuG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vTvydmxM"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkGll7rmIeHL5kX4W4k6lkJDkNJg7TOOkO02Rjw0mo4=;
	b=jz0O0AuGlWcaqh6Dm59xKD5bAF+i5RtGdV1R0O1FCrSZvHNKWI7C8FoTUJLZcgAgYLcnvy
	4QdpoLA9h04lcfjIuPubTLxpu3ax9h1Si+/fcj/zYENqbNupoKcZhRX0UDFeqG+IW0+aZP
	9d3AMNI+9X1ZguQwa3CasMP83lSAHABi3xkx+r7nnx5OrG/7a2lghjPNCJMPQFwtR0yZMO
	XFhC/Z2+FYJVOaRVGpXcwS4zuLVl1vNj+QKa2X8HOdayQqeNjbXJ//stMkKuymeyu17A2v
	xWRgiDApFu1B+mB10bQF2UAMqIEUStE+wKrTFiX/zMYUvqmp9ttF6ZwIv9um0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkGll7rmIeHL5kX4W4k6lkJDkNJg7TOOkO02Rjw0mo4=;
	b=vTvydmxMsbnd/5zdmt8zUYi7NawAJIUJ/cSSwlX4Dkdp9wWRg86pWvq6qdot8xU8HvmQTl
	KWUlqOxdoI9tQoAw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 22/28] cyclictest.8: Group output options
Date: Fri,  4 Jul 2025 15:27:15 +0200
Message-ID: <20250704132721.13325-23-darwi@linutronix.de>
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

Put the cyclictest's output options:

       --dbg_cyclictest
       -o, --oscope=RED
       -F, --fifo=<path>
       -h, --histogram=US
       -H, --histofall=MAXLATENCYINUS
       --spike=<trigger>
       --spike-nodes=[num of nodes]
        --histfile=<path>
       --json=FILENAME
       -M, --refresh_on_max
       -N, --nsecs
       -q, --quiet
       -u, --unbuffered
       -v, --verbose

into their own group.  Adjust the Synopsis accordingly as well.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 58 +++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index c2c963c..ca75884 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -42,23 +42,23 @@ cyclictest \- High resolution test program
 .IR duration\-mhd ]
 .RB [ \-l\~\c
 .IR num\-loops ]
+.RB [ \-\-dbg_cyclictest ]
+.RB [ \-o\~\c
+.IR oscope\-red ]
 .RB [ \-f\~\c
 .IR fifo\-path ]
 .RB [ \-h\~\c
 .IR max\-latency\-usec ]
 .RB [ \-H\~\c
 .IR max\-latency\-usec ]
-.RB [ \-o\~\c
-.IR oscope\-red ]
-.RB [ \-\-histfile\~\c
-.IR file\-path ]
-.RB [ \-\-json\~\c
-.IR file\-path ]
 .RB [ \-\-spike\~\c
 .IR trigger\-point-usec ]
 .RB [ \-\-spike\-nodes\~\c
 .IR num\-nodes ]
-.RB [ \-\-dbg_cyclictest ]
+.RB [ \-\-histfile\~\c
+.IR file\-path ]
+.RB [ \-\-json\~\c
+.IR file\-path ]
 .RB [ \-\-smi ]
 .YS
 .
@@ -210,7 +210,15 @@ Set the number of loops. The default is 0 (endless). This option is useful
 for automated tests with a given number of test cycles. Cyclictest is
 stopped once the number of timer intervals has been reached.
 .
-.SS "Other options"
+.SS "Output options"
+.
+.TP
+.B \-\-dbg_cyclictest
+Print info userful for debugging cyclictest
+.
+.TP
+.B \-o, \-\-oscope=RED
+Oscilloscope mode, reduce verbose output by RED.
 .
 .TP
 .B \-F, \-\-fifo=<path>
@@ -229,6 +237,16 @@ right that contains summary data of all thread histograms. If cyclictest
 runs a single thread only, the -H option is equivalent to -h.
 .
 .TP
+.B \-\-spike=<trigger>
+record all spikes > trigger
+.
+.TP
+.B \-\-spike-nodes=[num of nodes]
+These are the maximum number of spikes we can record.
+.br
+The default is 1024 if not specified.
+.
+.TP
 .B \-\-histfile=<path>
 Dump the latency histogram to <path> instead of stdout.
 .
@@ -247,29 +265,11 @@ Show results in nanoseconds instead of microseconds, which is the default
 unit.
 .
 .TP
-.B \-o, \-\-oscope=RED
-Oscilloscope mode, reduce verbose output by RED.
-.
-.TP
 .B \-q, \-\-quiet
 Print a summary only on exit. Useful for automated tests, where only the
 summary output needs to be captured.
 .
 .TP
-.B \-\-spike=<trigger>
-record all spikes > trigger
-.
-.TP
-.B \-\-spike-nodes=[num of nodes]
-These are the maximum number of spikes we can record.
-.br
-The default is 1024 if not specified.
-.
-.TP
-.B \\-\-smi
-Enable SMI count/detection on processors with SMI count support.
-.
-.TP
 .B \-u, \-\-unbuffered
 force unbuffered output for live processing
 .
@@ -280,9 +280,11 @@ statistical information about the latency distribution. The output is sent
 to stdout. The output format is: "n:c:v", where n is the task number, c is
 the count, and v is the latency value in microseconds.
 .
+.SS "Other options"
+.
 .TP
-.B \-\-dbg_cyclictest
-Print info userful for debugging cyclictest
+.B \\-\-smi
+Enable SMI count/detection on processors with SMI count support.
 .
 .SH "See also"
 .BR numa (3),
-- 
2.49.0

