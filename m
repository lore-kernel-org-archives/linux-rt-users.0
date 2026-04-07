Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7538A734
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544692; cv=none; b=XxYoRkAtI0GNlNM/dr92YGanayzxIQlDvUaDHzH7q4ZH4SNUjIe343UgzdqUoYXxV79qSIfztFJwQR84LZls2BsBjgHvf1K08P7G7KhXD9HYZKVQ90M2jSvzEpJYMQKfUTsuYnDjOsYaud/HiVs+nUdZLgZHifeattrtvtLZlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544692; c=relaxed/simple;
	bh=+T1opPgkUantYidESpffkhQl2rrfkvLCUpnM+NZ1O/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ican/CDT1f1n0irKTqpWwHVFMHqkw/szlgB7SG3woqjZZeayjlnouFFbfmX8hKnjy/H7O6xCnRXPEj6GrWXgBeU3HDkjaWjwgPB72QYvHNydD/b7MYyXR19Z12bIDEbbcODNdBWAV5NXTM/JNCfbUeFykWDCbzSspF4Vs1CV1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VRse74Sh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yqhORPN8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRse74Sh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yqhORPN8"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775544679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HX6vK6tlu4ELW6ZSLpA/fRpqJw0PfLpcWMenhuOHmc4=;
	b=VRse74ShncvkdjEyEBu11AWwvG0iDU+NQfZt+ADj+u+7XJEZ+r4fYqgzh00NEi3BVv4lyL
	OwPHOhzBPcd5BmKNKMxEhs9ZcV3DW5cSPEtB7khJTygiAiyZptgGsUCmR3r+eza9UtJ2+Z
	G9fIh0vxDpIPjPhQMfCRdBC0GL8t2BMAAQCvItXIAjwKGKbICjxjMglWHHBHGRv6QaD7Vn
	wePwAh1byuPQxTYJpCUqC4DuH1WGmwT4Jd0EM/fnNCJ8q5pDgdx03uBW/Pv99iAET0HwDJ
	eoiTBcXU5djwZoBIe4XOtnALC8mCgU0VVNHpVyARTV/9iyOcDN9wI0KuJtZf6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775544679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HX6vK6tlu4ELW6ZSLpA/fRpqJw0PfLpcWMenhuOHmc4=;
	b=yqhORPN8LP3L0i/PbO0IMg2Ai5ipsBx27XNOY0cWd62a24pLsxVJZtduKDP+fQb8yJhdhi
	4jdhou7r9AEUAcBg==
Date: Tue, 07 Apr 2026 08:48:41 +0200
Subject: [PATCH 1/6] cyclictest: Centralize clock option parsing
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-auxclocks-v1-1-1ef80d14eb0a@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
In-Reply-To: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775544676; l=3786;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+T1opPgkUantYidESpffkhQl2rrfkvLCUpnM+NZ1O/s=;
 b=0zSWH34wyskMGpj3ZFLwcha4DuBxnp3bupONOTRudD1vGhH+amA2o0RQrfc2kHvKEuMotIhvD
 HfGITAuiMuOBFb77WM3FKbreuJQlQqP+H3v2GALtPmJSApvsehfWYnc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently the lookup of the clockid from the commandline options is done
in multiple places. This makes the addition of symbolic clock names and
new clocks cumbersome.

Move all of the clock option parsing into a new helper function.

As a side-effect fix an off-by-one error in the validation of the
clock command line argument.

The new variable can not be named 'clock' as that would conflict with
the libc function of the same name.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 src/cyclictest/cyclictest.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 960c90560668..592cf9d9387d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1022,7 +1022,7 @@ static int priority;
 static int policy = SCHED_OTHER;	/* default policy if not specified */
 static int num_threads = 1;
 static int max_cycles;
-static int clocksel = 0;
+static clockid_t used_clock;
 static int quiet;
 static int interval = DEFAULT_INTERVAL;
 static int distance = -1;
@@ -1031,10 +1031,17 @@ static struct bitmask *main_affinity_mask = NULL;
 static int smp = 0;
 static int setaffinity = AFFINITY_UNSPECIFIED;
 
-static int clocksources[] = {
-	CLOCK_MONOTONIC,
-	CLOCK_REALTIME,
-};
+static int handleclock(const char *clockarg)
+{
+	if (strcmp(clockarg, "0") == 0)
+		used_clock = CLOCK_MONOTONIC;
+	else if (strcmp(clockarg, "1") == 0)
+		used_clock = CLOCK_REALTIME;
+	else
+		return 1;
+
+	return 0;
+}
 
 static void handlepolicy(char *polname)
 {
@@ -1195,7 +1202,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			tracelimit = atoi(optarg); break;
 		case 'c':
 		case OPT_CLOCK:
-			clocksel = atoi(optarg); break;
+			error |= handleclock(optarg); break;
 		case OPT_DEFAULT_SYSTEM:
 			power_management = 1; break;
 		case 'd':
@@ -1377,9 +1384,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			      "on this processor\n");
 	}
 
-	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
-		error = 1;
-
 	if (oscope_reduction < 1)
 		error = 1;
 
@@ -1983,7 +1987,6 @@ int main(int argc, char **argv)
 		warn("High resolution timers not available\n");
 
 	if (check_clock_resolution) {
-		int clock;
 		uint64_t diff;
 		int k;
 		uint64_t min_non_zero_diff = UINT64_MAX;
@@ -1994,9 +1997,7 @@ int main(int argc, char **argv)
 		struct timespec *time;
 		int times;
 
-		clock = clocksources[clocksel];
-
-		if (clock_getres(clock, &res))
+		if (clock_getres(used_clock, &res))
 			warn("clock_getres failed");
 		else
 			reported_resolution = (NSEC_PER_SEC * res.tv_sec) + res.tv_nsec;
@@ -2009,9 +2010,9 @@ int main(int argc, char **argv)
 		 * This will reliably capture resolution <= 500 usec.
 		 */
 		times = 1000;
-		clock_gettime(clock, &prev);
+		clock_gettime(used_clock, &prev);
 		for (k=0; k < times; k++)
-			clock_gettime(clock, &now);
+			clock_gettime(used_clock, &now);
 
 		diff = calcdiff_ns(now, prev);
 		if (diff == 0) {
@@ -2035,7 +2036,7 @@ int main(int argc, char **argv)
 		time = calloc(times, sizeof(*time));
 
 		for (k=0; k < times; k++)
-			clock_gettime(clock, &time[k]);
+			clock_gettime(used_clock, &time[k]);
 
 		info(ct_debug, "For %d consecutive calls to clock_gettime():\n", times);
 		info(ct_debug, "time, delta time (nsec)\n");
@@ -2193,7 +2194,7 @@ int main(int argc, char **argv)
 		}
 		if (priospread)
 			priority--;
-		par->clock = clocksources[clocksel];
+		par->clock = used_clock;
 		par->mode = mode;
 		par->timermode = timermode;
 		par->signal = signum;

-- 
2.53.0

