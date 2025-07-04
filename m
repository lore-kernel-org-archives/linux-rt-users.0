Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A127F16C
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635666; cv=none; b=BrKjzst7pfH09wWa4epgBbm1b4gmE5H/Z2M+F//ZAdmNQ1u+z1TPio5HBD75tT0ohAPnmdjRUAgeFzypqEevVsQqu27zgQlWjpqafhvyTy562y+Lqlsz+a2i3Di+U/zVb4mfZv9y8U/5FioZXD9yzvTti/9RYbFWGRZBJQswPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635666; c=relaxed/simple;
	bh=SVh8Ik/FUZ1ZbkuMmNMakubqlIXZFdEkV5PCf+Z6DOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOCrlHx9Jz+sIqD5FKB/mhnYyiHqhX/SHukdN+ueqezxZr5tvFqXi7fufQtCi23k/8erMFuoqmrzdr5YOLt0W72Rs4CPgSBFK8J0qC+46UrqM+9rlyfVNU4qrCtAvgpHA8fy4y5QYaYU4uUU0rBgt7m98EQ+dsAxZngJgrW6h7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T7nRaJon; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2KpKJvQ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T7nRaJon";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2KpKJvQ2"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqO5yx//Q5llcRyetqqJI5qHKmD0iONliBdWrQ1Kkw4=;
	b=T7nRaJonwWLXCLcDMAfuazmVy1hxP8KIPsQQkBJ0SX2576s+bWiDV7y8rusPJ4P6qIlqaR
	itrLn9U6xh2Nla5wY3EmilKRympqysD3zoBy47yaSQh/DSlSoLiXHVYk9hjobfR3uKotqH
	gb2TQgNz4NqPFS7ht/RsuXwp2ar8o31Wb/DvkG6QS7s1Isq3X65wA9ilTiEVOpUzaER9r5
	Hx2AEBgbJuniBhLsQzQfoLkwa4DLMSNJKsxtvxHXKsnEq/g6q3sa4m7I1lVL4imgJd6DQN
	YoQp6cAkUEjx1BTlHw3xgV+gB+y0KEd/dgMEQJc7+WFjgbwXvO16Qok6JdseZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqO5yx//Q5llcRyetqqJI5qHKmD0iONliBdWrQ1Kkw4=;
	b=2KpKJvQ2zRcYP1nyWpHPgyhgLfusihZeOOWqfzPT1BKQtbN8Hy02ioc8bRR4ztTcLuVTWJ
	VuaM52r5a70WdNBQ==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 05/28] cyclictest.8: Synopsis: Remove -h flag
Date: Fri,  4 Jul 2025 15:26:58 +0200
Message-ID: <20250704132721.13325-6-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per commit 79ad2eca9abe ("COPYING file and cyclictest's man page added"),
"-h" as a flag is an invalid left-over from the template the manpage was
based on.

Remove it from the cyclictest's flags list, as "-h" is actually a
shorthand for "--histogram", which is already documented.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 76b10f3..c1a7b29 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -17,7 +17,7 @@
 cyclictest \- High resolution test program
 .SH SYNOPSIS
 .SY cyclictest
-.RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
+.RI "[ \-fmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
 [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
 [\-p " prio " ] [\-t " num " ] [\-D " time " ]"
 
-- 
2.49.0

