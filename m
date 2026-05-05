Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F03AE1B9
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003076; cv=none; b=Xfb033ykEtkYUoykhhNqSBwi1two/gqkmkIMBo8rYXsgHdQWedPLo6rPv4zyv1lmgrDhPiAgGMEcg/g3u7nmCdeJTe4x0hhFHzREUy/WL8saDXeoQ6qQ6eVAPxkRS9rn3u7L1JWz92cJxKOKgebiYG0PiaVhy9yZP+4x3ymc9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003076; c=relaxed/simple;
	bh=mjNr3G/v9QBX36gGqitndfO/HFTbd2sIQHc02rKE8L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6kiJbJW17w6fIhE6bwVjNSNnbmKuBtIUmStyO9u3QnCvPCeneMMRC1O6CD7RynbU+Lu5qgUeIfqWc6/dRhut/tmS8Nvq8FJQCwyzru+GYSLlOdGuarztupPQJeaDQT3ZqfUDbl9T/8740sF2EpjKigqv/azfMTnNDuFni6f7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdiEYXRe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdiEYXRe"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e63771eb0so56372951cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003074; x=1778607874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDjNhIrcSSeSsR7yjzT4+rjri+DSGOWzpRMdIYgTHCY=;
        b=qdiEYXRe8WyJS5FDs7r3UMdUpi4RsFhc9+vbUBw6jMY4jrHd8QYslB+jHo+8fzd8Pg
         WPAoN7mbXH8SIFaVSpmCQ4x+PmXU7qX856ejKkAZhpbNg3UFw04gONCBD+fIdsKQnKR5
         oPVNf/VSEF/L03Hhm0qisPf+mjYfrxEPS+zTTe48C0J/6zi5r+CrIlbWZ1svYyVx25+y
         z6AY4dgVszB6UNCE0Z++bMm9TuFZdZhIshtmnqtPYXCrdOsOs1082H8MUf6dKyWde8o4
         mPHY/G3Iswsun141f/Vdg/97z+zDIsN2JHmEQIuC7XXkoDDeIxu0CJocLa9Y6UpRbhyD
         P43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003074; x=1778607874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDjNhIrcSSeSsR7yjzT4+rjri+DSGOWzpRMdIYgTHCY=;
        b=TDaNRpfZRLi+nUH74ktiwXvnX7UVl7X0flg39vvyKJM/03FrFdqsmgiGCbdVCaLfks
         /Fo+zcfU+nenWgpj5cAIWo63E/ONWbbmA8JFKNM9Z6Kj5w6YKLLIlBYUqmvraFduHWrI
         p+eXH/d9eLvTvPjFyGoFtSZSZiejxJ4b6VaJUtt98pUOnZbQ1f1MJMfBgRTff90qNQfi
         kxhOxD0Zman9l+kVmciJ6Wwl+/RJHCkTtA/XNYQRjmt6QAJju4ViWRvKcF7fw+FqlDB6
         9uic9ne8qkkcO11x0fSH7SYfQAexf+cgehAQCfCUF8leVkjvrs07rAEHUiW5R8zlQFU4
         Bf0w==
X-Gm-Message-State: AOJu0YxKkuAZTkDDLTXm+DDJM8KjHREVT2Pf5z+7pFP40zfVSRlOsyji
	I+mVEB1D8hDFywpYJsV1wAOaAFzA95BK4ON32pI+rKN4CTBbwWMzCfVHCY3ZZQ==
X-Gm-Gg: AeBDietuzg/EG8E/Ce6CF/zfWWx1WZiSX6uNFunxMLlKJ05VGc8vBuWS1Ep7gDDD1eL
	8yB45p6zYrAIGelHDhTh7HKdpLYk+87E797cAcURIfb7dNCWl/6zmhCGKO5uyw6b5fd/FoqMGNb
	71o3TXBEHn3erlTTHky1xGUClLoFcogG194i71EKLXJuR5mPrT/o1YdJaNO/lED3YWxhAksVVsf
	GYxUdJSvwIdfmtWYO8zQKq8zs1nZYjbsKkzGXNC2VcXAdhHLYKX9U72zFuCscVbrkk6jcMyliRr
	5RVb2HRDwPOAibQw1ncBAL3q6v8Y1iW7GNzFXYlg1HN1QQP7CPWNp/bqhBzL4tToO4rKXZyiAWa
	rYLE9rBrvudslVqqLu+9JiDtCjHfJJV0/3hH9uHs6vEDTpeASfnwFu/15Mrrc5L7vvFHbeGOCO/
	NKihVR5F2Is/1/82JoMjSqVKyu7NhHeF+xmK5eu0ReJt4Z1ycGVtOKfemosVTgefL1cQ9GODcge
	bFO2muTASAxtCCDj4MWT7COizcVig==
X-Received: by 2002:a05:622a:4a05:b0:50d:83de:4933 with SMTP id d75a77b69052e-51461bff537mr515141cf.20.1778003073878;
        Tue, 05 May 2026 10:44:33 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/9] rteval: Update config files to clarify measurement module selection
Date: Tue,  5 May 2026 13:43:47 -0400
Message-ID: <20260505174410.169442-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505174410.169442-1-jkacur@redhat.com>
References: <20260505174410.169442-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add explicit [measurement] section with documentation to both config
files to clarify that timerlat is the default measurement module.

1. Add [measurement] section to rteval.conf (root directory)
   - This file gets installed to /etc/rteval.conf
   - Document that timerlat is the default (SCHED_DEADLINE based)
   - Document cyclictest as legacy alternative (SCHED_FIFO based)
   - Show how to change the measurement module

2. Add [measurement] section to rteval/rteval.conf (subdirectory)
   - Used by development builds and Makefile targets
   - Same documentation as root config for consistency
   - Previously lacked this section entirely

The presence of [cyclictest] and [timerlat] configuration sections in
the config files created confusion about which module is actually used.
Without an explicit [measurement] section, rteval defaults to timerlat,
but this was not documented in the config files.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval.conf        |  5 ++++-
 rteval/rteval.conf | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/rteval.conf b/rteval.conf
index 46a9b1743716..fdb64abe8797 100644
--- a/rteval.conf
+++ b/rteval.conf
@@ -5,9 +5,12 @@
 duration:  60.0
 report_interval: 600
 
+# Measurement module selection
+# Default: timerlat (preferred for modern kernels with SCHED_DEADLINE support)
+# Alternative: cyclictest (legacy, SCHED_FIFO based)
 [measurement]
-# cyclictest: module
 timerlat: module
+# cyclictest: module
 
 [loads]
 kcompile:  module
diff --git a/rteval/rteval.conf b/rteval/rteval.conf
index e4437e04347a..87c0ba45921f 100644
--- a/rteval/rteval.conf
+++ b/rteval/rteval.conf
@@ -5,12 +5,24 @@ debugging: False
 duration:  60.0
 report_interval: 600
 
+# Measurement module selection
+# Default: timerlat (preferred for modern kernels with SCHED_DEADLINE support)
+# Alternative: cyclictest (legacy, SCHED_FIFO based)
+# To change, set one of: timerlat: module OR cyclictest: module
+[measurement]
+timerlat: module
+
 [cyclictest]
 buckets:	3500
 interval:	100
 distance:	0
 priority:	95
 
+[timerlat]
+buckets:	3500
+interval:	100
+priority:	95
+
 [loads]
 kcompile:  module
 hackbench: module
-- 
2.54.0

