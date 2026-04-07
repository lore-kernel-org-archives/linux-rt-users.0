Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7938C419
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544696; cv=none; b=p79hMdCj8YiBe6QXe3In3R0MxSWaVQNKH4v1QK6J54CnLrF53ZUqxK1K7OCe/0dT3vXCL7ZJWeKVMt4a5TJMBOAIoS1Lni+PxguQlfYfDv6fYuclMXGItoYZ/KpoTCi/oT2X5adyAv9KOW7WzQWFovLUY2jfupCR10cErPdl59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544696; c=relaxed/simple;
	bh=4gIA6XKLoszn7B8bjd8qYJ8DieS7ENIeQGOSFVvGnhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJ+AlT8KExsQRKfGAqKPyoM4XVvHR73/tyFmPg/8Jlmd/BZMG/yRUQIEt5p0FWgrCI6HBA7lKgYb+0cWpcpM9+zi0P9wPuTLXKjVDuqFglrE1vFtuRe+8h803uLn/Wrm0VIyS9ymOL1YMND5M7+NcZDROSMqLNiAZ5vaZcPB6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VZNdX9Sp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TxKwyT8P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VZNdX9Sp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TxKwyT8P"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775544693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShkJdlxl1e3HokWE3zYv+zzkzToDxaE+bO9gZlFwoHg=;
	b=VZNdX9SpKe3DFyQVTTviYJiLdv2hoPuBOUFFEm1hvG6NUjGH22pUxUW8MsX8if/TOtfFhp
	HHjiwbn5a6LQaNPEUG3QvbZl1wbmQUEtvQEwL/o9buS/hn1hY6bEV6Cd065zJGBNfD8u85
	9miUhW6XM72ibjtbelP/5Qti4VOfLFlG4lEzpq1TY/klN9L+Av+uJSB+UUWozqBWB2zXmh
	aPvOlRKL6Lg3v1eAaVL8sd/8q3tPUs+zR2HMl/2XuVeJE6zJTkqvGJsaaITG6hWZNTtI9r
	gfc49LloaL+L3GczcmtIA2MBKWCxY6Ylv4OWLYO3e5peq1IDc7+9HK4/lMasIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775544693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShkJdlxl1e3HokWE3zYv+zzkzToDxaE+bO9gZlFwoHg=;
	b=TxKwyT8P3hOHMKKhP7+AtunI2w8W0P/h7oZGUY+YAqL7lYjcWfudmPWyRjaSkCm/vtHIF8
	fnkJjN9vHrQMgbDQ==
Date: Tue, 07 Apr 2026 08:48:45 +0200
Subject: [PATCH 5/6] cyclictest: Allow symbolic clock names
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-auxclocks-v1-5-1ef80d14eb0a@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
In-Reply-To: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775544676; l=2405;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4gIA6XKLoszn7B8bjd8qYJ8DieS7ENIeQGOSFVvGnhE=;
 b=dTQHwWmd8OW95CAh35dOIVcpLYotWw+CMCqH/VcAUYaXkxVP0rFBV4A4d9hdAd+qU/C1GHmEk
 ctrp1RUiNjjD7U+RuKNJSIF8OSWNw8pP7odXGRKCPCWAsHbUVwiIUKw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The numeric values are not self-explanatory. New clocks are about to be
added, exarcerbating the issue.

Allow users to specify symbolic clock names and document those.

The old numbers are still handled for backwards compatibility.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 4 ++--
 src/cyclictest/cyclictest.c | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index ff2cb968fc01..1a59d3b29048 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -56,9 +56,9 @@ Send break trace command when latency > USEC
 .B \-c, \-\-clock=CLOCK
 select clock
 .br
-0 = CLOCK_MONOTONIC (default)
+monotonic (default)
 .br
-1 = CLOCK_REALTIME
+realtime
 .TP
 .B \-\-deepest\-idle\-state=n
 Reduce exit from idle latency by limiting idle state up to n on used cpus (-1 disables all idle states). Power management is not suppresed on other cpus.
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 40da2cc4119d..2d1ff968f8aa 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -950,8 +950,8 @@ static void display_help(int error)
 	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
-	       "                           0 = CLOCK_MONOTONIC (default)\n"
-	       "                           1 = CLOCK_REALTIME\n"
+	       "                           monotonic (default)\n"
+	       "                           realtime\n"
 	       "         --deepest-idle-state=n\n"
 	       "                           Reduce exit from idle latency by limiting idle state\n"
 	       "                           up to n on used cpus (-1 disables all idle states).\n"
@@ -1043,8 +1043,12 @@ static int handleclock(const char *clockarg)
 {
 	if (strcmp(clockarg, "0") == 0)
 		used_clock = CLOCK_MONOTONIC;
+	else if (strcmp(clockarg, "monotonic") == 0)
+		used_clock = CLOCK_MONOTONIC;
 	else if (strcmp(clockarg, "1") == 0)
 		used_clock = CLOCK_REALTIME;
+	else if (strcmp(clockarg, "realtime") == 0)
+		used_clock = CLOCK_REALTIME;
 	else
 		return 1;
 

-- 
2.53.0

