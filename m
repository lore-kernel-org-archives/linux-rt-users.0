Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76503D811E
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750519; cv=none; b=jRYDFtO08XFS6CS4yemeSjYMpdW1R2gTQBd6LEC/wWKJEbo7eEMq1UnwgYPFDXbuIm42Dwka6VyOHnPu7r1heBSWyJoPugcpP+NiuZKrtpSq0njreMIfA8/MjcjSe7eB699JpwbDVQzXLCeXgLMVVQJ0HJkGgNXQG4a3mCguZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750519; c=relaxed/simple;
	bh=u5UiP52ZNDfwJIcbsr/hOzNPDNZwawx8RE5RSzV6YeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMSSbGWrsUZI7G7JrfOmMBxqyBH7pjRL72n0XpS4UicPfiPfugDmlv56/qMBhtUhkGR5wA145UBQsRoLFJ9j/7tJz/QLzyfSnJPYWVlREds06muEKGoH9Poy4HtokJb16OXPKrosxzylK59sWLhz5SIeP0CZiBDOqZNnm0NX6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wDwJHKHc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+EGQTm2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wDwJHKHc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+EGQTm2"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60C1mKNk8tSqFOmIDuEffEreDQFPz69T7AelZcU0ILo=;
	b=wDwJHKHcgK9NE58X0fyrycPirUyiU23AOmFsGvPk4gxPAbkcihNBd28MlhfcXxacUD8HZI
	gY530C+vpZ5p6JwHRcO2ynUhWwamEj2m16vMLj9qfRJCJENUuQdCwQK3OX9YjxPmQffnbG
	xkIhnelh6Eghqwkl9TQSO7NceLPgSXDJ8k0gjuupHFIC/fro4CAnCAyVlC3cpdbQFhHT2n
	r3H9cNTkQ/POFGCPt2AP2VaHZRGGDJV722zfgsYoQdHZEgG4CQ6DOcayvhmG+c0kH3O8Jm
	fy1hwFuSiJ+yQBbR8zqTRgcV+l6gegGnLY93iMYqgCwYrVVvI2r1swZ4JD1TVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60C1mKNk8tSqFOmIDuEffEreDQFPz69T7AelZcU0ILo=;
	b=I+EGQTm2ZBfTiX5eVqYxxUfBCvecUtiCMj0EAeAYWF2K7eT1mnFSXsG5Lek8ytTjMTC1N/
	DlLtikJME9nPqHBg==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] cyclictest: Acquire a lock before invoking pthread_cond_signal()
Date: Wed, 26 Aug 2026 15:21:49 +0200
Message-ID: <20260826132153.2476006-3-bigeasy@linutronix.de>
In-Reply-To: <20260826132153.2476006-1-bigeasy@linutronix.de>
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the -M option the output is updated once there is a new max value.
On system with many threads (say 64) and aligned wake up (all threads
wake at the same time) it is possible that all of them have a new
maximal latency and all of them invoke pthread_cond_signal()
simultaneously. They all will block in the kernel in the futex syscall
on the same lock. And each of them will wake the printing thread one by
one. This is not *that* visible with just a few threads and a quick
CPU. But with many CPUs on a slower system this gets worse.

Acquire refresh_on_max_lock with a trylock before invoking
pthread_cond_signal(). This ensures that only one thread will send a
waking request at a time. Should the lock be contained then delay the
signalling until the next iteration.

Make refresh_on_max_lock a PI lock. This shouldn't make much of a
difference here given the try_lock usage in the RT thread but the
unconditional locking will lead to complains by the RV-monitor.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 960c905606684..29ddf2d98bbe1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -198,7 +198,7 @@ static int smi =3D 0;
 #endif
=20
 static pthread_cond_t refresh_on_max_cond =3D PTHREAD_COND_INITIALIZER;
-static pthread_mutex_t refresh_on_max_lock =3D PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t refresh_on_max_lock;
=20
 static pthread_mutex_t break_thread_id_lock =3D PTHREAD_MUTEX_INITIALIZER;
 static pid_t break_thread_id =3D 0;
@@ -640,6 +640,7 @@ static void *timerthread(void *param)
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat =3D par->stats;
+	bool need_refresh_max =3D false;
 	int stopped =3D 0;
 	cpu_set_t mask;
 	pthread_t thread;
@@ -834,7 +835,14 @@ static void *timerthread(void *param)
 		if (diff > stat->max) {
 			stat->max =3D diff;
 			if (refresh_on_max)
+				need_refresh_max =3D true;
+		}
+		if (need_refresh_max) {
+			if (!pthread_mutex_trylock(&refresh_on_max_lock)) {
 				pthread_cond_signal(&refresh_on_max_cond);
+				pthread_mutex_unlock(&refresh_on_max_lock);
+				need_refresh_max =3D false;
+			}
 		}
 		stat->avg +=3D (double) diff;
=20
@@ -1910,6 +1918,7 @@ static void set_main_thread_affinity(struct bitmask *=
cpumask)
=20
 int main(int argc, char **argv)
 {
+	pthread_mutexattr_t mattr;
 	sigset_t sigset;
 	int signum =3D SIGALRM;
 	int mode;
@@ -1946,6 +1955,10 @@ int main(int argc, char **argv)
 		}
 	}
=20
+	pthread_mutexattr_init(&mattr);
+	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
+	pthread_mutex_init(&refresh_on_max_lock, &mattr);
+
 	/* lock all memory (prevent swapping) */
 	if (lockall)
 		if (mlockall(MCL_CURRENT|MCL_FUTURE) =3D=3D -1) {
--=20
2.55.0

