Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FF175A70
	for <linux-rt-users@vger.kernel.org>; Sun,  1 Mar 2026 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772400288; cv=none; b=YS3B5z4kM6EYWz6y9UQq5oeLYJkD3SInrfmcyjkC9aBS/HrY8qTB1CouSHjk8gS6lsUp+b9LCE2UmhmdpeXB3Nk9GiCiKTnH5HFb49T1SR85HmUBcTN6aqGThP28D3gDGVUUb3UZTlgklATX6HO8P63iMpHAxp+4zQxHIyBdEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772400288; c=relaxed/simple;
	bh=NKb77muHZTO4CKRNuTUjqtpXADJOyunaHDdGjcisig8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzEUBPUZ0aE78RHAyDxkhPyc16tmetFQDLVLNe4/WIJccXO+OuxVfPC+VS6ck/3RiNjuWfgAT2VKjPoeSvqDo3RgNt1W2bPPPJPlwqV4rc+iXePkbJyYVyChY5lJYitZby0+T3K+TIbzgg7u4m9hQ93hZblCOXNBweNc5lb7Ifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vhiezbY/; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mJ9PUXBo; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vhiezbY/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mJ9PUXBo"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fPFSl063yz9v7B;
	Sun,  1 Mar 2026 22:24:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772400279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxJ8V+JWHGZz9lKpzTZIuSvAhQWT+EzM51Y0ZHcEetE=;
	b=vhiezbY/YNLrbgYCGieq0igKawXD3m4XRtS8odFRpV6wlXYrNlSf4OiouGg4sI+ZihYr9k
	lgVE5vXg+4BIY9pfkhhvlM42MjmycHMPAPrCb8Z81k059juGIfwhdwsBLFGsEzt1Qpy9tk
	DZ9RQjrHTiQf413vUIltOjj1OK1fVSEyXWvtdr5DUy+9bQ8SlV7YEtV2skJM4RWyqEqSpN
	x7+/ofLO+su7WKQz6PR7LEqzQw4FYU/lvnSILNyYJN2x/xp1Lz8pNrj6a7TZOjETf8Nl5T
	DtrKxMTR/AwADLKmt8dM7UjBaScaNgSoUn2KLK5F+vSBi3U830PnatQVTUI5qA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=mJ9PUXBo;
	spf=pass (outgoing_mbo_mout: domain of lbckmnn@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lbckmnn@mailbox.org
From: Lukas Beckmann <lbckmnn@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772400278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxJ8V+JWHGZz9lKpzTZIuSvAhQWT+EzM51Y0ZHcEetE=;
	b=mJ9PUXBolNW890gueAjuaW3tzCZMOhfB1WgmMv3WZ1Zv/fizjMFQdgBVhUJg3Uxt5U6q3J
	vr8RMo7a2Cw1UFHS4pVuPDk1n07Hpu5gC3JDF723IoS4SdCytq6p3/oHXYI2Iju57GH3tx
	ksKOex7msSU4MaccI2jQJXP4zeEGLwvzg6gBeyTJnpmVXqon4enuA006o+0ylANfqxis3k
	a4Ssx3uvUpe+B4G+2fiAtbNkoTGzv9hS9mbi4kd7CSeJkHl76c+SFd1Us1DRH3/r45TjuB
	xBeGqdXowShd3qDL3qrh/TSkPiY4RE/Q3T9q2yG63fCg/DWrWmkRf6zM1rVqqA==
To: John Kacur <jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Lukas Beckmann <lbckmnn@mailbox.org>
Subject: [PATCH 2/2] cyclictest: simplify rstat_setup
Date: Sun,  1 Mar 2026 22:24:07 +0100
Message-ID: <20260301212407.3146506-3-lbckmnn@mailbox.org>
In-Reply-To: <20260301212407.3146506-1-lbckmnn@mailbox.org>
References: <20260301212407.3146506-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 061faa4809094bd96e3
X-MBO-RS-META: pef8yujaqyecozm3764cekfxir8o9g3x
X-Rspamd-Queue-Id: 4fPFSl063yz9v7B

The shm file is truncated to zero each time before it is written.
It does not make sense to truncate it to something non zero on setup or
to mlock it.

Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
 src/cyclictest/cyclictest.c | 89 ++++++-------------------------------
 1 file changed, 13 insertions(+), 76 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 960c905..7b959ac 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1771,33 +1771,6 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts)
 	pthread_mutex_unlock(&trigger_lock);
 }
 
-/* Running status shared memory open */
-static int rstat_shm_open(void)
-{
-	int fd;
-	pid_t pid;
-
-	pid = getpid();
-
-	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
-
-	errno = 0;
-	fd = shm_unlink(shm_name);
-
-	if ((fd == -1) && (errno != ENOENT)) {
-		fprintf(stderr, "ERROR: shm_unlink %s\n", strerror(errno));
-		return fd;
-	}
-
-	errno = 9;
-	fd = shm_open(shm_name, O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
-	if (fd == -1)
-		fprintf(stderr, "ERROR: shm_open %s\n", strerror(errno));
-
-	rstat_fd = fd;
-
-	return fd;
-}
 
 static int rstat_ftruncate(int fd, off_t len)
 {
@@ -1811,62 +1784,26 @@ static int rstat_ftruncate(int fd, off_t len)
 	return err;
 }
 
-static void *rstat_mmap(int fd)
-{
-	void *mptr;
 
-	errno = 0;
-	mptr = mmap(0, _SC_PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+static void rstat_setup(void)
+{
+	int fd;
+	pid_t pid;
 
-	if (mptr == (void*)-1)
-		fprintf(stderr, "ERROR: mmap, %s\n", strerror(errno));
+	pid = getpid();
 
-	return mptr;
-}
+	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
 
-static int rstat_mlock(void *mptr)
-{
-	int err;
+	fd = shm_unlink(shm_name);
 
-	errno = 0;
-	err = mlock(mptr, _SC_PAGE_SIZE);
-	if (err == -1)
-		fprintf(stderr, "ERROR, mlock %s\n", strerror(errno));
+	if ((fd == -1) && (errno != ENOENT))
+		fprintf(stderr, "ERROR: shm_unlink %s\n", strerror(errno));
 
-	return err;
-}
+	fd = shm_open(shm_name, O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
+	if (fd == -1)
+		fprintf(stderr, "ERROR: shm_open %s\n", strerror(errno));
 
-static void rstat_setup(void)
-{
-	int res;
-	void *mptr = NULL;
-
-	int sfd = rstat_shm_open();
-	if (sfd < 0)
-		goto rstat_err;
-
-	res = rstat_ftruncate(sfd, _SC_PAGE_SIZE);
-	if (res)
-		goto rstat_err1;
-
-	mptr = rstat_mmap(sfd);
-	if (mptr == MAP_FAILED)
-		goto rstat_err1;
-
-	res = rstat_mlock(mptr);
-	if (res)
-		goto rstat_err2;
-
-	return;
-
-rstat_err2:
-	munmap(mptr, _SC_PAGE_SIZE);
-rstat_err1:
-	close(sfd);
-	shm_unlink(shm_name);
-rstat_err:
-	rstat_fd = -1;
-	return;
+	rstat_fd = fd;
 }
 
 static void write_stats(FILE *f, void *data)
-- 
2.53.0

