Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C2345ECD
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836090; cv=none; b=SblWaCM3PYpbvrDy83T+HK2er1FURPRMivOCADLfAc4YJZvHv0LE48UaHyNAzPt+6cDWhvWwn+zhKMUwoLOcJMyztmnGlsEG+vbfzTL6gPC2bASvBu0VnQ14Siks8HFc94h/YNlkW5t+r0N6XafFeKJpJG3HU8sc30dbs5JSuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836090; c=relaxed/simple;
	bh=xVJiso/Gtw+oSTr4FiHxTzuMg16npsubDoIULyQUvKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWi+3sjALL0wdtmMIvydbSuLL3l0RXsHYCMbgjA4vEUXnrGHL5TUcDAmSbIdkwGJiEFdUi9+Mgjqgq+JBH9Yu1Evvhfs2bqVBFvYNDwv9mquKXbRKEQkH/I+IyQzxp1XpV400Vj/F4Ij4MHZ5pf2Y914vs9xD9KaWHSm3VnsSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4Xb7cMK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4Xb7cMK"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51bfad59921so9201841cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836084; x=1785440884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Srw69EAr4sZfMvZb+xYm0Bw43vBHeczKeG5qoRqON4=;
        b=m4Xb7cMKZ82Jqv/VEYnbNtoJmDo0tLH4k+fDHwz06pAw9TY3UmVnKNM94AhdXtOpFe
         6+AMpGJOSwEOcN57/LEq1bHC1aTTwGefLRLApZMStoCfdoq9EYSjn7HdpMtDul9j/tUG
         KHNzqUiEOGcnNNuE6ADb/ELTMdqcUqphHfSFslssyd+F1V4H3V+klvNo5G7E2kSlTNq6
         JX3OkfcGsSpxKPlVfMLoIc6XvBoBdLfA8HEcj8UYlWOR9Ybeo3FrP8qE3awjM1AN2aQX
         3ESR9GWiQajbDpSc7dcb3f8I1uHG6qvxEbZ3/hvVCC6ej/Pf5MUC9ESQkYN7te3G2ovN
         FwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836084; x=1785440884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Srw69EAr4sZfMvZb+xYm0Bw43vBHeczKeG5qoRqON4=;
        b=rvYN1RGXZetU2/gHJH6CFVhSke1Kjm+Ff9ayjdKNeN748UA1ELVjMFBaxmCVG+SAUY
         NGAPJU73XAWHDDhV7L3qdVI8KyiyVc+pRQdda/Ouja28pWT6yaOm5XFKfjvyYh8AaxtY
         vGSWP6fLA48zad+kVgBRR0wFcl8iiQBkdtex7YyrubBwfsMzd87Rl3D1vuBKpKwm5yVc
         0C/VGIpWIgh4zQ6lj94VmFcmFSqaoUwK34doJvqOLMyeVdg2a1mLrY0JW8cnSKZgK4BE
         RUy/y6ZFuxOoIDKOQ+I3mJzpd/kyJG836Xa2hJrW/ZqmfS0eosx3j7SiM4giIWF5x4yB
         QOGQ==
X-Gm-Message-State: AOJu0Yw06M4RVS8cf3UqJbo4QSwflf75jxJfBRI6Vh8A+er+lCgkOq8b
	8RLTi5OAthnLDY2x4lJ3aFkq3RW2twMuOatFgUYT9X8jcYeKnt8Bk5jBgbu8hA==
X-Gm-Gg: AR+sD13yo5ZiD3B0iLmLnuD3v/BK/++iRfOZWBON3ZG2nTmJHgZnTTZZL6M5k6BnB8d
	O0MAFm2IGFSBzn3cixX4eYKIzcle6s0B+PI8q0Uc2PjR3upN0C+sSJ1EapMelKdcCApFCPkmpOJ
	EZTve3ZMNI4IZydSF9eaCqbtZOc4fjMoXLG8KrLL3xa4RSiPBkdZ2Z3Ud2E5VRNcmJ9uc9w680x
	HaO8Wnr6Z9EF22yBrkFM8DoMuSApkHeiskKtnCKf2g8LlPt2r7Gv8CHOthBIkzjk44K6C97GngE
	jAc4zheLQ4AHBqHIArU6V/36qNUKSdJxsJWN2hXyGjLFaREvkLV5YgILpOyq+HpuXGnYk3EHhUZ
	VPivVi3h/3gkU1+mpp3hKDoYUvS51YLSMjkb5UZes/2u+wU9RjMKrtOHWjtu6+ktLrEj+ZVhDep
	Rt3Cf81giJkJZjQOBmSt2P/gSF2r7EUjHNZcBINhGc7FVgsP+M3wpaw2u/ryQSUQBMuGIvzLxnn
	C08U27CPYchPSsaVjwt6W8px1zZLtgGyT2ShKok5DZVAyIiDG1HGsgzeq+CIIYLyzaf0vw=
X-Received: by 2002:a05:622a:608d:b0:51c:7b11:41bb with SMTP id d75a77b69052e-5283dfdcc84mr40655811cf.87.1784836083865;
        Thu, 23 Jul 2026 12:48:03 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4f3b8sm41402321cf.9.2026.07.23.12.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:48:02 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 2/6] rteval: Fix stressng --taskset argument parsing
Date: Thu, 23 Jul 2026 15:47:47 -0400
Message-ID: <20260723194751.625088-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723194751.625088-1-jkacur@redhat.com>
References: <20260723194751.625088-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --taskset option and its CPU list argument were being combined into
a single string argument ('--taskset 0,1,2'), but stress-ng expects them
as separate arguments ('--taskset', '0,1,2').

This caused stress-ng to fail to parse the --taskset option when a
cpulist was specified.

Fix by using extend() instead of append() to add both the option and its
value as separate list elements.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/stressng.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 4ad7197fc590..387b5718a08f 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -82,7 +82,7 @@ class Stressng(CommandLineLoad):
         if self.cpulist:
             for node in nodes:
                 cpulist = ",".join([str(n) for n in cpus[node]])
-                self.args.append(f'--taskset {cpulist}')
+                self.args.extend(['--taskset', cpulist])
 
     def _WorkloadTask(self):
         """ Kick of the workload here """
-- 
2.55.0

