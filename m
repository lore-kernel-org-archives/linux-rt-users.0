Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B5380FC3
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750519; cv=none; b=L1HejO3pXnKzlva6MyRN17lHBYRUa8lDospV3EY4bwnVG39qTJnXuhvY3WUrYoFEfzur/A54xyzufKCuqaESNFkEsAe00TikdZw+niHXOFPaX0mL0sThvL8jPAVP80yYzC2WCwBhkd9N/Qb4ZvjDxt5WwbebYAe5ujWtmaKXtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750519; c=relaxed/simple;
	bh=KFfvw/G4ztZjF4Ue17jil5LuuMxmkkUdU0ULbArVImI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnXWzwU44zRG0w4HaGwKCp9VuVXnKJj5uTbIMk0jX58tED/zDz+frMruuXuHhbq0eB7cAifzBtXbNUbjtWRhHUhsabnZgyW0IoTrbq+LKCKH2z99/6CFXAAMiHVNjpICUP1l1tJqoL5oCnUaEEZnA8/xP+kVhs0UO12xEwqdmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1UMqi4v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wch44SnY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1UMqi4v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wch44SnY"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787750515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JgB8+oO717FJbOD8rAorkQDyRGQoZQ5hs/gLONtKTbQ=;
	b=t1UMqi4vsNyZ5x7jV19idaN2V5sKxR/aUCU2qADIf1U8wxrK2Lluthp5vw/wpX6cdZxWdB
	lowKzv+8BOfHJdGJyEt5VS9v1ZoUvIuvnhQEDoK9VYwpGx8gJJRraO/5lWYwpPjwmXqqkn
	sPEhG2/C4KapS1EOHesuYdAxZmxxJruXAQraSjSJLhM+TolVnfmgyHeH2xGiUcNA8db3tE
	HUSD1EbYHkDsr/AcmOXX2wH9R3cFDw9/aecxUdJRzvtOJ3VUt4ChkbWnsauGRa6mXb4E5b
	7gp0B1Gbr6HROF0oZtz3in6+KraOhclb86NYOroU/BM8fNUrAz0QPaF5hjl2Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787750515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JgB8+oO717FJbOD8rAorkQDyRGQoZQ5hs/gLONtKTbQ=;
	b=wch44SnYi0SbgjIgPC+culS5TAaWcIkp9dyFOJ/zJyyFyw6QaxLmo7PGTZod55VozO3F6r
	KKXIDuL1hvHVGIAg==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/5] cyclictest: Little tweaks here and there
Date: Wed, 26 Aug 2026 15:21:47 +0200
Message-ID: <20260826132153.2476006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was debugging something and was wondering about the high latencies
that did happen from time to time. Turns out it is due to the -M switch
if multiple threads try to wake the printing thread at the same time.

#2 is the actual fix, #5 was debug code which turned out to be useful.

Sebastian Andrzej Siewior (5):
  rt-tests: cyclicdeadline: Remove unused `alloverflows'
  cyclictest: Acquire a lock before invoking pthread_cond_signal()
  cyclictest: Make break_thread_id_lock a PI lock
  cyclictest: Make trigger_lock a PI lock
  cyclictest: Add a timestamp of the last update

 src/cyclictest/cyclictest.c         | 38 ++++++++++++++++++++++++++---
 src/sched_deadline/cyclicdeadline.c |  4 +--
 2 files changed, 35 insertions(+), 7 deletions(-)

--=20
2.55.0

