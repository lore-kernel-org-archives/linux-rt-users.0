Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD213A1C9
	for <linux-rt-users@vger.kernel.org>; Sun,  1 Mar 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772400287; cv=none; b=nWIWY7Dt79ytGC5SSteraDqOJWjs8a6uoDJqYYXwZeoe6nOHIE2Z8Cft9O6xbBxsfNDYbR7KylyHK+GnkpHUfWFNEGCMe5Id51WKVmIZrvFirmofqi1AmrpixwiZIhUyLn49l/7lSps1zY3aiAoLPS52dzeEyOcRYnJLMt1Hu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772400287; c=relaxed/simple;
	bh=kEE+/KuXSjzYr9GUpBkfqX1gDdYkIsRm0I1RzjEWZIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP4/Vok6LnHR7ihnT+4fCmZM0Ubg9t6YxhKAt689Kt4iAgv0pk2GmkykDUJ2nvit/Db0uqwtk8/5WYMhoRDEa8kx/LKBQvViWhWTHPxYUXs8sGvlRqQxEzu5SDrVXShwoQEQwehW3IYkkH8vzNWwjVYQEGk6Q3eQSlFVjb0RpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CsvlNXD7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CsvlNXD7; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CsvlNXD7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CsvlNXD7"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fPFSj6Yszz9t8W;
	Sun,  1 Mar 2026 22:24:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772400277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rGWY1ffycmOL6q4jrBblpWgPRXFpGryyYXLJ+wQO80=;
	b=CsvlNXD7Qz618C3k1j9E05TkqFZCSObJEAwBwRUwGiGNcNdMQKG3j6pNSgRfjCGkb2tZzM
	yx7wTvifo1vz8yNCk6ELV1MG7+MFmkhCfzVJEB5JcYCNo/8ujeogtTYV3OinEYH0bCjTXM
	jlxtzqNb0oVpfzlAsCCzR81zl8I+59iq+F46UWgaf1fs6Zja4UVd77hQ8fRxam+tqHWWXq
	cGgv+tlxG+ekj4O/xcJCLGWaKPDuq4pwGsCBXaZwc0bnCh+Xm4HOqYg2hTUxiNRFbbhh2y
	67IH9x5VyWtRdcCTPOx/uWhNNVj21K8v9k9CUtN3ArC+HhV5B28mcuXzdno4/A==
From: Lukas Beckmann <lbckmnn@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772400277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rGWY1ffycmOL6q4jrBblpWgPRXFpGryyYXLJ+wQO80=;
	b=CsvlNXD7Qz618C3k1j9E05TkqFZCSObJEAwBwRUwGiGNcNdMQKG3j6pNSgRfjCGkb2tZzM
	yx7wTvifo1vz8yNCk6ELV1MG7+MFmkhCfzVJEB5JcYCNo/8ujeogtTYV3OinEYH0bCjTXM
	jlxtzqNb0oVpfzlAsCCzR81zl8I+59iq+F46UWgaf1fs6Zja4UVd77hQ8fRxam+tqHWWXq
	cGgv+tlxG+ekj4O/xcJCLGWaKPDuq4pwGsCBXaZwc0bnCh+Xm4HOqYg2hTUxiNRFbbhh2y
	67IH9x5VyWtRdcCTPOx/uWhNNVj21K8v9k9CUtN3ArC+HhV5B28mcuXzdno4/A==
To: John Kacur <jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Lukas Beckmann <lbckmnn@mailbox.org>
Subject: [PATCH 1/2] cyclictest: fix growing shm stat file
Date: Sun,  1 Mar 2026 22:24:06 +0100
Message-ID: <20260301212407.3146506-2-lbckmnn@mailbox.org>
In-Reply-To: <20260301212407.3146506-1-lbckmnn@mailbox.org>
References: <20260301212407.3146506-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jwz16gb1ifhku19m4he5g4a7ic5sy6x6
X-MBO-RS-ID: 863561624f14639a75d

On a received USR2 signal, the current statistics are written to a file
in shared memory. Before that happens, it is truncated to zero to clear
it.

However, currently the shm file keeps growing with each received signal
because the seek pointer is not updated by ftruncate.

This is fixed by calling fseek after truncating.

Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
 src/cyclictest/cyclictest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 191945e..960c905 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1472,6 +1472,7 @@ static void sighand(int sig)
 			return;
 		}
 		rstat_ftruncate(rstat_fd, 0);
+		lseek(rstat_fd, 0, SEEK_SET);
 		quiet = 0;
 		dprintf(rstat_fd, "#---------------------------\n");
 		dprintf(rstat_fd, "# cyclictest current status:\n");
-- 
2.53.0

