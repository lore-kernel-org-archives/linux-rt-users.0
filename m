Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47E3093A3
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635733; cv=none; b=eMDLW+4JC99FiFG0AIvNKxV71tYgAFUmWqoF4O93CChN4Fr4YuQC7/4y8boUKbnybGQyyS45Lf5oMK3N5FzCZ7UK2Bl+ZUrGoaJiAP8R/eqCQ6frqDw0aKcVjtmhts+lnniCtcK0rJ7dBs2CbQhbMpQDLsaGFEIth9TH/QrPSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635733; c=relaxed/simple;
	bh=EA1vqFldM+HKB7uYMB/qcIzhDZpM0IWtXK4J4CWj5aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ft94malwsG5+bKz2yy/ebUsv8nLr/OpYXh8GVj8j/fQmG3eCqizw7qfRBk+hzZMuWeY2afxfotc06KFdUYuv0yiw5FM2xHE1jW98J4dPCzp4P0BRuIHPXDEtzJP8HuNLTMFXxoti7ku1Wx3IRYcDVys88MnfInqj9GezFC/jwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDC4s2Fk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4IQFzB/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDC4s2Fk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4IQFzB/"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7g/lWscxvvXucgvNdeDnXwn+2PynMaBxIeBNDS5SB5g=;
	b=QDC4s2FkSaFMZ681440AhMekECU+SUY9WRXeg8pcZOeaV3qA0TYv6uGD3OPjW7N0pH3Bs6
	uIFu5xVKvQ8lUrxlz+bp5Qy/SFp2KQ4Q5td+AlUgVYyKB+Ud3lbcJAu3R3j9qwrCZi6wyj
	5pC4zoPRstifA48lrKbLeK84QogwT0R381OJ/XsJNQkHiG3mMhYrzVxRdVY5FmDibyGexp
	6ZVIYMkpBHXDFkhA4qGCZ+dcFXEsAv9GIEizHAt82YT1iQRRq5KNNHp1uLZGWSi63E+PeB
	c4WidcARXtOAlP1XFIJihPsLNOP37Wx+yvuxzwdauC81NExBJ0kLLR/hogoyEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7g/lWscxvvXucgvNdeDnXwn+2PynMaBxIeBNDS5SB5g=;
	b=f4IQFzB/FyVapB+I5rh7w2BJ4/TBAROfedNXDdxbAX3Yf5++kkQsHngxjaOWXlfUpm66Lb
	jAccyrYqZ3GlLuCw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 24/28] cyclictest.8: System options: Deprecate --laptop
Date: Fri,  4 Jul 2025 15:27:17 +0200
Message-ID: <20250704132721.13325-25-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per 61ba1aa3a0db ("rt-tests: cyclictest: Add --default-system option"),
explicitly mark the --laptop option as obsolete and recommend using
--default-system instead.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index f320f66..aff900d 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -92,8 +92,7 @@ cpus.
 .
 .TP
 .B \-\-laptop
-Save battery when running cyclictest. This will give you poorer realtime
-results, but will not drain your battery so quickly.
+Obsolete option.  Please use \-\-default\-system instead.
 .
 .SS "Sleep-mechanism clock options"
 .
-- 
2.49.0

