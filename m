Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132EF3F7895
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750522; cv=none; b=G716QIxoU2jce9sZlRbkQt3pEBtClENjTsD0AlI9U4cx7MQX3O04INkC6vd2If67NKCj2br/V3vQSp1GR6eGUTlHpRe0muvQW6Z73hvKBQ6Zoam7cvSnnaXd5lYYhPG+rvL6UIPXXlPuQlC2ppfs+oMjLwle5yxw5pvbraUb6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750522; c=relaxed/simple;
	bh=oz1v3N1v6QmmE3jjbF7lonAPoOsL3RJ2BVF5B2cYdAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzdSt/29hanUCi/TUEdFlbgFmAAvB2ctnN++zuMUf6qPq+sSiL1FjNK3u7SG5oaHXgLcRjR0dnIcKoqckmX+17hd3vYljCTLOSWYCMt4fOnGZti7bkxcNjA8rDJWDZEg1p8g4le20CQp9Vyml4JdIQWtGXSfwyOr9Tm3n4Pz0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3B6uXjnQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7xiYQHa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3B6uXjnQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7xiYQHa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve1aI5cClDqgCd9YBFWATIYeP4uhBaTZPFw2deoThDs=;
	b=3B6uXjnQ+Y2wyzWsslvJCFNP1YNokpHmFYkfMppXnMsQFZMIR0xj3XQt5ka/NtDWryAwO6
	RG5Tr4dlnEH4DPV1nBk9fxaOjXHtmPcTEcnbU4RKyMmzTEXCcYjzs7FyCEtm/Y/mTOvpkl
	qf3Az6toejqviFjmC/KWdrFzXD1RbD4dSDT7t0F6uZFPIIQwbE2F8ZZMSTwQNjSzLwqth0
	ZDJWAnEuAiuo0+qvB8AH2ZU2NYl+XbDP9280+BBedgTDVRhOII/aEq53Wu4HwyXKCz57dN
	vshBXRCTY2XUdmv2VK3ccLlqvRRfCK7jTY/gFIl9+P74MexVxbJEGygt05WrnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve1aI5cClDqgCd9YBFWATIYeP4uhBaTZPFw2deoThDs=;
	b=k7xiYQHat5HpIFaBPtOempGfQHE7bNRAn3odZDJ9zJHKs0pDr3EzNuTmXPhpcPWQt98ntf
	KWHo5VYPtYAVarBA==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/5] cyclictest: Add a timestamp of the last update
Date: Wed, 26 Aug 2026 15:21:52 +0200
Message-ID: <20260826132153.2476006-6-bigeasy@linutronix.de>
In-Reply-To: <20260826132153.2476006-1-bigeasy@linutronix.de>
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a timestamp once the the MAX value is updated. This is useful to
figure out when a certain value was updated and if an update occurred on
multiple CPUs at same. The output is seconds accurate, the ns are
stripped for now.

I'm limiting this to the the -M switch, which I am using, but there
should be nothing wrong with using it unconditionally.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 1cad1bf6b929e..1c14d13b7cd80 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -145,6 +145,7 @@ struct thread_stat {
 	long redmax;
 	long cycleofmax;
 	unsigned long smi_count;
+	struct timespec max_update_ts;
 };
=20
 static pthread_mutex_t trigger_lock;
@@ -834,8 +835,10 @@ static void *timerthread(void *param)
 			stat->min =3D diff;
 		if (diff > stat->max) {
 			stat->max =3D diff;
-			if (refresh_on_max)
+			if (refresh_on_max) {
 				need_refresh_max =3D true;
+				clock_gettime(CLOCK_REALTIME, &stat->max_update_ts);
+			}
 		}
 		if (need_refresh_max) {
 			if (!pthread_mutex_trylock(&refresh_on_max_lock)) {
@@ -1599,6 +1602,18 @@ static void print_stat(FILE *fp, struct thread_param=
 *par, int index, int verbos
 				stat->act, stat->cycles ?
 				(long)(stat->avg/stat->cycles) : 0, stat->max);
=20
+			if (refresh_on_max) {
+				char ts_str[64];
+				struct tm tm;
+				time_t ts;
+
+				ts =3D stat->max_update_ts.tv_sec;
+				localtime_r(&ts, &tm);
+				/* RFC 2822-compliant date format */
+				strftime(ts_str, sizeof(ts_str), "%a, %d %b %Y %T %z", &tm);
+				fprintf(fp, " %s", ts_str);
+			}
+
 			if (smi)
 				fprintf(fp, " SMI:%8ld", stat->smi_count);
=20
--=20
2.55.0

