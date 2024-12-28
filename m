Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447A2AE84;
	Sat, 28 Dec 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735410254; cv=none; b=lI5tdVL5a/b31qztH87bQgYtqVBdGM+/4dgoTHQGXDR9caFErrjNeKNP6FTrySGGYwDHvRvZ3Xtw46UIBetou7Mi7u/1y3B3P/yXtCvMhGC9BDse44sqEHnn1ojRAlrFwWOi8lgIzP4UluQtDKf5EiSa233eZHWiwDo7VvSk75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735410254; c=relaxed/simple;
	bh=W9X7p17yquGpl2tx6mVEIkuGE1Us+XeGw9X+OgjS5Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJZLj/elPvGUK9+rnSkRtiyQ7OWEshYco2Je4eH2iErTXEiysZMPKx8AQa7OiZlMV/eB7Vqhzr8r0E7r9J1UhLu20rdoT3UPOnsKS3Og+6Ewjn6GrzaSo/GjZdpuHri8qVYj20CcU+8AtxAALZ9j+iXhiXJnIpt1rimKFvU/Q5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=she-devel.com; spf=pass smtp.mailfrom=she-devel.com; dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=jYXKNcTA; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=she-devel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=she-devel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="jYXKNcTA"
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 7904E2092280;
	Sat, 28 Dec 2024 19:16:17 +0100 (CET)
Authentication-Results: ext-mx-out011.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:organization:mime-version:message-id
	:date:date:subject:subject:from:from:received:received:received;
	 s=dkim20240523; t=1735409776; x=1737224177; bh=nL+MZ0VyHEjSS3oe
	exumhAkBGkQi0VdLil4PCIZamn0=; b=jYXKNcTAJPOEJJ395zYrUX+IT31uiisE
	+kYfJP4X9vWp/BPlYiAQ+bkjhzAzlr4wsCZ6Ub05FRBU4otFP+qlicZWbnE/O7Uc
	j0ooJ4MJyHuDb1gQUnlSPlvlC4wSXMEV71uVjihgheJX9ttZhkHeLOlCuQGMyI/L
	5NjDV5SPVjJ4b4VJI5v2xV/+YJhLMQnd7JcLLGvfS+z0pHpW+6ZyBdD4moDYMZN2
	IhOkliHP/RL1cCAPSubtzjMgYfEpgjRg5eFzcXuP44y6WFVeRDYiaSHt+xMjo1JC
	jjNCIrObLXu0AvM9oZ/zq5Ze/4T8dAn2Cyx8Fyk+UKkhFos4ufRKSg==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ki73FNpCzVbV; Sat, 28 Dec 2024 19:16:16 +0100 (CET)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id D07F420A53E5;
	Sat, 28 Dec 2024 19:16:13 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id 1DFBE20DC7FB;
	Sat, 28 Dec 2024 19:16:13 +0100 (CET)
From: alison@she-devel.com
To: corbet@lwn.net
Cc: gratian.crisan@ni.com,
	triegel@redhat.com,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	alison@she-devel.com,
	achaiken@aurora.tech
Subject: [PATCH] Documentation: locking: update libc support status of PI futexes
Date: Sat, 28 Dec 2024 10:15:46 -0800
Message-ID: <20241228181546.1315328-1-alison@she-devel.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit

From: Alison Chaiken <alison@she-devel.com>

Update the text of futex-requeue-pi.rst to explain that, because of a
conflict between POSIX requirements and ABI constraints, glibc does
not support requeueing of PI futexes.  Add some information about
librtpi, a library which provides an implementation of condition
variables which supports priority inheritance.

Signed-off-by: Alison Chaiken <alison@she-devel.com>
---
 Documentation/locking/futex-requeue-pi.rst | 47 +++++++++++++++++++---
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/locking/futex-requeue-pi.rst b/Documentation/locking/futex-requeue-pi.rst
index dd4ecf4528a4..6ad7f0c9ea4b 100644
--- a/Documentation/locking/futex-requeue-pi.rst
+++ b/Documentation/locking/futex-requeue-pi.rst
@@ -54,7 +54,7 @@ In order to support PI-aware pthread_condvar's, the kernel needs to
 be able to requeue tasks to PI futexes.  This support implies that
 upon a successful futex_wait system call, the caller would return to
 user space already holding the PI futex.  The glibc implementation
-would be modified as follows::
+would need to be modified as follows::
 
 
 	/* caller must lock mutex */
@@ -78,10 +78,20 @@ would be modified as follows::
 		futex_requeue_pi(cond->data.__futex, cond->mutex);
 	}
 
-The actual glibc implementation will likely test for PI and make the
-necessary changes inside the existing calls rather than creating new
-calls for the PI cases.  Similar changes are needed for
-pthread_cond_timedwait() and pthread_cond_signal().
+The actual glibc libpthread implementation has not made these changes,
+nor has it made similar changes needed for pthread_cond_timedwait()
+and pthread_cond_signal().  The reason is that POSIX has a strict
+notion of "eligible" waiters on a futex, which means the set of
+waiters created before a given signal is sent.  Because userspace has
+no atomic way to perform lock operations together with the futex
+system call, the implementation must also carefully guard against lost
+wakeups on a multicore system.  These constraints mean that the
+libpthread condition variable would need an ABI break into order to
+support requeueing.  The fundamental underlying difficulty stems from
+the limited size of the futex word, which is 32 bits even on 64-bit
+systems.  See
+https://wiki.linuxfoundation.org/realtime/events/rt-summit2016/pthread-condvars
+for details.
 
 Implementation
 --------------
@@ -130,3 +140,30 @@ either pthread_cond_broadcast() or pthread_cond_signal() acquire the
 mutex prior to making the call. FUTEX_CMP_REQUEUE_PI requires that
 nr_wake=1.  nr_requeue should be INT_MAX for broadcast and 0 for
 signal.
+
+librtpi
+--------------
+
+librtpi (https://gitlab.com/linux-rt/librtpi) implements condition
+variables which closely follow the guidance above.  The librtpi
+implementation adds a new mutex parameter to the waiting and signaling
+functions in order to support the requirement that mutexes with the
+PTHREAD_PRIO_INHERIT attribute always have an owner:
+
+int pi_cond_wait(pi_cond_t *cond, pi_mutex_t *mutex);
+int pi_cond_signal(pi_cond_t *cond, pi_mutex_t *mutex);
+
+Realtime userspace applications which rely on librtpi must therefore
+make code changes.
+
+librtpi works with the kernel scheduler to wake the highest-priority
+waiters on a futex in FIFO order.  The code is much simpler than
+glibc's at the cost of omitting some POSIX-mandated features.  librtpi
+has no notion of POSIX's eligible waiters, and it does not support
+robust, process-private or PTHREAD_PRIO_PROTECT mutexes.
+
+other C libraries
+--------------
+
+Like glibc's NPTL, other prominent threading libraries like musl,
+Thread Building Blocks and Boost do not implement futex requeueing.
-- 
2.45.2

