Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5D27F16C
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635658; cv=none; b=mDCUE+rsT+P5W1dp7L4kFUaUr0akW3XBLufUhwWHUFpW4r8w3/zJX4ybZLgP+CMzNjwMGKgO2Pao0JG/ai3tnXhkFVeZjxBsPL3TdRxiec2TpescDB1ZD8Xz92ubVfaLr0h/MURPrLamAU19whINV8JRuRSABBYxg0jlkC7HynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635658; c=relaxed/simple;
	bh=oMUb7lIBYECUiSNuQnntLbAHjDAaqwliHx2TRaclzDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heK9piVAaNZPnaokEZhtHO5CYIaZUeOWJPMmdG/RcYvabS3Sm3iubbZXNSlfR+Xvn0kDkVcMSEaG54HtJggiTNXRUZCyv8/5rEMZF38Opxb/cCmdcf4rj+pCMSKzlv0mULVWlDehvOBPFMycbdWUPgshf9M8eK8MmLFr87LaYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gm6uo+dp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJiD+Ksu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gm6uo+dp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJiD+Ksu"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVDR4CcPPz0qrKYnKhZb9682YKUVHGI32dGtGiQPCLU=;
	b=gm6uo+dpvT2NbGVOl9aqyDGx2k0MqPTjtDehe5uHDxmBStKAaeZHdZzqp7sud25IjZ/OaV
	SC819PJUcdNicKBrNhFxp2KTOZqXMe/hJkS20m+pAWeNzONyLhZpH0aguhzWNgeh5gqgEE
	MPLnX+qsNgWRk//TCRFPYu7OGgVDzhtgoV5nK7n7pOBIwHEqIeAp4HUHjbkc7GXh8XDvyg
	GXLgwAOPOT8bfOzCPJ/OS8+amBdjsm2zRjx+yn/wzr1+1Xx6fEZVO+kRJESVXUm3ZZ3VPs
	oIO9Nd+sxqMnrQ0W5WL6OIpHLcjUZZ9Qt6TUuT/2Ni1m58r+XZOaXf1RQ3cZww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVDR4CcPPz0qrKYnKhZb9682YKUVHGI32dGtGiQPCLU=;
	b=wJiD+KsuAv7AIl4EeET5ZX8d2778sRxhkbtxyeAeJZUq/fMBs21u98L/LXp4kuZfmYalf/
	+pLyV1MkL+EoT2Ag==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 03/28] cyclictest.8: Synopsis: Remove -w/-W
Date: Fri,  4 Jul 2025 15:26:56 +0200
Message-ID: <20250704132721.13325-4-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 88af497ee57b ("rt-tests: cyclictest.8: Remove invalid tracing
options from the manpage") removed --wakeup, but forgot to remove its
-w/-W shorthand.

Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 35f7c90..312bf7a 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -19,7 +19,7 @@ cyclictest \- High resolution test program
 .SY cyclictest
 .RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
 [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
-[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ]"
+[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-y " policy " ]"
 
 .\" .SH DESCRIPTION
 .\" This manual page documents briefly the
-- 
2.49.0

