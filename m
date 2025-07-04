Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517C3093AC
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635738; cv=none; b=tilS0WvfpWTTzI1hZgltrG5c5YrkXLXlPfEOWonZ53WPsTY7KOV4UyGQFT7lTTjLRCfhaDaLWZTNQ4kWvc5iAZjyynnu6h93qGvIzN2zKweObNQhAJS8y498XRWTvB0pcnyXazpFoes6tYiGVfdOtsB6TWFrCeoNoB2g8GMKyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635738; c=relaxed/simple;
	bh=aaEntEOSc6+cxlDHMvK0wjtcWAsavjI/RCJiFZZIh2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+WgqS+nV0Ge53sKXZL+IUTd6em5zlg8ISRmRj8FgLOK+hzYPCdh+E2YeUDdq7DD0EInjahDOnNwN3s607uHUfaho9YqvRdwp6l65NsMb1M1PlD3KdqqfvLu5FvbVGV5Fl7KAuOSuKKrzQJlPBU+pCpqEk04fN/1/DYOwzomMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cg52N/N/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emXDd06h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cg52N/N/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emXDd06h"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAXDgspIPO/tdhrsOwI5rqQ3b/S0aqe+TfaGhZhsAV4=;
	b=cg52N/N/maoj/vNhzRWMUJp9wrP/Ufj06h8P9fW4YQgtaSSjjzJ30I1aGf6iLVQ9mhWaQ4
	4VnSd099KhzISvsk208X+S2rs2U0yQQNbLKgBfZWlyeqyy+voBoA0NRDuFiLCO5ucCAXXp
	X8A9U5Gb9GPtGfBiKE5eS4Gnh0ci5FdXUmXIxOcd+gHvM/YSHmmIRIpEsPzBGchnQVOzxC
	39WMVRV9rQO8StulQs4p4fKqI1OnMuxz7JWZqdH7MGim/qtBldEirek+mH+IhqWFISJ6qs
	1LRC15f0WUH3ih7WD0CfDZJSps2X1b/JQnR4jGLxXei7l6gegnnbQZ3xbDCj1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAXDgspIPO/tdhrsOwI5rqQ3b/S0aqe+TfaGhZhsAV4=;
	b=emXDd06hUsU6RKwAElfsLO5xVTOf6ThmDDQ0SyPXPg8c0ONGkZ6GYRzGn7oiJv/MpgovQG
	WkIwWTqqSjlOIqDA==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 26/28] cyclictest.8: Options: Reference clock_getres(2)
Date: Fri,  4 Jul 2025 15:27:19 +0200
Message-ID: <20250704132721.13325-27-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cyclictest's manpage references CLOCK_MONOTONIC and CLOCK_REALTIME
multiple times without providing a relevant description or reference.

Reference clock_getres(2) where such clocks are extensively described.

Pick the Linux version, instead of the POSIX (3p) one, as the former has
details that are relevant to cyclictest's "--secaligned" implementation;
i.e., Linux's CLOCK_MONOTONIC starts from 0.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 6982234..12fb9c1 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -100,11 +100,15 @@ Obsolete option.  Please use \-\-default\-system instead.
 .
 .TP
 .B \-c, \-\-clock=CLOCK
-select clock
+Select the system clock to be used for calculating the measuring thread's
+latency. Allowed CLOCK values are:
 .br
 0 = CLOCK_MONOTONIC (default)
 .br
 1 = CLOCK_REALTIME
+.br
+For more information on the Linux implementation of such clocks, check
+.MR clock_getres 2
 .
 .TP
 .B \-x, \-\-posix_timers
-- 
2.49.0

