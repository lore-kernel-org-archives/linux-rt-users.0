Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469AE2F94A7
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635670; cv=none; b=DdCLyAtp/4ovyg5T1p8YgNadN+nSu32vw8ELX/Oy2rGDPcHVHvOnqXzIKq02jnjf8hr61m64rd7FDfLEBfFfH3TUXMrtWJYmoJGIEu2jsRX1J9L5QVB9YH5YJVMCk/N2kyldZ/i6+X7ZQ7WQaBJjrkRFFC0jaNcs+OkM1+ZnvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635670; c=relaxed/simple;
	bh=F7ZcNwiNILO9poC/edkBmG7TK1J7Tfpr1YgxprbbzhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJXLNELK+cY7QHeN4adY0Y8n+WV7O6ob2SLiJO1Il7rztTwBW3wusuEjqY+WPZwqqFLxFRe3U8ihlN7+tfWKz9q4BHac4468ixUACp8Uq/CvKV7B8VIIH1ccKoSJVfZpKbXJWbaNGEJMNDtl65hvS2l2EGTAQyzIowvc8N1djmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=spZgnCmf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w7/4jluF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="spZgnCmf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w7/4jluF"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=top8pxsJduPhFuYUbKh7y86wvCWriJa8ZCO8ssCCPTc=;
	b=spZgnCmf6XIW7WxEJqQeAUXeX3D2yKzK32wXWuzxanKndPXhP3HA4TJhTPXeDcVy2QiC3V
	o7CfADKto1n8NrtVVZJAExfarX3G1tS2T6yzWs6LSMXymgJuSS3mlv0RUWiq3xnLQfszrK
	epzxSECGa8lCFGUHzjw39S+YkyQbXo1wmjZsSuHLdj9fBkLpxgSnetwrpFu2priplat76h
	kxkzqN3EwO/KXUuPKd52g3Zgt+1TeG90SM3CN/nUCmWiodOnE5dRX8KLm85VNAJ7l3Tqmy
	E6zcd2tMMeEeROetD4cwve5ZB0v5D8Orzg9lab3CclnyKMb4kun0ATPB1OL5Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=top8pxsJduPhFuYUbKh7y86wvCWriJa8ZCO8ssCCPTc=;
	b=w7/4jluFrOpmlhBYMuv8TlUU/BINrIivxUpoC4INep3oXVQJ1bLVAOTeVFtA7bieU4+BzV
	sVtUTG7NbElZzDCQ==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 06/28] cyclictest.8: Standardize --verbose paragraph formatting
Date: Fri,  4 Jul 2025 15:26:59 +0200
Message-ID: <20250704132721.13325-7-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of cyclictest's options are described in the manpage through a single
paragraph except --verbose, which renders the verbose statistics output
format in a separate paragraph for no special reason.

Let the description text of --versbose match the other parameters style.
Beside consistency, this will also be useful when all the options will be
separated at the manpage source level.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index c1a7b29..803c5fd 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -170,11 +170,10 @@ write a trace mark when \-b latency is exceeded.
 force unbuffered output for live processing
 .TP
 .B \-v, \-\-verbose
-Output values on stdout for statistics. This option is used to gather statistical information about the latency distribution. The output is sent to stdout. The output format is:
-
-n:c:v
-
-where n=task number c=count v=latency value in us.
+Output values on stdout for statistics. This option is used to gather
+statistical information about the latency distribution. The output is sent
+to stdout. The output format is: "n:c:v", where n is the task number, c is
+the count, and v is the latency value in microseconds.
 .TP
 .B \-\-dbg_cyclictest
 Print info userful for debugging cyclictest
-- 
2.49.0

