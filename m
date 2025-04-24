Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282541FF5E3
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527735; cv=none; b=J5m12yF+TxK26lVlDw30JaNHeNNv0HdJSKhinJKleI3JwrElxGLYmOSR8NGdtc+uBvqaw5PaHDMyZ576jNrfETbgOXwZWro3efMzHFVJj/bzRSAWPUZ3qJ/qV6p1AvwpvX3D+sZ3KH4SZ3FrgIGusFWrbgY+pec325ct50iA81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527735; c=relaxed/simple;
	bh=WakUcBxcsqAQcoBKtpgslNawDMhYG5OshuOlvZolZ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncoKu99P4txVCTzTqa/wpr4sQm+s6//XyTEnmMEQEhf+qKW1J0lroDcDlGPFf+vmTY8i+VPy4M/SjxuIvHYwt8zL9xTSnOYo/qP6f6eVRQGD+X9qPCdWKxpyFTw/QKBBM2a56FqWVXrU4nPQDGaKcG2DUTnPSnSugNhzFxGzPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNRGW7L+; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNRGW7L+"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5e2fe5f17so150689285a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745527732; x=1746132532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du0N/XtlDe6uNRxifMshs0LCPncFRsfjML6yF9Oqi9g=;
        b=bNRGW7L+Hlm9HHm4JQyn9ngBTlHTQs3+MzS4oiBC7NdVWhx079ReJdSlHCInCWQgAw
         1WhGO7VZzs2JmYIcx9fPsl0F3C8FBeGKMfBiDuUKW6t4HQHtbjHuz7GOOb/CM18+mOWp
         Ze+IXqZT8lCjHuLqJSxNn/NQQQm5zL5NPnEbII4qV4DQcXvm7gtS/K45eG6ZW3rC66+7
         51up8jquezgVlwu0FrrHcXSezqgffi9hVLbIe0Sdf4n7tulugeTefkvxiJVZMVnhX8oe
         Vpnwut5C3oEMSdLJ8SPeQE63y6IisRaa2tW20t/ZAkoaoY3B0jAGshbI52RH1D1RXICf
         2prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527732; x=1746132532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=du0N/XtlDe6uNRxifMshs0LCPncFRsfjML6yF9Oqi9g=;
        b=buVPyzi5OBzJUSl6kByum90fOM8iW36+18Z9+WAibqk5bzhmQzoeviU/fTT2ahGXxn
         7e1iD5mFG/aRXEoaPePXJ21Wz1jChuhk2gFlWMRfnpDF39u9Fq54aaEzCHaCjZl7BY1P
         bM3RDh1S8lmZu2fLusx9SnDBYeNsVUi6TSmIzk1S1girW0g0FroFgjL+symt938oIGqr
         tau/WDFWWRy4S4Hd31kuy46b4RISWR0n9yeQbGbDkA+t5X0gxdx8iOZVgPabvMWgyTai
         F+PJd+ib8VkoSyMTgz4hLiBMBdD9n0AkldgWRGP6xIOxhlOWLvJeQxXsjHKgdBpHRAeD
         Zp4w==
X-Gm-Message-State: AOJu0YzpnKkKbT6Hg0YqoyL3huUrw/2QjTpBA6O6YpEOB7EqWo5Cou52
	nxrE08fEFmAwPu3SNHzC3oawmQS2PesJTVwgjQXl/TqxPIO0U5BPnZe/Zg==
X-Gm-Gg: ASbGnct+hfRP3MBWv4HC7rYofBfZAouoYTBB+RXjRm4iH23tQ2GgCqqqqYpRv3BChR/
	rL0JjyqM7qNhAS+1hqAO2UHInrFfr5fw3LRrbI7+Ei9S1OdGzwZeaWI+P5scZRc1e5jDz/dDH3J
	pM3LXW8zkMAr3BwA/p8W+y+A+13t4ZcN55SzxD2SGzFXXqQ6o8Efj5xZRyA+tE61lvRb65TORPS
	blPjyNiBrAyYb1Rd1Rpd19bOCBMl3pkv9qgtnb/YGctGRERaTqGp42zKoknHRgv0l/m4uOmeJMe
	Lqn8uBcphfO49tpNRUMtJbGgTz7l9G94dBfYwfl1D6QtqQ==
X-Google-Smtp-Source: AGHT+IGVbeyII94LZA/O6lj5QqDT8657EQdMh4VvvNGd/oSEy1zz7RMT83Izw2FQ9AuaqO+YF/uD4Q==
X-Received: by 2002:a05:620a:198d:b0:7c5:e92a:cba3 with SMTP id af79cd13be357-7c956f60cf9mr631568885a.49.1745527732104;
        Thu, 24 Apr 2025 13:48:52 -0700 (PDT)
Received: from fionn.redhat.com ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86c19sm130932785a.85.2025.04.24.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:48:51 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/5] Revert "Fix rt-tests build with glibc-2.41"
Date: Thu, 24 Apr 2025 16:48:40 -0400
Message-ID: <20250424204843.79193-2-jkacur@redhat.com>
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

This reverts commit d3a23a0cc76789c3083df3bad78982cd49bc4c5e.

When people backport the feature into earlier versions of glibc, then
the patches fails.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/include/rt-sched.h | 2 --
 src/lib/rt-sched.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
index dfd7f45f51cc..80171c76e0ee 100644
--- a/src/include/rt-sched.h
+++ b/src/include/rt-sched.h
@@ -42,7 +42,6 @@
 #define __NR_sched_getattr		275
 #endif
 
-#if ! __GLIBC_PREREQ(2, 41)
 struct sched_attr {
 	uint32_t size;
 	uint32_t sched_policy;
@@ -68,6 +67,5 @@ int sched_getattr(pid_t pid,
 		  struct sched_attr *attr,
 		  unsigned int size,
 		  unsigned int flags);
-#endif
 
 #endif /* __RT_SCHED_H__ */
diff --git a/src/lib/rt-sched.c b/src/lib/rt-sched.c
index 2500abde26e4..8023bc70c473 100644
--- a/src/lib/rt-sched.c
+++ b/src/lib/rt-sched.c
@@ -14,7 +14,6 @@
 
 #include "rt-sched.h"
 
-#if ! __GLIBC_PREREQ(2, 41)
 int sched_setattr(pid_t pid,
 		  const struct sched_attr *attr,
 		  unsigned int flags)
@@ -29,4 +28,3 @@ int sched_getattr(pid_t pid,
 {
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
-#endif
-- 
2.49.0

