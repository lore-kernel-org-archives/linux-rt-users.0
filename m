Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22EA26F2A8
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898259; cv=none; b=ZMJHRlgVWLYYWZsSLPaKrKlWT5BIqpJ1+fslelaLXnxAytk+j4HEBPn2hh922P0GHE+omW7Ho4NZzL3oLK9LHzbrrB5z5atAyYWlXR/8AAcf5XU4jKMovqgfKMLqfu3eyTHBhw5GSuht4OMTPdu0OXFEkHxZh/ePrXi9zquIHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898259; c=relaxed/simple;
	bh=HR4837m6Z/ENdYYXQECa7s2KC444OPuaSKylx8xM/bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/xqOTJmfQ8xYZxjkJAq2k82/CIuZXV1kr79B9QWg+MM3xa+IzLYPXTTcxYgt6/fheXLM4p0wbSE1bSOM0/uYSQ85PtzsJyAFXLnVO2aPFf7ggQ85UppDIorJcQffSVqJpwRt/zVJ3lVSmLDwhpnLmbya0YQxMg5LE1fsdCbGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f6wHBJhY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLKV1A0B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f6wHBJhY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLKV1A0B"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kiTsflnrzK2w+lHkEtCDYj5Kj7GronA/PemresAcZw=;
	b=f6wHBJhYzrmJwVZszHqYoR5ZfDxTeqHueMc1Yqa06AZPG2yGU78w4N2HoalbwsnEy+d69L
	110K/6zzKFn/LIp1p4QTu3sD9XpZc2Q+0btkzJtpp22tRwF/FP1fGJs6Byu6/+kumP+fdW
	hePQ8hmCxAFzob+MiW8C6njrfK8Uvu/IIx850qM3LILL1OgjS+y9Funm9VmbWYBekaGFtN
	Kj3D42hFaLelIDfU1xha4cb6qz1CRRb4n2F/TIo0d0Yg4yAfpu6kcAfeNDr33Hgeuw5vag
	V4j8HxBe0F76rrnMgtcq1DtoOeAGVICrJNZqMcIw4CcKmH5Z147SPci2DCt7aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kiTsflnrzK2w+lHkEtCDYj5Kj7GronA/PemresAcZw=;
	b=aLKV1A0BrXuo5WJItNRq0Ecd0hh9v5ANKt+5dov9cwBU2nNLNkdJJm/HHqzFeJ3nw0sIti
	Ii+MOyXUiSlpJPBQ==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/10] cyclicdeadline: Don't test for /sys/kernel/debug/sched_features
Date: Wed,  3 Sep 2025 13:17:17 +0200
Message-ID: <20250903111717.1391196-11-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sched_features was renamed to sched/features in commit 8a99b6833c884
("sched: Move SCHED_DEBUG sysctl to debugfs") which was merged in v5.13.

It is probably okay to remove it from the fallback list.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cycli=
cdeadline.c
index 89b7c0b8deb21..4ee3717a767e9 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -167,17 +167,8 @@ static int fill_sched_features(char *path)
 	if (ret)
 		return 0;
=20
-	ret =3D snprintf(path, MAX_PATH, "%s/sched_features", debugfs);
-	if (ret >=3D MAX_PATH)
-		return -1;
-	ret =3D check_file_exists(path);
-	if (ret)
-		return 0;
-
 	memset(path, 0, MAX_PATH);
-
 	return ret;
-
 }
=20
 static int setup_hr_tick(void)
--=20
2.51.0

