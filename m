Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DB3074BF
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635729; cv=none; b=bhN9QHH4K5b8ERAF8Khqzef7vIb2YzhSjgkfJ4plh9vdZmokgMjXLk2Ag8bQ7U4U3H7NpXeQr1Yq143Y0Y2Qnp5zl2PWO4jbu7EsfPwC25juTXDOE2GmbAEuVeaQHw0TqekIPAIT0dMqZ0SkWFzcBiROP4xZqxSHM/bpAhgaNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635729; c=relaxed/simple;
	bh=6WsPxuaQKPPj2OyR2mPi6hIQflsrHTocxj4pgedmWjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OO+3Tprkn5kqwNYKR+G20IOojVvrX0UMh8pJjVegoKeSf1LvmcJ8+QDNSkmLAgCJHHNSurzw5lSqUPnjgDIm9Jolofd47JMxybat4NntguOL6gEoPYP3rJqb4KTB1EQEr+4qRwEtCuS+OVzPhsCAsHcUqcwXHOxMaCrvr69Fbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4YITSjgQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8hUvJZ/r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4YITSjgQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8hUvJZ/r"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41LUD8ai0VffbKmgBNczkpSiMkcd+cK8aLeEh7KMEIY=;
	b=4YITSjgQAvREI+4WWcKKcxui0mGqHrMTKshW9j928Vku7+SgkB5J+zUbeyiu/0cQMmPxj/
	6TjIZMe/KA3NmyydPV82btcMgoOGuw/zEZYrs0YcxJJ4qK7bnKQxpraykBqVpaH4tjezxX
	sUD4yYAxewyRGnxUMt2CDCxuu1VxTOzrDP5hJO3z1TofEN697pl5HZa2h4k6vs/efHgp8Q
	ZY/ARuk7MGO55UppMRrZN/aw28o2FIiNppuGCdkZwyMdChuR2JPO/u476FMUWVSi8mJY0c
	/GdsEjHLit5ovDbiYd+yZupxgINQc/8QYSLREnv26nS8+J0kW5K8bqc+pZbPIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41LUD8ai0VffbKmgBNczkpSiMkcd+cK8aLeEh7KMEIY=;
	b=8hUvJZ/rdIrx5akOeEd1HcFkklO/6NrZWOCDt22L5UTTK6q3ozmofkSU/kEoyAEeB1SzIm
	S7TOdVnzMXcwuQCQ==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 23/28] cyclictest.8: Group x86 options
Date: Fri,  4 Jul 2025 15:27:16 +0200
Message-ID: <20250704132721.13325-24-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number and breadth of cyclictest's options is huge, and just
exploring them in sequence can get the manpage reader lost.

Put the cyclictest's x86 options into their own group.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index ca75884..f320f66 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -280,7 +280,7 @@ statistical information about the latency distribution. The output is sent
 to stdout. The output format is: "n:c:v", where n is the task number, c is
 the count, and v is the latency value in microseconds.
 .
-.SS "Other options"
+.SS "X86 options"
 .
 .TP
 .B \\-\-smi
-- 
2.49.0

