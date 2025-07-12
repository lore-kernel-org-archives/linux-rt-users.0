Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D727604B
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327762; cv=none; b=iogK6LR6GeqGGghjiROJyVz8na2eSqSuyj5S7UcL7Z5H6ujfGmoih1WVFYu1YwrlDNsIjF2zVibN1kziSGACNjDJYxqBbIwiRvh5Vlx608TJr8kEda7hnCTyWaumkIM0aLAouuGOKxhitChdxdVZZD/IAmwj+V23e6xV9c8+9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327762; c=relaxed/simple;
	bh=SThwHX8qqXr0defaNiKoGLW+Usi9A1CLCkwAy/jjabM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohptGyT4O4zlhMfwTeEWMlSJ+h7jfINWlorVg55Hb8Nz/r165BZwcbsBL8/BLdEMs5MNYhnEVQtBeTiLQHHvamr335iiK213r0gAoZ46cPzh6OkBUEYfyeZhtcWd1AF0J9TLJz/k+6VbmIR9eSLdZmUk//eZhaWLGRMdP5f2C90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVbE6tGE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVbE6tGE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23c8f179e1bso32228345ad.1
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327761; x=1752932561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cU91cfvpLEfcm7fPIdiOV8AmAsvqvyc+TWUH7E83dI=;
        b=XVbE6tGEBnqWwkFNJl4UNZZCBcPsQg8nOaDS+Lf28FHzrVcxoAEV5IwcEKN3C/nnZn
         naBhwRjXX6K8HrA3l/T2Xf42RFSL4qeLH2w8OdT4LqefWarEorudQkR8c6aXqY9IG4dU
         Y9/+beJmzRhPv4wU4PUmpKrxZT0WnsgQ+iMhMRQsTLlunbnIjCcYu5GIHcZmSgKa0Pkl
         bNPZaRppqnI9+o00FX/4tSkxtkewULybvq0S4rwKhBtXEUdNzjOPkXOj8iQDEwKOgGUr
         dC/jT8AtRL3savIV8Tp03fCkIzBJ/C3o5sAAb2yiTWpuUHqXOtfpcjGmk+WBGHPZfWTP
         NBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327761; x=1752932561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cU91cfvpLEfcm7fPIdiOV8AmAsvqvyc+TWUH7E83dI=;
        b=HCzbvF3GROUV8DT6FoI8UkObdg4SNkzIUgLFc3K84PA+nGHtdGnL3tuHRpPMzEVmRr
         Y3sbk06ue+8Hz4z4zp9L5C6Ovf0idjk/7OddsLPjQaUb2n46tYzc5Pci9fDGWUVK5Pg4
         qamBUOw0VDC+4j7elmhYXc4GsOCrhxEhCSaFlZN8YqeZuf/F/Ze9kl6DsbjY5le1IAgu
         Ib4fA3V/Un7Gt5dT+Pm4ImbPeWg3XH1IoqBl7FVUeftjl48IPhr2jWffueKIp3KqIyd7
         lwA+RKS/lWFf5qVa5pat+mWl74b0Ecq4YM0WFZCxT7A5BSo78rdcqXkmz3VEgklvF2M5
         F9FQ==
X-Gm-Message-State: AOJu0Yw8N6z0ltyBkZfZhOnQNAaOKDCGVoCQ7QI9qAALzu4JO84ZiR6m
	aaLaouHo2NMThT+lTLQeBhx8i+vplflQNFs48dFmzc3UlGFGbSzAraP2htAn9Op8d6Y=
X-Gm-Gg: ASbGncuWsmP4LXuMu8/DdwIewaLXSwQmW57aCE+MEmlPAWvUcyo7qTexeYAh14wfiu0
	Uso+k6pWKHniZhWEeJOAT+PMmEhXJnHyjbHIwNehZ1OQ6Omm7TY0uR2Kr5AwfQK+BdBrbY8L7u4
	jW0vy7JHst2pECOBSMzf9pOW9HSDL1mtUn0J6kxWXaVurrRdORpCwUNF7rNbHnYKxLJp19DkQmY
	XVkpbDIXmfgz48Q0p0CKGqinAS4MCPdbY6yw4zJoL1rjUnBOeBKvxycU7nzxqgFWNoH4/rYhVWm
	hIyErXXheLi84rVcjRXM+n7SLMoLOYSrQ7iF5FoQuI8q5XkAqssjDLvKHYE4fWoSxP33G8qjY/Q
	DcakbxzLVrvFA2aM/WXiMvvmYf4QFN/JeoqR/hKLNXJRVzKjMGbL8Yzl+CKdZUzw=
X-Google-Smtp-Source: AGHT+IH6v7ZbZbVL+DfEva8P8l+/9fsg5jie2fORINISGKhAliAjThBAV1DwNiIsXzJ4SqvjeFAFZg==
X-Received: by 2002:a17:902:f546:b0:23c:8f2d:5e24 with SMTP id d9443c01a7336-23dee17a3b8mr116299025ad.5.1752327760660;
        Sat, 12 Jul 2025 06:42:40 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:40 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/8] rt-utils.c: Suppress warning
Date: Sat, 12 Jul 2025 21:42:06 +0800
Message-ID: <20250712134213.58582-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250712134213.58582-1-yphbchou0911@gmail.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/lib/rt-utils.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 6bbd25a..18e515f 100644
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
+		warn("tracemark write failed");
 
 	/* now stop any trace */
-	write(trace_fd, "0\n", 2);
+	ret = write(trace_fd, "0\n", 2);
+	if (ret != 2)
+		warn("trace stop write failed");
 }
 
 void enable_trace_mark(void)
-- 
2.48.1

