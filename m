Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C152FCE2F
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635745; cv=none; b=l6KCbhDP2cAjU9K4WES3Aw6ZyMgbxQKGUCRDWyty0+3e34LPKdbtYniDehF3CzXiUUJH45o3MC5zQKPIPAL8pRV06WN+JPI5oW5SdxxPKHeVy1rTeHrrnlKpTazMX3c66xvxK84VrS3+Rugt4HD90ukv93I2Sr7iujtAohZE7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635745; c=relaxed/simple;
	bh=Geg1WlSeEXEYIDLI17dPFjT7oWld58D72lhYpOiXqB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z90t4WibCatz+Jyo+VO4EEalGxw+PCo4MlSiPPc6TH3WdaRVzGKMkXgVkb/feno3hfihyKJB7E0UecsG+jtzdZBbTx+Jd6ifcRlk5s+U/NNXYQhVbruNlJhh15WEIxP4R08FG1InPTD9gDqtk84yUh6GyUM0vLaWwUx26pRkuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lCoKZzfW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LLwJZPy+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lCoKZzfW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LLwJZPy+"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VnCuTRNwAoXVZRnwIYsPl6MybOxQTn2DdJiP8CzWWw=;
	b=lCoKZzfWH7i5SHCZop7b+Ychdoen9LOsByC8oZr4mTWQdmzScpcX6JlHkoSrkD08yk94mk
	ws+PWkC2aaZ3HnmYDPkFa5UUgwWM9x57lwAxbcYFca3Mm3GrUDJIYtLD3uVuhQWq7KN/gT
	3qTk+2YVpnyYjdzesNonSIu/inHIJGv+uRQg0R9E1qLSQeUKmZxrJU2mPKBxXeFubraE+Y
	TYhZ3UF6TtQl9PMU1DMcxwogbhULz3fDUPVk3Jz/7HgYQ1om7g6LJ9YeT5pObCnMYeK2pC
	hFjUO/VIBPXyvr4fazBzIe5e3N7SBcD2SwJ32ovZigFYAT8++VjieGVDsqBqgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VnCuTRNwAoXVZRnwIYsPl6MybOxQTn2DdJiP8CzWWw=;
	b=LLwJZPy+QUf8GkltSQ+J9WOZ9rtbRnyQfCePaVAL40lLowjjIA3kY2Sg+lmxNrRG/1uDPE
	VbJ+LszHGjCdQ7Bg==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 28/28] cyclictest.8: Reference rtla-timerlat(1)
Date: Fri,  4 Jul 2025 15:27:21 +0200
Message-ID: <20250704132721.13325-29-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtla-timerlat should be the official cyclictest replacement at some point.
Mention it at the "See also" section.

While at it, use the correct nroff macro for referencing manpages for the
whole section.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 16e8190..bbb0b41 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -308,10 +308,11 @@ in mind, below cyclictest example invocation can provide a good start:
    --histogram=1000
    --histfile=output.txt
 .fi
-
+.
 .SH "See also"
-.BR numa (3),
-.BR numactl (8),
+.MR numa 3 ,
+.MR numactl 8 ,
+.MR rtla-timerlat 1
 .
 .SH Authors
 cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
-- 
2.49.0

