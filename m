Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0F7B3E1
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521527; cv=none; b=kmzQ1MFHoJYgu8q3hP/xrZL4TL8YtZxh/LFQh5zJNvPbHhhQZdGkOf0lEFPm1jjfuagP6wj7l/vu6CJKh94MN33l/2tqPeqBTTg9GKrI4B9Z8Ut4PO2jIuUhQpiVIrN4RrP55nFmDxdO3DsxTbodfK9k4pV+aztQKK/6xq3D6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521527; c=relaxed/simple;
	bh=jT8TjqBK8Ww2lJZcoMFYZ9ljNFEFGIsaXvmhI2EyzH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN4GTJpzEEnYdN9QQ7GwsnNqEvZxXbj6IR4jN5O4Jv/46Z7kTNwuXjCKkX0uevKYkm6nCQX3McdOJwZJOU4poniBjWob5U68fu8DZbXuAMlRLEZ1GUjUfxEnXivQj5N48qNNeA7ghhcrCqsLwe55bOCBea0W2AUHA/IN6P+lurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmL3QcHd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmL3QcHd"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso2611717a91.3
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521525; x=1754126325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8/O3ZQvMq/bBiPCwERGI7qsHDiQ7ys9KGkMZBQxCnw=;
        b=mmL3QcHdEQQmWrX6lHtehnphUQkuMQ+TnC676uHgWInJUqGuADhOkhlrIdQQDnVyr1
         lDluQ2X9npD63lpFqX0EHM4DATZRSmjlC24e6FPPPiWLWYj30fhze49DM6Kw/UUR63Wn
         j6yDml4K5/+IWLUuXCa0lUoIOkB1ljGSHjo9sM2a1z9pMjAcM8UC5XmJ5u8qpzcB2vgS
         jZyvZWd1gNPVQbsHaAW/ZuJakfPPwtFNO7TOLypd5anY/MAF+dRzZ6tNwbv6/SWEC8q0
         m9QVp5msMQH7KGihxcSE22Y86AUz8Mvgt+UAojtoywb2WdxGMvXTM80RFCoaOccWOuaH
         Fksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521525; x=1754126325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8/O3ZQvMq/bBiPCwERGI7qsHDiQ7ys9KGkMZBQxCnw=;
        b=q0Adzt+7HeuaWTv5vdLdUa1y3C74vIh8vYwqXuudF3udECzFCw7V+vxFtheqh8wKOp
         24eECWAhzmoP9zDIUU165ukCfGz5MrCtcDadt3++/HbYvxAQ8AX/5mJAr3fTheaoItCN
         DYf3sMKl344fMzkBupxryr/7au9SVlFaRQTbjozn7G8xQo3Z8etS130pkU2ZJleAvBM/
         etEN1og6H1KYwFYlOTVWu0Am6geaPkM1n3jrb80a1Ujf6/kygYn+nfMw2rbCgpY8wtGs
         iVKFFL8vnkKEMwqChm+oA9mSR0De8OKL0Md+JF2IO4UQa5zgok29JnEAY+ODa2/XSw+E
         MFaQ==
X-Gm-Message-State: AOJu0YzGj6jtTF07LPfEW4vCsqZ3iqV+fpkNAuLdxTGhYYRta5x3Njlx
	ioONC6dEqKMcXnQxNsJJYcbVf9Y0I4MT7OQ21rzaHsw8PvQBu5iQ/4yI
X-Gm-Gg: ASbGncueN5JVzvgUb2wQSjvjALs4Y3PEd9RBkoDZDATwPoYVRhjpoc0xWcE86k+xtF2
	LiKpuMfdEj+QDb/O86N5XbOU80KskdWoDXL8nyXKiEFOdWkhQDfF+zhzncr7hS6gg03xxa4Go2D
	mzYqFi505QIgBbQSVHfSc1R3HkCYZ/Y07FP7xhtlsdtg+r7qNHf8XtJqgyUFY3rrvTK15J7OVa4
	RUfkvallqhj3aynCwVKaBylKqPRaGk+6W4XoihgdujnPnk7PKkP7X7FH//cimIgrE9PJO5yLmvq
	IZG7c5DFiRx7hXhW05G6FBRVWhn/x1smKpdE9rDPLfJLTUTi6FQbxD4UMybQNwHRvbOxOcUq3yQ
	LvAYCMQ3a74OTkhfnwLa/ptXGl6Z9Iyz9/3Cw+hYVTjEapkfN6BU9
X-Google-Smtp-Source: AGHT+IGb5ZIpaL1n+d2vQIH7CVfi0i4Qf4/X3bUPYaOrfygeDALXxDqVIU7j5lVuqZMla4QIM2WC9Q==
X-Received: by 2002:a17:90b:51c8:b0:312:51a9:5d44 with SMTP id 98e67ed59e1d1-31e77730556mr7161688a91.5.1753521525070;
        Sat, 26 Jul 2025 02:18:45 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:44 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 1/8] rt-utils.c: Check return values of write()
Date: Sat, 26 Jul 2025 17:18:30 +0800
Message-ID: <20250726091837.493915-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726091837.493915-1-yphbchou0911@gmail.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error handling for write() to tracefs in tracemark() to avoid ignoring
partial or failed writes.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/lib/rt-utils.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 6bbd25a..447e158 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -465,6 +465,7 @@ void tracemark(char *fmt, ...)
 {
 	va_list ap;
 	int len;
+	int ret;
 
 	/* bail out if we're not tracing */
 	/* or if the kernel doesn't support trace_mark */
@@ -476,10 +477,14 @@ void tracemark(char *fmt, ...)
 	va_end(ap);
 
 	/* write the tracemark message */
-	write(tracemark_fd, tracebuf, len);
+	ret = write(tracemark_fd, tracebuf, len);
+	if (ret != len)
+		warn("%s: write failed", __func__);
 
 	/* now stop any trace */
-	write(trace_fd, "0\n", 2);
+	ret = write(trace_fd, "0\n", 2);
+	if (ret != 2)
+		warn("trace stop write failed");
 }
 
 void enable_trace_mark(void)
-- 
2.48.1

