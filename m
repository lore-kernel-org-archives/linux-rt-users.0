Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22B1ACECD
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527737; cv=none; b=k2gPtXs76YiwKDgRGyeFHXQ6xvMB9DNCtwKctaXzFzH4MoCh0ejNEi/CQyVaUNvMWuEys8MnllyAI8X6056ARRBf7Ez7iJGwN9TSCVXNsHZeY88ejOBy8+6E2b8M3aJ78yInCr9qmQTYrv7RJzOSv7duRhRzn0sECk4xFgztypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527737; c=relaxed/simple;
	bh=KERJuVi1vh6irlepBQ6BzlEEudCXBsrKa7kQIt2A6qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtO3BC44D7Wc5LrWbqHZaP79N6qvwdtamh3/LnkTlixoWOknV7FcWfAoeuNb/FTBPaW93HugNg3AfxJNSByptdN5b9j87S2DqJ8X1C1WPZO9HfIwHWwganLltww8gQJyKAYrcEfTlJHGvdkaaJ+Y+ZitraMMqRDmnppk0BNPDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1VCTstd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1VCTstd"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c597760323so169441785a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745527733; x=1746132533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va3BQquLexhHPsa/NNsY4YwHwIrYs46bYqJ3wgFW95U=;
        b=E1VCTstd7J2TQXOjfsfEFC/UQ098c51v1Fxw5rGBRzYD5avFkeXS4sEwCkloPqz/3T
         jrLbv4+XjRW11bdtdcNXbp/fqsU7MSGSAFTNlHeZvp8zEfBEGjpNlqLrAVkit+7tTEiA
         lrNeEu7viCHlGULoIayc8K7hnKePgM3gkXDEHaqqt68+smgZxtK2GPG2/I9GVHMFvbXJ
         IFLFniTOjqmvZ8bz/bcI0DPzBpMAQTwo9yvlhR3n9DOYL9j+dLN7rk/Ko0nMmyU6NERO
         sEhT/gOZDNWXG5b+364C8QYwrF8qTsbmVLp6aXnF5pQEIwd9OkX3i0cy6snz7lXAe833
         ybMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527733; x=1746132533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=va3BQquLexhHPsa/NNsY4YwHwIrYs46bYqJ3wgFW95U=;
        b=NhdZhf6GRzfOj3Lf1pPgatvizewFRy8362ac1I1cDrPUzHDWwxmIwUNw/4cP7E7NxK
         m826txIdBpfM3wVlaY8wZbl1PYIOAGRUdv/pKhOX1myP3LHd3364s1eTWsunonFPdGuL
         akyanLRk8XeJz0CkaEIS9Z5SxisBCUJhg2pUrh+j4s4a/uMh/dXwzN/DdtZ1UGDYiEzi
         BIPNLHwzvmNcdMWJVbI1XoKQqgo2qIsSFxWlA5xVjrnV4Mssn8z21rRfuctsS14GnMYf
         QjxVlW6o8X1hYrnpmliEZyar6dMh/HGjZ+hgTmODbZHhTuIrlN2gmwrqVR067ym9Ixpj
         ACog==
X-Gm-Message-State: AOJu0Yy03I/jJoW6i/eQ60T47NMJCPS5B9F3wyc2kczV4qQQi7Hj1n26
	rn1mE/pZATcM4HZ0vNOSIw26TDLNnCOsGsNcTKNQzBmJ1C5fPxh6psyiIp2w
X-Gm-Gg: ASbGnctsszZXtAW6xmoJZVKoDClFO80g0hpUWsDMWhMfijflb15tCR/LqLnqHQsFcyk
	F8VrK5TECxE4SPf7XIii6XfZUUvcTS0RBftB3NYvQVgIcfaN5DA/Ktft0maFaOMzve6WNOz6wgX
	82YEZtxRVr1fesL/gNO8fh9PBPL5jO3HD4vleBNsKRf9Qcz3/du0qi7fi9IIVU/t8axUeyFhC/R
	frSzNvQ1K4MxsHWc/jsgxkD7b0NtXepAx2ttQVWl9/WGLBMcVnSAogEWhRUAeike6u4aZzKR6dU
	pyrmzscyYrytIXcph7pPNjJ6B3VqaE7T3sYl+OwgkCP+Sw==
X-Google-Smtp-Source: AGHT+IEmtXBMyZUzEtzv8DHBvAt5N5iu05JwMKsfwAYfsZAyhsvZemBH0HorsiiEfhbYP+FSe3Ajxw==
X-Received: by 2002:a05:620a:4107:b0:7c5:95f0:e776 with SMTP id af79cd13be357-7c956eb32ddmr614175785a.1.1745527733546;
        Thu, 24 Apr 2025 13:48:53 -0700 (PDT)
Received: from fionn.redhat.com ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86c19sm130932785a.85.2025.04.24.13.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:48:52 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Khem Raj <raj.khem@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/5] sched_attr: Do not define for glibc >= 2.41
Date: Thu, 24 Apr 2025 16:48:41 -0400
Message-ID: <20250424204843.79193-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424204843.79193-1-jkacur@redhat.com>
References: <20250424204843.79193-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khem Raj <raj.khem@gmail.com>

glibc 2.41+ has added [1] definitions for sched_setattr and sched_getattr functions
and struct sched_attr. Therefore, it needs to be checked for here as well before
defining sched_attr

Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0

Fixes builds with glibc/trunk

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/include/rt-sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
index 80171c76e0ee..9cf0e3a937e5 100644
--- a/src/include/rt-sched.h
+++ b/src/include/rt-sched.h
@@ -42,6 +42,8 @@
 #define __NR_sched_getattr		275
 #endif
 
+/* sched_attr is not defined in glibc < 2.41 */
+#ifndef SCHED_ATTR_SIZE_VER0
 struct sched_attr {
 	uint32_t size;
 	uint32_t sched_policy;
@@ -68,4 +70,6 @@ int sched_getattr(pid_t pid,
 		  unsigned int size,
 		  unsigned int flags);
 
+#endif /* SCHED_ATTR_SIZE_VER0 */
+
 #endif /* __RT_SCHED_H__ */
-- 
2.49.0

