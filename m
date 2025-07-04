Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36A2FBFF2
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635689; cv=none; b=QDWTwPhzUDwIdq/gvInv2zl02zhBhLYr1/4M5l5avX/KsYpopdSMb8fepi5LFcrFRnjOZE1hDNxvbykpmO9Zz94fgldtfkGq6oqMU2AWQKWABAUpixF0EdOBh9YoC9nlLLHhPGLcuM++53w9QJD2JV56nQouhJ3JGaL5NhbjfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635689; c=relaxed/simple;
	bh=17BSWVH+DsgrYtAkLSYIvjGIrjdWTsN70ceJXKTuQMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnPFtzwQ1FmA+kt16d43zN/cKYb2/srJ+hOYNR0uUXsQPJtLU9iTcNbTWNO5r/YTalpLZgTA5zGtxgHTirBppKRl9vTgFIkI4+qz/iIpus/hQx2fNhEht0gGyoo8KjfAdfCfOLDuVORvmH2VSVt8zO1uKJQn8AtNJqruszvlsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0pBF6pKp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kyhcL0B8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0pBF6pKp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kyhcL0B8"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv2NFVovEYTlnpoG7eo6OyWBPEupkJumXBGsNtNd/3M=;
	b=0pBF6pKpI/GXBpjK05c9mCNB3FhA2qhnI0X83DQpedmqDGVbiTpDLHLayOEo2Lpd1JW1CJ
	2vYVrJP8yMK1OoXPqvVRGHvnUI1RCHXWy5jAzyi2i0EnnNf8zdT5JopjdWtSx7oWOvAuBc
	qRQ6wLg1bedjR+r5c7k9UCXXmcFQsTx1rPnDJ2SEI5Z9dbzgkowoktH4SS2TOIQtqctSWh
	Qu7pqX2R4zsUiIxt6aaQu86U/2us7loW6c2cgR3nu6vqPscuggydO/EqDjqd/BzBnlXDEv
	t/ZJjYrFB1A+s2+gVIAN1ihihD5qhFhQ69DqQmXD2t/X2NCeawgHkSBiPL2a2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv2NFVovEYTlnpoG7eo6OyWBPEupkJumXBGsNtNd/3M=;
	b=kyhcL0B8m+GdHjB6vZ2b3R0miqq/8y7YZEXgmMZToE1M90EGoc3sQYGGvOYhSo1qRujkWi
	e46THZi2K3K7YLDg==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 11/28] cyclictest.8: Synopsis: Fix parameters list rendering
Date: Fri,  4 Jul 2025 15:27:04 +0200
Message-ID: <20250704132721.13325-12-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow groff_man_style(7) parameters documentation style.  Namely:

- Order cyclictest flags in the form -abcCeEgGijklNpRsStUVXzZ

- Present the flag and option names in bold to cue the user that they
  should be input literally.

- Use the non-breaking adjustable space escape sequence "\~" to prevent
  the line output from being broken within the option brackets.

- Use the output line continuation escape sequence "\c" to allow all
  three font styles to be set without breakable space among them.

- End the parameters list with .YS, the "End synopsis" macro.  It
  restores indentation, adjustment, and hyphenation to their previous
  state.

Beside just following the standards, this makes the groff rendering of
the cyclictest's parameter list way more legible and comprehensible.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 7f1bd39..f093677 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -7,9 +7,34 @@ cyclictest \- High resolution test program
 .
 .SH Synopsis
 .SY cyclictest
-.RI "[ \-fmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
-[\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
-[\-p " prio " ] [\-t " num " ] [\-D " time " ]"
+.RB [ \-fmMnqrsMv ]
+.RB [ \-a\~\c
+.IR proc ]
+.RB [ \-A\~\c
+.IR align ]
+.RB [ \-b\~\c
+.IR usec ]
+.RB [ \-c\~\c
+.IR clock ]
+.RB [ \-d\~\c
+.IR dist ]
+.RB [ \-h\~\c
+.IR histogram ]
+.RB [ \-i\~\c
+.IR intv ]
+.RB [ \-\-json\~\c
+.IR filename ]
+.RB [ \-l\~\c
+.IR loop ]
+.RB [ \-o\~\c
+.IR red ]
+.RB [ \-p\~\c
+.IR prio ]
+.RB [ \-t\~\c
+.IR num ]
+.RB [ \-D\~\c
+.IR time ]
+.YS
 .
 .SH Options
 These programs follow the usual GNU command line syntax, with long
-- 
2.49.0

