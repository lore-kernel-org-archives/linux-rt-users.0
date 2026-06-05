Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6FE3793D3
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Jun 2026 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780693626; cv=none; b=bM/DhWzFtOEPtGdg1yVy205DoB1J/2wSipKpiGXSop/ChnDT8vIJ1nwxG7sLslpx8CFdzlnKevIOGZ7QEUb9LKOCVS43d3xIocwwoL1r5tNX1gQRK510nVq4rKWrsre7udJfjr7jzKVxWIhaDyT0iDHtPBohnVSnXEi7ZWtG1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780693626; c=relaxed/simple;
	bh=j2dRONyvfNLoyNcSd1qUzimRFu1+bE4KAjPLTH5Rl2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4P+r8BDE+KUir0/1O0MBMbrjfxJKHf7oQ95/4ldb/ExPZWrJiCsc5+K93x/hEmHWxCNDtKh13mQbIEOgPtCqDMG9Qk5hN6kIY1QB2nFa2BNWVzU6jWiy+bjREhNpIfiUYH7S56aS/aK1yu4OTsZkOQTPT3JPqlmBMdhsVgG1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9ZeTPiZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9ZeTPiZ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51788280e71so25163121cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Jun 2026 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780693624; x=1781298424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iuhjDZspSOStS79N34pO43/cwOUKBKSvR5ROfF21juw=;
        b=T9ZeTPiZ0Fqm/HNl8pqrIUtw4Wj7UqEDt6FCH/0KTvA/fECMVB/8x+HCzlkvxcuMhv
         EL6ND1Uqkbo8FIiX5CdDqMp8uZs9eHFvHnPgyj65UcxtX+9fUMUF24vwAHmu8uXH8jmY
         vQgbiJo8vwB5HP7k5BRlpaXwI9u4WclKtxtMFQ+HCB0Xy6G9iWou7NFZVgUymdjK249T
         8L0CqeGVtM5lzdDBXcNhHyDx8XG2UHn4ZuLjTaqN595pGJf2AwGqBb8CVF8nDRq/tH/c
         ZH1OZwlIvqHs0Cbd+Lsvw+gXNlo1HdCvWkawcg1VQH0D4HczZQEzHEjq7Mwm9gWmnPLC
         qygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780693624; x=1781298424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuhjDZspSOStS79N34pO43/cwOUKBKSvR5ROfF21juw=;
        b=ZnVen03pTVyXIof+hQaxD9xVG0eyo0rpIEZMqvJCyzL/wnPrgCWJp1oV1yIrMkx5MG
         5ObZAcR5pRpIoadH6FVyW8klddyLaJyPJTaiqk0Yw1SjAzJzCK6fQ3jcbEmC5R86ORls
         5pZwLUwLez5923Z3cXyeTq+iPIU7TELEUottNTvqmmFuxtNnhzMow5r2cG4+BfcYHR2f
         YfNbU5dsNeYVvMbpRiZngOGMM1qakwOIuumO73x1UFlunx7oTGTK9mXXr1tnatvFOakj
         7U1mNr1yTIqBjlBV2gYNQgX7H493xW6BPW3XIBfKmiuEf1QrGprtkqGv7Ge7PrEiVApz
         rxTQ==
X-Gm-Message-State: AOJu0YwJEyAgadYGOD3N/D9h0xM6Cedt4qgNGdsoPTpLpfaTkKpRwiUL
	nEA6PT0Acg6QM89jOsAPf2rY8RgsJosVN+TK1ukIaT5yjWic3HP4R8qk34rp2Q==
X-Gm-Gg: Acq92OFk7AcGMXhJd0xwukZQMSmcwdUwvTt0ntyPXzUSdZoR/HaEPUx1uB5HpYkW21r
	PQNz+CYuvIpoi5dSsPrCi10bQtAP099VDAsurAg9Nyo2OZG7hpfvD3i6yf42nVcMcz2ymPAfr9T
	Mf7TyE36T1NVlek6/akZKxc3Rz64Om+DD+Z96QlFuMe0yBvcoeyK92NEEw+WQWENCJxI/t8wKV1
	8UtPARpIh8S8k5jKdShK2yFqbA4psUutsmT5jq4rjcDFTvliKaaW0RRRvV0SUl8MKVD+T4tqzvX
	uCod+YRM3x8ekyrXNBvXFj+XX4YrVQpkial2VhRzpSefYUuqkzxpzk3vyoB3LS2X0GEu4tzHbIJ
	2QUaS57l8K5BynJUmf8SkBIo/9FI6KwnmyzfSccYqc5GMbFG0HPaCjVF94j2tZ6PHP9n3Rzo/j8
	0hElkmN+dK95zncLznEuArkbp1jkj3CjWrFH07z364Aq8Z7/y6byprxXeAYly4IOzyHa1l7vwVO
	dBy52mC/k3415zYfNTjIBbUFpYIdtDHrWhy+TAx
X-Received: by 2002:a05:622a:291:b0:517:5f04:f249 with SMTP id d75a77b69052e-51795bdd33cmr81318431cf.39.1780693623864;
        Fri, 05 Jun 2026 14:07:03 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517a1be7421sm9201771cf.26.2026.06.05.14.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:07:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 1/2] rteval: cyclictest: Improve handling of truncated histogram output
Date: Fri,  5 Jun 2026 17:06:47 -0400
Message-ID: <20260605210648.413231-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cyclictest is terminated with SIGINT during rteval shutdown, the
output buffer may not be fully flushed, resulting in an incomplete
final histogram line. This caused IndexError warnings when parsing.

Changes:
- Validate histogram lines have expected field count before parsing
  (1 index + numcores values) to skip incomplete lines early
- Downgrade parsing error from WARN to DEBUG since incomplete output
  is expected during normal process termination
- Calculate expected field count dynamically based on actual core count

This eliminates confusing warnings during normal operation while still
catching unexpected parsing issues in debug logs.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index a120a552da11..a1bf0d2d7324 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -404,13 +404,21 @@ class Cyclictest(rtevalModulePrototype):
                     self._log(Log.DEBUG, f"cyclictest: unexpected output: {line}")
                     continue
 
+                # Validate line has expected number of fields: 1 index + (cores * 1 value)
+                expected_fields = 1 + self.__numcores
+                if len(vals) < expected_fields:
+                    self._log(Log.DEBUG, f'Skipping incomplete histogram line at bucket {index} '
+                              f'({len(vals)} fields, expected {expected_fields})')
+                    continue
+
                 for i, core in enumerate(self.__cpus):
                     try:
                         self.__cyclicdata[core].bucket(index, int(vals[i+1]))
                         self.__cyclicdata['system'].bucket(index, int(vals[i+1]))
                     except (IndexError, ValueError) as e:
                         # Handle partial output from cyclictest (can happen on SIGINT during cleanup)
-                        self._log(Log.WARN, f"Error parsing cyclictest bucket data for core {core}: {e}")
+                        self._log(Log.DEBUG, f"Skipping incomplete bucket data for core {core} "
+                                  f"(expected during process termination): {e}")
                         continue
 
             # generate statistics for each RunData object
-- 
2.54.0

