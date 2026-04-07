Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD538C411
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544696; cv=none; b=utFgSb60x9NLAiLNhRnnTXdOFBeHKVDD5tkt3vKHzQ/yBjuis4T8cpbDTWP8dyKlSQLtLEnjG5VcLz5u6m3u/nSnaGAdSZReMZK9igzvJWxEnjPjX7GZSee9jpMxUfLb8qxdXZcVcGogXdevkztqtUum4BSB1P+4SzWuym3r4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544696; c=relaxed/simple;
	bh=cDJNDZU3jaA6QMOkw+8LZNsfLjtFva2SvBxlXBdVnDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNL0av2Hx15YCvebTyxQPcG21n4YAdkPdxjUJBSWBeIikksl1dD1AJzdmn32/V/Yyxmg0PGIN9gUlbuqTQO0Jy2bGxQoEERI8K5h4tB5R7leuRO4pNcM4hJ/YWNiYdZEONl+vPe7BXvoMQs3aaMG0sPTGhnQXz/z5hqdQM7ntKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1z6I1Ht2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GvbvvHL2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1z6I1Ht2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GvbvvHL2"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775544692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlNhJLN2QRVPx50UY/0fKERQJ7/yT9sQ/dO7bb2hmRs=;
	b=1z6I1Ht2Uz/WIG5SNs8SsO7nNObLhYt3IXODikoHSzBF3xjCNnYHRXI7G5TNusYp3fNu7e
	U+57ElfX0WN086hKQGBBfjtbFrePoZzgofCIFT2GHI3r80DCwgokn2r4cg3gNhtOY/sgcX
	zgNSPumUQpAc0u3tqBHgysi3fgPEkiOYjBgFdsglCA0LH1NB4f5bMYIDO4zNkrOaOiqBUE
	RDqGCyFZbErLcRWXJoIaKOiJ0ede+zFzPBG1Txz9/7bxHwYBZ7X1aTUNKfSdnNgq9rdHZB
	4ovGRQ9uRByYBM/X4I2LJlgVwTiHcarPp9Zs01HccDeU0xqS4hlPS507U/XsLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775544692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlNhJLN2QRVPx50UY/0fKERQJ7/yT9sQ/dO7bb2hmRs=;
	b=GvbvvHL2sMEjKbAdpXw881JsINqKqUYCIgnHSFldU7Cx86QCl2ivFE2BqISP8Nr+hEBIPe
	WcS1UwxgAEuC4bDQ==
Date: Tue, 07 Apr 2026 08:48:44 +0200
Subject: [PATCH 4/6] cyclictest: Correctly print clock_nanosleep() errors
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-auxclocks-v1-4-1ef80d14eb0a@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
In-Reply-To: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775544676; l=1122;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cDJNDZU3jaA6QMOkw+8LZNsfLjtFva2SvBxlXBdVnDA=;
 b=3DHkkES96EjKKUjFp1l85s2hWtuOZBr0nLuuxn3lHKs4I3SAmroMelzK6C1517jqlAHdBDH6K
 Q9I9vir6pvICHSQLjr5PYkjOdWRBUsd0qVkpR6pMB9ceWa5OmeZrd74
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

clock_nanosleep() does not set errno on errors but instead returns a
positive error number directly.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 src/cyclictest/cyclictest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dacf0b7a718e..40da2cc4119d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -773,7 +773,7 @@ static void *timerthread(void *param)
 						      &next, NULL);
 				if (ret != 0) {
 					if (ret != EINTR)
-						warn("clock_nanosleep failed. errno: %d\n", errno);
+						warn("clock_nanosleep failed. errno: %d\n", ret);
 					goto out;
 				}
 			} else {
@@ -787,7 +787,7 @@ static void *timerthread(void *param)
 					TIMER_RELTIME, &interval, NULL);
 				if (ret != 0) {
 					if (ret != EINTR)
-						warn("clock_nanosleep() failed. errno: %d\n", errno);
+						warn("clock_nanosleep() failed. errno: %d\n", ret);
 					goto out;
 				}
 				next.tv_sec = now.tv_sec + interval.tv_sec;

-- 
2.53.0

