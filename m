Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14553DA7C0
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750520; cv=none; b=r4toaT3NbikQdZKwcuhQbw67Xqk68oFwYLFiKsdY+x86EX9YWPghAjsEuVl5Fhp1AHISKkulZlNM3ny+58fMCMW/vSMpn3bM0NZWshr/eSiqVKg2338D2I2sQOKjsBkfnR4LSKFaAKKTAgO9wxahqziBGCW9stc7MaoK+D5dIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750520; c=relaxed/simple;
	bh=0SPsH1iNeYjaFNNplQBPKk7J16KPQYYpZ/VlKbJJzLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiUmQanKJn9H2NWn/oMxhsbktehoihOPLQbmBBF/AQrxRM3kzHS5afiHNVcsytfZZdNy7Xi9NShPhN9VtwoVI6QJWCUcGPCy65KFol9T//fymKqSHYtbaPJd3EF/88SeNVjP2/JFshnpfvtC2RYisu0zgetzm75I1B+HhI5j1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AXrMR3uj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v13zZBe5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AXrMR3uj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v13zZBe5"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b353wR7vFlzYB84OhMBCgAzCFQ05Xh+q6ledPoLjBuw=;
	b=AXrMR3ujQ4xfQm5Wr+aiD9vtxU2mWup8Z9bhv/H/dPAv2UrEjeT00yQ7Vvf+62g63mOWDj
	GTRJTP5wu0ap6+a04luHK+PXtnLVvM+qLAstfSGEnznRm0MvEZwZMerxZMTWCXpupuw15C
	lsDuPXzruPlwdeMjmV1LqyQZoqzGeHD4fDhADWfaSP/H6LIGrOi+sxSOxdBUU8vEX8RLwI
	RPQx13YlFaj1Wh79zxPxD7odZzSpJlmG3AnG64+OgZOswbL0ojW46h4gTpFbTICazHa5iK
	Z1pAScCf3z/wcEXdtkoEkbROkrD++ujTDU4JhKXzpGUMaZ6RfeYnangZYBnk9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b353wR7vFlzYB84OhMBCgAzCFQ05Xh+q6ledPoLjBuw=;
	b=v13zZBe55QKY0cD5iupKf0J+/P6m/j5WpLFhIbNornQC8OSI9ahhxuFPE7c+r+v+NYDM2o
	98goDIwp2lfL5PAw==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] cyclictest: Make break_thread_id_lock a PI lock
Date: Wed, 26 Aug 2026 15:21:50 +0200
Message-ID: <20260826132153.2476006-4-bigeasy@linutronix.de>
In-Reply-To: <20260826132153.2476006-1-bigeasy@linutronix.de>
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

break_thread_id_lock is acquired at the end once the application is
about to terminate and the lock ensures that only the first thread
writes/ updates the termination reason.

Given its usage there is no requirement to have it as PI lock but having
it as PI will keep the RV-monitor quiet so let's do it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 29ddf2d98bbe1..257b6f1b70cf6 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -200,7 +200,7 @@ static int smi =3D 0;
 static pthread_cond_t refresh_on_max_cond =3D PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock;
=20
-static pthread_mutex_t break_thread_id_lock =3D PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t break_thread_id_lock;
 static pid_t break_thread_id =3D 0;
 static uint64_t break_thread_value =3D 0;
=20
@@ -1958,6 +1958,7 @@ int main(int argc, char **argv)
 	pthread_mutexattr_init(&mattr);
 	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
 	pthread_mutex_init(&refresh_on_max_lock, &mattr);
+	pthread_mutex_init(&break_thread_id_lock, &mattr);
=20
 	/* lock all memory (prevent swapping) */
 	if (lockall)
--=20
2.55.0

