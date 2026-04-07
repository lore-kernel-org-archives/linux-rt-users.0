Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7938C2DE
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544694; cv=none; b=rSERRooMZSLkGoKoTbnWeb5/V+ALmCZ9nAFw27wa+Vis79LhOiNEtVUixqstQy5HZt14xLLmUyYZytLLM9ZtAC0lxNtgeDnjwomdpmDCD1m0RQfTF7hyrZiWEbwNFSj9ncEF/tle+HCIteK0byqtSs9PWFc04lwTf+MaqSVxS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544694; c=relaxed/simple;
	bh=kt9zujuLq4Ux6VCj/De6eF3nhs3EkVqSHaQB9oLvTtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1MLHwbJIPZcH5USHY3LnfF93/rMkfZxezBwweC882PWM0zM5EC/9rHLQYg+iJG323bRPkwCS58Qejll4bl5lulRA2AxzrMvdGqHX1QOg96PJalBVFxKfSHEEa1QTuMhoyiT7UXnbTOcmpvybijfCOyk6Yp8YO6KDTPhG46ljSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNS8s48b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=keaVypnS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNS8s48b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="keaVypnS"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775544691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nCrHldYGxMuup3xSZDQrZeNzFQMPIX4VHvZdGGJjNc=;
	b=qNS8s48btpa1MeKwDEccYcwx3lMU9QSTNcbmxQ7bEkqQEkRiNCMAPNmWzpGvBhIXlIi4g/
	wNQ4mn+KSRG28Qh9TDuebknKdzp/EY6ksn/p7P/0OT8QOq5ppVBvabqeFo86/fOKTDGiF6
	xLoWVu45YpYeBbqiPaRK6KNxkyvGa+lTIwW7oWNV4MsGAj5gmPteeRR9sZWvSCRv/Wf63b
	BIne9WMCvniGgQT0p81M9/q01ZyWAUEF8plxdOHAqLNSQwhTxyVgW9rKmaYG1i52WzxnLr
	YF4RzDsUOHTI2FGd47lUfNJUx0wVLs0Kv5tit9CMqXA/ig8Dz9gBrC2MbbQtKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775544691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nCrHldYGxMuup3xSZDQrZeNzFQMPIX4VHvZdGGJjNc=;
	b=keaVypnSZGIMtUqijQYfLT6uRJH5ZdgYKCGpIpgrJ+LOYILNfmzXfmAzQW9q3uCoNphesU
	6TCJqgEQMtzm9pDQ==
Date: Tue, 07 Apr 2026 08:48:43 +0200
Subject: [PATCH 3/6] cyclictest: Fix error error returns for uclibc
 clock_nanosleep() fallback
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-auxclocks-v1-3-1ef80d14eb0a@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
In-Reply-To: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775544676; l=1074;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kt9zujuLq4Ux6VCj/De6eF3nhs3EkVqSHaQB9oLvTtA=;
 b=EwxZS9jDY6kYL7cQjPczc1cgT9nwSF0WdEVQnKdQ/z1IGFdrDcBgAuyg/+72zy2oEPZyeN+TL
 AqW/gFbd++0AjQkvNP5KQrZm5Nl8CwVmcd9kAfr8rm67/tUx6bAXgBe
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

clock_nanosleep() is expected to return errors as a positive number,
without relying on errno.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 src/cyclictest/cyclictest.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0c30e767e685..dacf0b7a718e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -62,12 +62,18 @@
 static int clock_nanosleep(clockid_t clock_id, int flags, const struct timespec *req,
 			   struct timespec *rem)
 {
+	int retval;
+
 	if (clock_id == CLOCK_THREAD_CPUTIME_ID)
 		return -EINVAL;
 	if (clock_id == CLOCK_PROCESS_CPUTIME_ID)
 		clock_id = MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED);
 
-	return syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
+	retval = syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
+	if (retval == 0)
+		return 0;
+
+	return errno;
 }
 
 int sched_setaffinity(__pid_t __pid, size_t __cpusetsize,

-- 
2.53.0

