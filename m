Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2F2F99B1
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898258; cv=none; b=Rcnj/rb9P3dPXUS4XAdy0OJoSmhTxJs3DyF0pE6deL5GTDGzMb5lfDTrd5NcLgDqkWAWPKQYuzDsBmyPUUw4jcbzB+tPAZWmuyzHurWO/BSyU1oCpti0JJKJ79bymJeKaasYgS5PRYBd/97C3WFspLtmTpPwth9ZRkjG4VGjNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898258; c=relaxed/simple;
	bh=QQDi8+WTYt0vYaOc3A++zpkt5qYySX3rKR29GX82zzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gyw4fkIlvVky9dyU0REZeB75hnqbyRPga5a34qQSJtzl2U9IPxVHQqkLb9OSJWAZTtyB2049KxyxCswlN5M7Qyl27T/LEf4crXTIIZ5g6nnCqWAJgCqmLy190QEmyyKeAGk+GtT/leDh3mxfi+21VLx+ceA6m3eKj6bvHS4xufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XXcPPz2+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pED0QmtL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XXcPPz2+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pED0QmtL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jy47UruQnOVshxVzydML/+vnRJL8IhjPTGg8PWJHhYU=;
	b=XXcPPz2++R//PzhFI/7xveu4kFC6Ip0NNj/DG7Mwof7dOAKNVlSPVYGR4ZVi5XJKJ1Cr5f
	v5sz/69NXtHMJ73e5Eb+TNe16bmNbpb0s5ReQJEu+hLeLGP6dl5zQ/WFmxQw1PWAAyUFLn
	wi+imFiBfxSfz06UAUrf9wpy8IoP0KrwDEQ1CY5eVdfZccjAerrKywSTyAXlWO0GTNYL+U
	QaVppRm/rENWLFpzJVqzq4M2WSQT3Z99otLSzn3zAtsNlRGP0wJsi1lEMgrt7/4zPiYtRh
	EEgv2QJN6nbUVeTDcTtswl+hLomA5yeOUP6seYvzkWxzyZaF8g+aM87NOyrvkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jy47UruQnOVshxVzydML/+vnRJL8IhjPTGg8PWJHhYU=;
	b=pED0QmtLEUCQ0lzmqFrlEuseTMlIxibvooMWK98ZgzUbk81tJtEVXc3hsPBv/0QdKZ0wgm
	mzt1ZW0C6pZmgvBA==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/10] rt-utils: Simplify trace_file_exists()
Date: Wed,  3 Sep 2025 13:17:13 +0200
Message-ID: <20250903111717.1391196-7-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass the tracefs folder prefix directly to stat instead making a copy of
it. stat() is defined as not altering the path argument.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/lib/rt-utils.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 0e6e6056a4392..294fc9683a122 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -408,10 +408,7 @@ static void close_tracemark_fd(void)
 static int trace_file_exists(char *name)
 {
 	struct stat sbuf;
-	char *tracing_prefix =3D get_tracefs_prefix();
-	char path[MAX_PATH];
-	strcat(strcpy(path, tracing_prefix), name);
-	return stat(path, &sbuf) ? 0 : 1;
+	return stat(tracefs_prefix, &sbuf) ? 0 : 1;
 }
=20
 static void tracefs_prepare(void)
--=20
2.51.0

