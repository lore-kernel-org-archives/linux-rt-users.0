Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25222F9C47
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898259; cv=none; b=huu6WCYJPQMNrgW91TsdLcursDFVDBQANa9QciGS9gcDgeHBAlh5a/xWGVW5nfPT4u9aZPdsmGEoTgcSLMGVP5wq9nU+P+tZq52ulRYobU/GWUcUH7LvWRpqFC6kRUA5joEbay+V7HxD1aSeDOS8M+C+Nlwi+ZgSx6OCrGj74pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898259; c=relaxed/simple;
	bh=uhvMxeDhErFe1jga7BffVJv6JHzuTxG2JqpPju8OJ4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+KMiU9k4E2MRHRWS9T5XncPGINaLFd1WHgLYmHOjcc9IH3SkZgv/h2Lzq5Le5KLwbVxGlnQ37UIPDdrafQX1brcP3dFmQdm6OSR45pE8syF6cqCm/i4DQhGm651vcLiRa3mQHB+DOMIeUWse9UZZ/CnvWH4RN1gKOIfq4UqRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F121DzyJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VeZsfyuA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F121DzyJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VeZsfyuA"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAqa3/Ae+DxgkhcfvJj+kjbDuuhz+TYgoYMCdb65N1M=;
	b=F121DzyJh+uiaOuBIM0z/va7h8WuU8Cy47L70pBSoWlpb7pnxoSEh6ID8OWkrEUalAYYWv
	bWzIYcMM7mx9kgLcEVYkJ9fmytTCyaEdFL1H71CXkuOrKs9kBkIkuCNRRjZ2iFtZMgsdqv
	0U+7gi+EsWIgi0w7+XdEMQT6HbZH4UB+k+pEwldFPXEHdV1cCVvCecu7dd3o6JNNT2L6Qt
	p4Ryio0OKi6UW7308rz00TgEbiO/q0M+SPqBtJsgQjn+8OBQt+grnc42/2/3VYvkf+VZO9
	XbfVEj1cuv9DxiuMHCIpfXjMRb8A0SQPyuekLF3xFs/5VirNYFG3I9fy8nYZAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAqa3/Ae+DxgkhcfvJj+kjbDuuhz+TYgoYMCdb65N1M=;
	b=VeZsfyuAAyH7VordNyzZRwLipDsOxo0Xc1mpo8bmPvN2KBWp9ADhzXjCrOjsBgRzivokjz
	JEofb3wSSFaT5aAg==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/10] sched_deadline: Check the resulting size returned from snprintf()
Date: Wed,  3 Sep 2025 13:17:16 +0200
Message-ID: <20250903111717.1391196-10-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The code simply assumes that the built path does not exceed MAX_PATH.
Since the previous change the compiler started to complain but I don't
see a connection other than the removal of one find_debugfs() user.

Make sure the resulting path is not truncated.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cycli=
cdeadline.c
index 82e640409ecef..89b7c0b8deb21 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -160,12 +160,16 @@ static int fill_sched_features(char *path)
 	if (strlen(debugfs) =3D=3D 0)
 		return -1;
=20
-	snprintf(path, MAX_PATH, "%s/sched/features", debugfs);
+	ret =3D snprintf(path, MAX_PATH, "%s/sched/features", debugfs);
+	if (ret >=3D MAX_PATH)
+		return -1;
 	ret =3D check_file_exists(path);
 	if (ret)
 		return 0;
=20
-	snprintf(path, MAX_PATH, "%s/sched_features", debugfs);
+	ret =3D snprintf(path, MAX_PATH, "%s/sched_features", debugfs);
+	if (ret >=3D MAX_PATH)
+		return -1;
 	ret =3D check_file_exists(path);
 	if (ret)
 		return 0;
--=20
2.51.0

