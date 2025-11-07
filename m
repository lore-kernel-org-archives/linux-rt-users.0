Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3EA339B56
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540037; cv=none; b=oSSDRrwI4pGJXtJ6o3fHVf20nYq49S4ZcVf+fUtCwJVv/ubYxJmmaakZok1nK/btK9pPQE+dX6AQwUujJXFQe8ZAG9l3KloN2Z5tOIZpx5Hd6BpSYwrQ3Jn760lEjj5RR1JelRpjKjrYjRdulviKCl/CDUCpvfbSoVrAlqcyDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540037; c=relaxed/simple;
	bh=MtP/IfKjrB05jDlQVIXi4rmF0qBZ9wSJwIR8rAPoLoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nN4ltZENI9YV4gXo2U+Nkr4vzfN+G7XFefiPEwQ6U1QL5ccz2mn2vdCmM0ixtSSvYzP+GY38XlY+b1SUeADo+lSLNO9mpTF5an9VA+uQMhuV+P+VPyuK6SdAzTyFkUskZ1oXNqbcHWBf2SPa5EO4sUGEASSdBf+4gHPsRXD2f0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2TZApeJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2TZApeJ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-891208f6185so81189685a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540035; x=1763144835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkbwA3IJdqipqvhgwOJ7VGRVgnvAMzlHg4uxh+XcMD4=;
        b=W2TZApeJ4xbVHcq0bN0BCV6NSMX+wqm9R/HWDTCiVN3HTbrjihwSdJ4El4gwvNJS4H
         5Y/HD8E9HvvDPN2Jtku6m0de3v9leZqpHE8axPrZm7/Deo5uRe0epGDTIO6qHvdRESMw
         pawO2b0xvb/R1PWQjOaDUBAMYiZxzw1jJlILoSfcX/pfNQPaIfQT4gqCUALeR8HJcyIs
         b53tvTPrUEqqhycl9fv3iVWkoDcwt0EcoJIKu72bJu8ZX/tXeExPOX0LdM2wPj/5mMgo
         VjKQXFa2s//2OmqJ9UL3Bw4ik0XdCqmf8NJ0CRN3Jlm7IKRFo9BCwooqrm+dld4J8D/4
         FewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540035; x=1763144835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkbwA3IJdqipqvhgwOJ7VGRVgnvAMzlHg4uxh+XcMD4=;
        b=xOx6Yf7GmkWvMC/xS1t7uvZkCRHWbMCL/AoWo4rhjghsTZatwkQ7vPkUlMLzXVJyhS
         QSbK6OGPT5LvBaRvPUtFnCjoLR3XS1Cr6eIPvIvPg8YOYZBZC5dYowyNZrweTjavHO+F
         2dfKNlxaPn+V83YYYrDIkyHYaz85FnUAcLNDozn3pkPmDDycHmN+KGY9JxmeHgUh9iQi
         PZIClvnEldENknfU6U0p3qpzdY+51xfveu9D/1/7sFZ9k1B3ynWaItFX0O/9MskZYibg
         13EGbSgupU2/sNrjNq/A0aWV8Gugy64jUlEwAnI3GHenMQ7GxZAQfk0/EyH4jQJUdfKn
         i2Hw==
X-Gm-Message-State: AOJu0YzbgUF4p8NKCNUhwHakhUvoOKMD+2IokssAkX57yaLAejhodW9D
	634wVXy/OY96NQHINIXh+m32z6mMEZTlIDdJrvlCeHjr4Jyb57hr/FgMZ+vPi6BG
X-Gm-Gg: ASbGncteog8CGnOX8XqmC0vc2OCKfJTie8TEXJVjc9pbHLh9kXClPTaDswxttKvdT9S
	dqeDDhonIqaA+fa2hdZJjlDxQymcv8ZcX5yd/x1a8bbJvq+QxORWJXdJ/Gaf/VMtG9cVb4y35wt
	59NxOMN62RVmWNTcldjDFm88L+2D0qDG0Xfge987mA3co3WkpG0tPJJhHusFnOeBHOgYGggioG2
	p9l2hhagitJ73lm203C5Qw8s/jHRspMyoYncuNWPNU1U8Rm9+gQ6iz04pMgugVxbpAMcsvua0ku
	KIdJRk3+6/P7b1HL/yoZ1SglNRjsED7uAWrhDvPg7D0PGLKTxhKlHfEgwtbuSaDX3opR0Ter+kF
	Ruj1QUJLfAhKZ6JzJ98adsDcfsRGCxGiAnhwzTkg+cpndFJcwT6j6ZLWhO3+mCOmJ7FO8vhPe8A
	==
X-Google-Smtp-Source: AGHT+IEZm2P2BKY+dhqPPfZTxIo+Ig4D3GONLiuQ3pb69JZvntAd3ETuiZWAEHCmH5SvneYLXTcimw==
X-Received: by 2002:a05:620a:1a90:b0:893:398:485e with SMTP id af79cd13be357-8b257f74639mr30869685a.67.1762540034717;
        Fri, 07 Nov 2025 10:27:14 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:13 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 07/12] rteval: Clean up MANIFEST.in and fix newnet.py copyright header
Date: Fri,  7 Nov 2025 13:26:30 -0500
Message-ID: <20251107182645.19545-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary entries from MANIFEST.in (rteval-cmd inclusion and
dist/ exclusions) and fix the copyright header in newnet.py (remove
duplicate SPDX tag, fix missing email bracket, update year to 2025).

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 MANIFEST.in              | 3 +--
 rteval/sysinfo/newnet.py | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/MANIFEST.in b/MANIFEST.in
index 82560a8f957b..fa6ed3ab7de5 100644
--- a/MANIFEST.in
+++ b/MANIFEST.in
@@ -1,3 +1,2 @@
-include COPYING MANIFEST.in rteval-cmd
+include COPYING MANIFEST.in
 recursive-include doc *.? *.txt
-exclude dist/rteval dist/rteval.8.gz
diff --git a/rteval/sysinfo/newnet.py b/rteval/sysinfo/newnet.py
index 5dd95ae94e19..07427bb27771 100644
--- a/rteval/sysinfo/newnet.py
+++ b/rteval/sysinfo/newnet.py
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 ''' Module to obtain network information for the rteval report '''
 #
-#   Copyright 2022 John Kacur <jkacur@redhat.com
-#   SPDX-License-Identifier: GPL-2.0-or-later
+#   Copyright 2022 - 2025 John Kacur <jkacur@redhat.com>
 #
 
 import os
-- 
2.51.1

