Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823938A734
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544690; cv=none; b=VOUYhxl7uncj0rygyHpxEMMh59zF1jK1AYPC8MZgRQYDgmQOirwVJarOYrHU3xiMq8HOAo3iaPLUxxD6RtNPGcji2fJeGWnN3VWz9MyGxUx6vA5bF+dQoZORxLWe1udgYbE1B2qgOf7qZCjXDr3gNYFubI6+y37g6wb7tG74API=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544690; c=relaxed/simple;
	bh=HsHlYJX6RRNAAPrPhzVYVqFP/QFPrL6sSfAGEwFO0qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G10GxiGhAqLohHgJjT7UbGci2+ouM8De+1P0U5WKu/XjDvW9guzA5xTQRHSCjoCPSgvTYzH0yZH9onmBR7BItunK6KKmDBplTbgfKzocc5puHzgkU4uNB0G7HWQebt3ECkaj924pOUBf1LLos8iKmkKggsBvv8nXbGwegQySkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mp2sDI6m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ysmJ7X3p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mp2sDI6m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ysmJ7X3p"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775544684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEqE6nePE8LfPabX2ABsaLaK44CDmUVIddA/Pyasm0c=;
	b=mp2sDI6mtni+xH2X59EE8lXjiu2VXRzU3y7xUCVCJV1WZzpf76KBXHiGmaAiSOlL30mTmS
	Gpbz66IKMNNdkONaB4vEoC1lDUz5UInF/CxTlc7ZgwLYIA+KBjbGdQFp8+kafYoX9S0LD+
	AIDfGebZd32n0lj6km6YapbtzPZmXi0eYa5G9A/xc23fuz6OOB62VadOOyEcTSNPyhyAvD
	plzwRIWmiHimN+O8AOHizfPqn9Yj5zbOdmaUyCE0n1TaF4UHAdRHcVVJvW006lThXmd16L
	OXnhSIPycU/E7uEZ74FM+PlkVB2y0h87Puzzwk2V3Ohtod3VTEH0LIzGYWFYQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775544684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEqE6nePE8LfPabX2ABsaLaK44CDmUVIddA/Pyasm0c=;
	b=ysmJ7X3paQRDju4b0CGJQuvqv0+it08y7NrWax6RkNYHCcEo3tMvs+sZXM+OmcNwuVN7kZ
	upsTfbple0PzXyBg==
Date: Tue, 07 Apr 2026 08:48:42 +0200
Subject: [PATCH 2/6] cyclictest: Test the return value of timer_create()
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-auxclocks-v1-2-1ef80d14eb0a@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
In-Reply-To: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775544676; l=943;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HsHlYJX6RRNAAPrPhzVYVqFP/QFPrL6sSfAGEwFO0qg=;
 b=t3h0DCj19jA0B4Q2jVTgQthmGzgvlXctWVaH/4zpuG+DvwwdLDUvSFJ1PD0aP1EDhZfkOnkna
 aYj5RTn2w6MDu5Xo0lHb3LOUlvltbi3HywQ5+7V/CubVF2LFKG6la7b
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The operating system may not support timers for the select clock.

Report these errors to the user.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 src/cyclictest/cyclictest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 592cf9d9387d..0c30e767e685 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -671,7 +671,9 @@ static void *timerthread(void *param)
 		sigev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
 		sigev.sigev_signo = par->signal;
 		sigev.sigev_notify_thread_id = stat->tid;
-		timer_create(par->clock, &sigev, &timer);
+		if (timer_create(par->clock, &sigev, &timer))
+			fatal("timerthread%d: failed to create timer for clock %d, errno: %d\n",
+			      par->cpu, par->clock, errno);
 		tspec.it_interval = interval;
 	}
 

-- 
2.53.0

