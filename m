Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC972FCE25
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635741; cv=none; b=Vmy32U3gj+VId1HmbOMj25Q4/VnLoe8oHgamemAFlSkYbqR8kbcK/RczM0f8a1/L0eCX3zW7s1prRsNrcW3Y2YF0He87YoRKiQ70cKQak66KA6NYW5tdc5o/ZPZDHVwQM7HHEAz+bVwGSXtlHb+by9dgDjyfb3BWJYD02KYftbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635741; c=relaxed/simple;
	bh=Oj3BxIohfML2VnMXpK5tFuitz6tsniTnOHlbI/mgAS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5XBJbsLFp1/1KA/3ML6166vnHCYzYtNRKEXmkCZCW2Kteoalik3AwDiTvRNnFWahWS6pUWOpoRL5+gKSPm/mj5rk9q/Zb4Bk78WJf6GSaVCZsUOaYjE9p1FQKtkSK11WgDqlcGL5431Wc2mLGPpKEB/p25uBhCIqyT9guj1wV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b+oDqDJq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c4wIFZBe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+oDqDJq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c4wIFZBe"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Irns+6rhDTZ05/3cEEB0DoANVTK1AVrITUlhSXgDPQ=;
	b=b+oDqDJqPffzHFX8B2p4g1XCpsj6IlY6GNVy0Hz+s07C+8MOBWLLfpZL3wSIC6RGvkfhH0
	HGmzTjju62CujvIpALNuikXP24PchWDH4Wdh5WFFtu/vD3qGld9cEU2u73VdPHItoG3O3s
	A/BHqnRHVJHk7GabADXN1+UbIPVXQlWBRMJ6cXoofyDdANJ+C32fDkdpx4Zt4hh59Fw4Ue
	Xo2m6UPRq+tzYB7R7UN4OOCH+pI4woEJ4zJNg1mqUlFY9TQ3H/QjPxUjkvlkKuwtJ0NNBf
	LY1iYF8zmurYaZVvZuVXim6vvdPTL/rZTp/JnZqAdY7Tl9dHPlVl5rYLqOedfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Irns+6rhDTZ05/3cEEB0DoANVTK1AVrITUlhSXgDPQ=;
	b=c4wIFZBeouoj32D6EBNmil00YTcwsEbLftH7oDYsY6iaxe0ecozmPXa7061JKe8sgItnFk
	kqCkZAaTXWTx/vCA==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 27/28] cyclictest.8: Add example invocation
Date: Fri,  4 Jul 2025 15:27:20 +0200
Message-ID: <20250704132721.13325-28-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cyclictest example invocation, while warning the user that testing
a realtime system is hardware and workload dependent.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 12fb9c1..16e8190 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -291,6 +291,24 @@ the count, and v is the latency value in microseconds.
 .B \\-\-smi
 Enable SMI count/detection on processors with SMI count support.
 .
+.SH "Example invocation"
+.
+Testing a realtime system is hardware and workload dependent.  With that
+in mind, below cyclictest example invocation can provide a good start:
+.PP
+.nf
+.B cyclictest
+   --default-system
+   --secaligned
+   --interval=250
+   --distance=0
+   --mlockall
+   --smp
+   --priority=98
+   --histogram=1000
+   --histfile=output.txt
+.fi
+
 .SH "See also"
 .BR numa (3),
 .BR numactl (8),
-- 
2.49.0

