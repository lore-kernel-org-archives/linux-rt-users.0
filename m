Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3E307AD6
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635737; cv=none; b=E6y7qloBCiIySvFNGOdbv17nef2b3gMV0aTzx44U64h5Q0bgSN8HCo7C71Kk+Ocljwt2qnR8MQEZmdu7BA5TaXZBv+HMFCucwt/OE7klrvJKa2J7slDPh6PsFBvwO6nGgwAbWC7Xbd2lc+8dmYKXMxJIepGjZQgzahAep6xQo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635737; c=relaxed/simple;
	bh=+0+leP6Wu5oWqTzzwQzp9MICjbc9SOwjDmeBIq0AAjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMD/I5FsH+PrUbwYxmgmxhqh2yMGn53RtqFtGl94jYpQgMApR3dqbmsPNPm7ktSWgJTMHzD4A92UrtqJxtmYBTsoT5DuzzgTioxSySHF8CU83kLNv4MxHotn5xaqAbeEavkCddNsqbTk8zNp9hWxIN7R/04xP9EVdPV1CUALIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yMO5Cp9x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5kz3C9sI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yMO5Cp9x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5kz3C9sI"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDWMC+kbr6ZDu1imaRKNvMdWamFpw3b4zPyriJLrPuk=;
	b=yMO5Cp9xogDSr7lLKI0WZHdIoexmXtE4HDiWWfl78KrHK4RO0mJwfXJuygjinnzhy/5+xF
	Xy7MB7n805GyqQHm+JbKTinEHpH3tKHBF555DWlJdduViotj47JQrkT9PnjFiQyj3mjmkz
	vwM7BDUjE8v2Uc1O5Lp1bGOHrRiHdsUZAFgTw7xI1lj+wRkdSwMap6PJPwUrG4QXpYgogI
	vYjO8hk26h4PwJVd72zjPnsB5lZK+JNdBK8pbt55Ysbzyzq2RzjOr+igGUGLFrM7DAonhk
	YtW+0x5KqCB8nyliM18wkKn0nazWppcow3yiyrKjfqWGWkBUVMPJngbiMRiuQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDWMC+kbr6ZDu1imaRKNvMdWamFpw3b4zPyriJLrPuk=;
	b=5kz3C9sITnPUS4b6/PzMuBQZbXcbWhQe6sZq6htlwdEJevCNCOoEB37QHiDyhMkAh+8MIq
	wnEbA90o2b75UICA==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 25/28] cyclictest.8: Options: Expand --default-system description
Date: Fri,  4 Jul 2025 15:27:18 +0200
Message-ID: <20250704132721.13325-26-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that --laptop is explicitly obsoleted and --default-system is
recommended as its replacement, better formulate the latter's help text.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index aff900d..6982234 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -75,9 +75,11 @@ display a usage message and exit.
 .
 .TP
 .B \-\-default\-system
-Don't attempt to tune the system from cyclictest. Power management is not
-suppressed. This might give poorer results, but will allow you to discover
-if you need to tune the system.
+Stop cyclictest from force-tuning the system. Without this option,
+cyclictest writes a value of 0 to /dev/cpu_dma_latency, which prevents the
+CPU from entering deep sleep states.  While such force-tuning might help at
+showing lower latency numbers, it obscures the fact that the system may
+require additional tuning.
 .
 .TP
 .B \-\-latency=PM_Q0S
-- 
2.49.0

