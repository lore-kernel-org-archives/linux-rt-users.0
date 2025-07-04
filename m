Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FBD2F94A2
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635650; cv=none; b=sNLDLPYSe0Qd3ORteBNRDWbz93vy9LgN+kfzVF4F1G2VMl0z2DaiyXbXN0uKsntBCKJlU6JIh2ukRKiXUoNp59UAeg9KHXqbsFwIhdQnCHHk/NrwxEmI57WmJYJaXoJwfTKRqccB77VHYYk/Ot0hQbNRQSCrX6X1QucSpQYatPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635650; c=relaxed/simple;
	bh=cJJkQ0q0kk6+U5OTFMiBVK/Zgw6nhd9uxGTFw99C+/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huCDRsLNHj0KxBRSP4EFVOHT1104XOMtjjyjOLt96utx0IUoRvGJcEfYdud8t6Rsk8eeuQMLr3IqKls4e3ZqCtqIJY2x8ZPu3e2jyPG4TYv4wszbZoeVtRQvCofSu5mHkvdUObsf57JQ9iWO1HJAiBq4zHoS0jdr4atOc9MMGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4TOYvIp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l3ilKdxM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4TOYvIp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l3ilKdxM"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOiabJ83eBUofhSY9GW0ddNFfNh65jFZXtSAsAzXujc=;
	b=l4TOYvIpP5VfpECwZSY4CbCYATdLSqODp2l5PfclA2vPDyUZvp2vetwuhkwvhgYAZk2DFN
	OgToBAJws8p7A5RtuIIm2zPLntRhEb6ip6vmRw/MPO8kwFHB1LbhaNVGr2X2UGH1jfdy+V
	89oRmy7BveFh+u2Zo+ZTkgWgmWN6S09MTnYbLt7pphQkMl6kFfrxLfFXL2b0OgAVVZuVXQ
	51gXkrDuaIlBApkb896dDIFNYlkfm0DRA/jnd8Ft5axARpuTFHUG2dF/AiqnsSKObhoqrK
	jl4+VfXcB0D5S1lzQwLihDJ6F1BWt9dLOX9M4alBscB5y5+JLhir59hAL76tMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOiabJ83eBUofhSY9GW0ddNFfNh65jFZXtSAsAzXujc=;
	b=l3ilKdxMVd+4CBAY4b3emffkhOkxhDeZjRsZ2hzmf0/QpfBGSE9QfAAsdLPczUNtIVXNN8
	jUYp4w7jaOWdzpBA==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 01/28] cyclictest.8: Comment-out SPDX license tag
Date: Fri,  4 Jul 2025 15:26:54 +0200
Message-ID: <20250704132721.13325-2-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPDX license tags are internal source code markers, but cyclictest
manpage's SPDX tag is leaked to the output.

Comment it out, as the tag will still be recognized by standard tools
like FSFE's REUSE; i.e. "reuse lint".

While at it, put the SPDX licence tag on top as this is the common
convention.

Fixes: cf75a53807ae ("rt-tests: Add missing SPDX licenses")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://spdx.dev/learn/handling-license-info/
Link: https://git.fsfe.org/reuse/tool
---
 src/cyclictest/cyclictest.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 6becd19..2871daa 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -1,6 +1,6 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .\"                                      Hey, EMACS: -*- nroff -*-
 .TH CYCLICTEST 8 "April 22, 2016"
-# SPDX-License-Identifier: GPL-2.0-only
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
-- 
2.49.0

