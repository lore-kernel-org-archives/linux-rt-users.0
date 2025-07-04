Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E92F94A2
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635652; cv=none; b=dBsvxamt+2El+H9HVtAX1LXog7DcvD4NPH83EO8Fu9gPMnulVQQIJ41ji1/n+aOf/aG4q6Ps5memaLE/6DqiHrbmhUyjnsLSzpsOI8E4SxCFqYUtBSgfwPTSK0Eh4deox/vZXSpZpeUhajSUgPqIeMtdSokq1BSM1fZHaP1KjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635652; c=relaxed/simple;
	bh=NrPKIfVnAId8PqAj3IJzd1TDEm5Bx2J8caoC91LpyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrwLsh+eKmY5h6ShVXwpXsbkRkfSkRxkv3TvzINcHxAQ223rkQIzZzF+HiklueKQQy+Fwy9AZ492+Wkdk9BSr1GwMqEdxQhbsGb1n9Dz/BjAq7JrL14i+XkisJC17o31vh5Rl+0oA/RpTt8ocmPITzC9hX5VYqJHzcm6Oc0phcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=czRRgJoL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GtzQoEd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="czRRgJoL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GtzQoEd"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzdgN16iEZGsNYozAT+IO8SIawpC3wlQcrDaqgNSDOA=;
	b=czRRgJoLjgyzq0+2bQX+yhewiiagsaGBmUXzxSNlU5OM9ssykxev7hA0cSZOVCzEhzG9wo
	JNZLPAGiwuXjamp6J31Ux6NFmzO73HjdpmLCB3V1dVjcMUfO9m4y+DcMtGFEIq5/ms+s0i
	XtusaTXy8Z69oi0FHUtec31dWt3QCTtjg7PxxTLh7qKkI2+UVQAasDIm2aREYzdcUfOVuU
	faOC6jUnKrl/QbgzjVHrNd4CvKl1kMDrGsLNJKXxAz6pALIoRi5gqQ6OKl3RjIsRsEMm8p
	JE09k3MW4QxV5W1wjZJPR6O6vy+Iqs04GgUfFOszKDwr/5cU4vXb2JLbp4VSqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzdgN16iEZGsNYozAT+IO8SIawpC3wlQcrDaqgNSDOA=;
	b=0GtzQoEdeL2zIoWVAWbO704RZuqw+Rk+htjVWMbhpuRgjQlIxrkM1KNVlqDHUvTmPTMW5b
	JVvTckjR6AYcOpDQ==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 02/28] cyclictest.8: Synopsis: Remove -U
Date: Fri,  4 Jul 2025 15:26:55 +0200
Message-ID: <20250704132721.13325-3-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ea837b01d7e ("rt-tests: cyclictest: Remove numa from help")
removed --numa from the manpage but forgot to remove its shorthand, -U.

Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 2871daa..35f7c90 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -19,7 +19,7 @@ cyclictest \- High resolution test program
 .SY cyclictest
 .RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
 [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
-[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
+[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ]"
 
 .\" .SH DESCRIPTION
 .\" This manual page documents briefly the
-- 
2.49.0

