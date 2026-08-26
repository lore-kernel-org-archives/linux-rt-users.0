Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D893EE1E5
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750519; cv=none; b=p1YxvCAmyQKPCxRtLJQ7aAQDvZaRCCKAMSSUwcqe0tTBk0cTbCvrVLsIAUZnL69Kijb0BzVEM26qkxnaT+Z4Epp6mjsYfNa9HeJmSXyFiEybBvAynslME5d4DSfpyYCPvAnTksHpgQ98Os5DiG7khtyRRcJ8WiCHi5HaDfM+s5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750519; c=relaxed/simple;
	bh=QEXHhIb2qIdcywB63ZHTyx+SuNx4OYcK5+jOtkXoLJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsryG4BmyuHiCORkU4Qo+KX3pV6eAboRInD/ZUdN+69O8DAzG4H2fmV6t4EbYqE2erBLaugBTFJCfvwvYYfEYdqfHr5WCFttFbf/9uFMU6RL7ttAs34ZM4xbZK3ok74xUqU6UAdlrcYGdWDuGzBwWEWpbxGGjCA05QUKRCHTMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+rmsUKg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WWJeoLvq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+rmsUKg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWJeoLvq"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9R8ph8XqSAzi8X80nSIW1mMhR/frz0Io59W+E2cc+c=;
	b=U+rmsUKgqNGh8xW4jtECor9Hg4r6cAdLMSn+qKON+0Mq3Yv/hQ9KO99wxUUwMFnlwpj78V
	03m7pzSRy1879aFXhTMZGA5t2jajwZJ4JDLIx1Pn7KF5o7lgYUA5qMk3glkGIVmq86oHfd
	RX0GHiZl29TB+aZ5sB98MNNG8jFI+jvfG+GmY0HoG6uciqf3099D6e7ViYvCxRO+egjJK7
	YQAv2t7qMTB4+wJzy17FaMf7YfenLusazRx5QWlFYSgVNVQSU+faQiJk47KjNBiM4eTlub
	DsGn/P0OtRf6PkZ42DQ8DA+j0hIshOmdFD/QfpfH7gi4jwqCqnAgVeSEJb5xkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9R8ph8XqSAzi8X80nSIW1mMhR/frz0Io59W+E2cc+c=;
	b=WWJeoLvq75hTpSuWcYE1rEMowQdd+7Es9Gf13eSK8O1RlrEb4gx23ahLXEfgPbfiD792TY
	l3oYyxzaGPZOZLCQ==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] cyclictest: Make trigger_lock a PI lock
Date: Wed, 26 Aug 2026 15:21:51 +0200
Message-ID: <20260826132153.2476006-5-bigeasy@linutronix.de>
In-Reply-To: <20260826132153.2476006-1-bigeasy@linutronix.de>
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

trigger_lock is acquired by the timer thread. Given its usage it
probably makes no difference if it is PI or not but having it as PI will
keep the RV-monitor quiet so let's do it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 257b6f1b70cf6..1cad1bf6b929e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -147,7 +147,7 @@ struct thread_stat {
 	unsigned long smi_count;
 };
=20
-static pthread_mutex_t trigger_lock =3D PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t trigger_lock;
=20
 static int trigger =3D 0;	/* Record spikes > trigger, 0 means don't record=
 */
 static int trigger_list_size =3D 1024;	/* Number of list nodes */
@@ -1959,6 +1959,7 @@ int main(int argc, char **argv)
 	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
 	pthread_mutex_init(&refresh_on_max_lock, &mattr);
 	pthread_mutex_init(&break_thread_id_lock, &mattr);
+	pthread_mutex_init(&trigger_lock, &mattr);
=20
 	/* lock all memory (prevent swapping) */
 	if (lockall)
--=20
2.55.0

