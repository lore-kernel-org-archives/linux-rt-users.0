Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA82F94B4
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635694; cv=none; b=VKW2wMBIueEA2+SpTZFoSswB0gp0+5CZffCd6sLB2I4CI9FeiWr6wZFbG095VQyZvyUT7BfzKafdMCSPJTxXkZnm8Nzg+iuzvAn//WoPGNACxh6ma7WDYT/XOJzE04YdfGuttG0OgO5xwOQizV4DhHPigHM00xxKcwe6ORp8Qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635694; c=relaxed/simple;
	bh=ay1XM+0og9pVmzLygqCjeFIpMndg/x9W61jW1qOsu5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1yx6Imcsm76JGlusVSaPLYvPxUk6Nv2GD2XrmL9hxPNlw96rpgq6gPKvXD89uD3qN8p1eFaYMVhepO9t7RCIM1oCCvO5+ESzZi/6K90JvVDHIkMmsu2hIctWKtdlz4pUKAIFvEr0DenW8i6miPsvLJrU97x85LVkhDPZozXHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rDDYAOa+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hu7Czsl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rDDYAOa+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hu7Czsl"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqMnMnUQd9DJjkxJI9nR+r8oRSXcDGQdaa0q2prAd3I=;
	b=rDDYAOa+Z5bvQwYJpu6Gm1jjPwiHqlZRGdv4/fdQHjg+WRVCjXAR6NdnAmf2czQPIwmXa7
	l6uh/CrPOwzh2anw1ohNs+DPVz/VoGrrOuXBkiIBOPSzOsmt5GN03S0OU6uaYdtklnMjAP
	J4SgzWeMpEFsQqXbatfXY5fy2CC5ru+7iK3vnXZCz+T1WSZY/I3DfF9DRZPzLt9fItV3YX
	66C8uGZYXSSBj5eLuR3LDASIkc2vGrb53wBqdXKCQpE9m+V+g9Cq6TS5gSbZJ+9JQnpE0C
	DL1k352WGjTwgb5ZVlAma30JACsflGJkahjUPCa4y51f2DxULAeB7P5m/2SzNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqMnMnUQd9DJjkxJI9nR+r8oRSXcDGQdaa0q2prAd3I=;
	b=1hu7CzslB3FLjVHnc0rqde0yfpY3IjoY5mMbqy1bpSILnzRq09V5DweI9wZefSYtQR+S86
	OJRXO9OEw7YAGxCw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 13/28] cyclictest.8: Synopsis: Distinguish --help mode
Date: Fri,  4 Jul 2025 15:27:06 +0200
Message-ID: <20250704132721.13325-14-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per groff_man_style(7), different command operation modes should be
distinguished through unique Synopsis (.SY/.YS) blocks.

Distinguish "cyclictest --help" with its own section, as other parameters
won't be recognized when --help is passed.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 0271f5c..1fd550f 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -6,6 +6,7 @@
 cyclictest \- High resolution test program
 .
 .SH Synopsis
+.
 .SY cyclictest
 .RB [ \-mMNqrRsSuvx ]
 .RB [ \-a\~\c
@@ -61,11 +62,14 @@ cyclictest \- High resolution test program
 .RB [ \-\-tracemark ]
 .YS
 .
+.SY cyclictest
+.B \-\-help
+.YS
+.
 .SH Options
-These programs follow the usual GNU command line syntax, with long
-options starting with two dashes ('\-\-').
-.br
-A summary of options is included below.
+.
+.B \-\-help
+display a usage message and exit.
 .
 .TP
 .B \-a, \-\-affinity[=PROC-SET]
-- 
2.49.0

