Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A126F2A8
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898256; cv=none; b=cWiYnQr06QSDg2zsccympLlPeHnC/RHWPqZ7eg98O/yZvHl0VL+z/XgeiJp4ghm2vgesFCzZan/PBi/++Yw7jYu30WkCbo7gePzmnny6zMgyI25UoLuGN4mtNp+QRZqyU56lwjUNrdjABKzOjHTpZZvWTgRm9CIYCE6JkO0oQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898256; c=relaxed/simple;
	bh=v3rBjb0qKSaziN4BS/JDEwzXVHNdjNRS9LaZVG2DG1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1hdlDTmdHxBIIRdRZ5UI2uf17Btm2MrOlUBN2DPZW12S2RaNoBO2zAHPcXAYaRODVgmyp0kP1LML089/0NQfNVI45PQ0LYTzvoZ2v/aKH5t27JKVUHPvRYjMHj2jaQU42511Icn7VxV2pjntOyO5K8/Oii4EnmH4sQmQxM4D1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gSblgCyH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jGzSranl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gSblgCyH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jGzSranl"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slry9ju6HgkYZX4FtaWN64KaMd94LkizbXpg6Hl48UM=;
	b=gSblgCyHK9N0BAB3xOc2ljYwFSVl6tosZAIPnzzF50J6YsVus7KaA1aD5r4TS4x0x1O7rz
	udZQpF/4sawR0ajyiLLMEtDXcMKCm75x4l8qm3poVMUXU1U4dqRJgmVyEZEkkg0nw3VwqJ
	wuo1sn/ltwAZKz6CYfq2DIP2F+qaPWITisXKtcaM0bFPGkGCK/T3Lird1FpliL9TEkhTCc
	m4MYt36/4zU1l+kyckmsxKSYqjBtZMZaVHD2bQEM3IqVfLXusX9LmnHcELIVflHd0IcuL1
	W9KvbyjVB+Yt3OafPSnzleoi6REqX68on01aC38hfVEzMWYSJpCvpS1quo0v+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slry9ju6HgkYZX4FtaWN64KaMd94LkizbXpg6Hl48UM=;
	b=jGzSranlBz80xLUmSHsVSo/HLlHJj3cKeH/wC92GL6pRkcThLs5Ahx4M0Es6/V40t+GJsY
	e4h/cavaPma6PeAQ==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/10] queuelat, rt-migrate-test: Use tracefs for tracing
Date: Wed,  3 Sep 2025 13:17:11 +0200
Message-ID: <20250903111717.1391196-5-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of looking at all possible folders underneath debugfs for
tracing, look directly at /sys/kernel/tracing/. It no longer lives
underneath debugfs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/queuelat/queuelat.c               | 2 +-
 src/rt-migrate-test/rt-migrate-test.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index 28cf7abe83ae6..5a3d0c61a3fc4 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -331,7 +331,7 @@ static void trace_open(void)
 {
 	int fd;
=20
-	fd =3D open("/sys/kernel/debug/tracing/trace_marker", O_RDWR);
+	fd =3D open("/sys/kernel/tracing/trace_marker", O_RDWR);
=20
 	if (fd =3D=3D -1) {
 		perror("open");
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt=
-migrate-test.c
index 8afe0834905bd..ccc2caf77d735 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -39,9 +39,7 @@ static void setup_ftrace_marker(void)
 {
 	struct stat st;
 	char *files[] =3D {
-		"/sys/kernel/debug/tracing/trace_marker",
-		"/debug/tracing/trace_marker",
-		"/debugfs/tracing/trace_marker",
+		"/sys/kernel/tracing/trace_marker",
 	};
 	int ret;
 	unsigned int i;
--=20
2.51.0

