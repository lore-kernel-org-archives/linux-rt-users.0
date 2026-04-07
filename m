Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA238C2C3
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544697; cv=none; b=DmcspoxKWffFA/sTCQlrfWKBVaoLAgV8pv1kjaeuJFQiXnD5qtLswcKAlt2z8LYjH9iTVE868xOoXgMkGBslIsawy4uXepteQnhb0HuTAF0aJG151iMGn9Rm+b1BybrEBsLWuxYqXYurqVYc42KQIbz5zByag/wr69I6FR6ewQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544697; c=relaxed/simple;
	bh=ZDNa1hWfQHdg6+TdVaEWwZbQmcaI5Ip1MmdgCYVcfZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLWODP5EwAhqCpFdfkSYCDIFAE98JfaECGu/cpgXBgU7EFZ5wIwS8ROd0R6ygSh36CLTWyFe7Jjt7lT95Evb3mri8Zz6btFb/2Rb6f06aPUTzli9fHs5j0o6Zmt2fIYR5h4wBPrwAGSiyv5e0lcmRbpUs9UymH/BYI8d6Hu798I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fwOe+heE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNhiGMfz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fwOe+heE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNhiGMfz"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775544694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwbEOaPZrurC/8Ntf/xR5nyOjx1lWlvcTJCp4Ctf6Ec=;
	b=fwOe+heEOdYeBMBtkz3fuxzc7lHaVTzY5MFkGcEMNzWXgfxBAwKcqFVsMMZ6nk/tASRD8r
	3FwSoAQmDU7wZSTZMwpKXDeN3rVzWZFYJH+wlWv7FysX2ESEB/dc8Up1WWnMzlri6XyUBT
	DB9RrnIdI4qhCWOq80G0sHFo7wODx4qTLqDulg5Imj21gjAFhzEd/kmcCi4iS2fgtT3BUe
	LxzJ/cqmu+C39D2QnyW5dMSYBeZLPY6hXayWAiAVQnR5APsC44TghgtfnRoQ0f0dqL6BD7
	bng0xeou1uiTEEoiAht5N1gVJfO76+tK/UGSEa/41W2ZF2hOlnxhuBFXmoE4Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775544694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwbEOaPZrurC/8Ntf/xR5nyOjx1lWlvcTJCp4Ctf6Ec=;
	b=ZNhiGMfzC3AfBGI9BSFGkr7eF2FVDZKJHVV/gCPovIaJrYGq87FEJdHgX5LTOPB5UPCjuX
	Gg3fpjfalkvvcECA==
Date: Tue, 07 Apr 2026 08:48:46 +0200
Subject: [PATCH 6/6] cyclictest: Add support for auxiliary clocks
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-auxclocks-v1-6-1ef80d14eb0a@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
In-Reply-To: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775544676; l=2818;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZDNa1hWfQHdg6+TdVaEWwZbQmcaI5Ip1MmdgCYVcfZQ=;
 b=SHt3lemRA/bdOgmP6m4Hlps7keIF56c98NW+SyVQrOG+ALlnEV72dpGJLwXQ6wo6ukBIhUoJo
 31590KDZ/JLCodMhI+TRmWO0AZ+cCkXFPjE2XmepXAvdSFwGCWOJzXy
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The Linux kernel provides support for non-standard auxiliary clocks.
These run independently from the system clock and each other.

Allow cyclictest to also use those.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>

---
Currently clock_nanosleep() for these auxiliary clocks is not yet in the
mainline kernel.

Instead of having a dedicated parsing function, I used the unrolled
switch-case as it keeps the logic simple in the face of error handling.
---
 src/cyclictest/cyclictest.8 |  2 ++
 src/cyclictest/cyclictest.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 1a59d3b29048..f3390bc5c57d 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -59,6 +59,8 @@ select clock
 monotonic (default)
 .br
 realtime
+.br
+aux0 - aux7
 .TP
 .B \-\-deepest\-idle\-state=n
 Reduce exit from idle latency by limiting idle state up to n on used cpus (-1 disables all idle states). Power management is not suppresed on other cpus.
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2d1ff968f8aa..afc3a8c452da 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -52,6 +52,10 @@
 #define SCHED_NORMAL SCHED_OTHER
 #endif
 
+#ifndef CLOCK_AUX
+#define CLOCK_AUX 16
+#endif
+
 #define sigev_notify_thread_id _sigev_un._tid
 
 #ifdef __UCLIBC__
@@ -952,6 +956,7 @@ static void display_help(int error)
 	       "-c CLOCK --clock=CLOCK     select clock\n"
 	       "                           monotonic (default)\n"
 	       "                           realtime\n"
+	       "                           aux0 - aux7\n"
 	       "         --deepest-idle-state=n\n"
 	       "                           Reduce exit from idle latency by limiting idle state\n"
 	       "                           up to n on used cpus (-1 disables all idle states).\n"
@@ -1049,6 +1054,22 @@ static int handleclock(const char *clockarg)
 		used_clock = CLOCK_REALTIME;
 	else if (strcmp(clockarg, "realtime") == 0)
 		used_clock = CLOCK_REALTIME;
+	else if (strcmp(clockarg, "aux0") == 0)
+		used_clock = CLOCK_AUX + 0;
+	else if (strcmp(clockarg, "aux1") == 0)
+		used_clock = CLOCK_AUX + 1;
+	else if (strcmp(clockarg, "aux2") == 0)
+		used_clock = CLOCK_AUX + 2;
+	else if (strcmp(clockarg, "aux3") == 0)
+		used_clock = CLOCK_AUX + 3;
+	else if (strcmp(clockarg, "aux4") == 0)
+		used_clock = CLOCK_AUX + 4;
+	else if (strcmp(clockarg, "aux5") == 0)
+		used_clock = CLOCK_AUX + 5;
+	else if (strcmp(clockarg, "aux6") == 0)
+		used_clock = CLOCK_AUX + 6;
+	else if (strcmp(clockarg, "aux7") == 0)
+		used_clock = CLOCK_AUX + 7;
 	else
 		return 1;
 

-- 
2.53.0

