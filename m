Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74F222423A
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750519; cv=none; b=uF23acrkMiSTIhQlgg680ONGcUeQu593Kbp8NV8Y8WciO4xjI5Y64yR8Qmp2LACYaThvAzBOyYx43W4d4Nt9JiPYbRqne4RBopwXatSGh4ZhvDXTQ0DsVW/bjXXN5zlZJytk9JHQfOZDR1yCiK+D1hza0fY2IBOXos2omXwNXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750519; c=relaxed/simple;
	bh=/wRxiFcrWiOqW8q64xLfoFsDY2TulWllDVZffABcpxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVyJfqnUqfh4PQZfSFEu8OsuSm0QvhvQfz2igGK1qAmXRPgigMlIzXBL0AdFaEBKHPbZGHjf6g5i462CfS5eyKsCWg1f7vsY5cJuT1gdgMuW4I1BObC9ZnnvY/7SNndJgbJR4DRD8H+/lDU7R1I0s+5amZYC1BxP1DELDkdo/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TailwzOU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGhytE6X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TailwzOU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGhytE6X"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37wSHgLCLxgnXk3aQOCkCr85Fu7rflw6FXxEXGuqr/k=;
	b=TailwzOUY6FiPfl2Dd8HLPPlcPhWBZt67m2z3SmtpnVK5fgP8znUTae7C7aQ7LIM/SRNnv
	lZX4vKFkuKRvA0DZuU8hyG0qWJeXExUDg6sxLV8VB/nOf/NYErltk7/eoAtgg+2b8guKBD
	8XqqBj3JM59r//fWdmYKKtLF22bXBk9PkzlWXJgnQY7eHDE06/JfUcfdLZs2YNZwMHiPno
	mnAwFr26E+VkW1/sga3T9Q8ayyFHcZeMRGaqR75SQ3xu1Qnfrzf9hmfnKAyTbiKq5mW14a
	8caWSOT7zW2ksxE+1vDZhEJay4twoDnfpJN0q3SMweP2ZpTef4rux8aWArSrKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787750516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37wSHgLCLxgnXk3aQOCkCr85Fu7rflw6FXxEXGuqr/k=;
	b=MGhytE6XI78jjefixMAajVe7bOXvMi82+lAPJ+y5g7TRCZUOgOYAeQ47h+xlnr71WuCPJu
	LwMU4x68b+kHEUAw==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 1/5] rt-tests: cyclicdeadline: Remove unused `alloverflows'
Date: Wed, 26 Aug 2026 15:21:48 +0200
Message-ID: <20260826132153.2476006-2-bigeasy@linutronix.de>
In-Reply-To: <20260826132153.2476006-1-bigeasy@linutronix.de>
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

alloverflows has been added in commit 9894227feebf2 ("rt-tests:
cyclicdeadline: Add histogram support") and not used ever since.

The compiler complains in a "set but not used" way.

Remove unused `alloverflows' variable.

Cc: Crystal Wood <crwood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cycli=
cdeadline.c
index 0c6c969760101..f97344035ca3c 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -633,7 +633,7 @@ static u64 get_time_us(void)
 static void print_hist(FILE *fp, struct sched_data *sd, int nthreads)
 {
 	int i;
-	unsigned long maxmax, alloverflows;
+	unsigned long maxmax;
=20
 	fprintf(fp, "# Histogram\n");
 	for (i =3D 0; i < histogram; i++) {
@@ -661,10 +661,8 @@ static void print_hist(FILE *fp, struct sched_data *sd=
, int nthreads)
 	}
 	fprintf(fp, "\n");
 	fprintf(fp, "# Histogram Overflows:");
-	alloverflows =3D 0;
 	for (i =3D 0; i < nthreads; i++) {
 		fprintf(fp, " %05lu", sd[i].stat.hist->oflow_count);
-		alloverflows +=3D sd[i].stat.hist->oflow_count;
 	}
 	fprintf(fp, "\n");
=20
--=20
2.55.0

