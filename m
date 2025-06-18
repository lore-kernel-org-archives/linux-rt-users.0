Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCD2F3C33
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271315; cv=none; b=OTMs/LLFhQaajDkkC/e1AtMk3jz+0uA9uJHg39aV2yuIRO4a++JLAG2hvBhFFkCGQJgCVlAOfYIILokFqqifuk6OOCt7BGooY3rCC5ogHQkt2+dmIfALWumIYgNLvQsZYCN/aCqdU5TTqN1cKHMZ47RbO+2WO9kDYFXnlyz77AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271315; c=relaxed/simple;
	bh=ebEZVWDDNw+jaHM4VfLAZlAq/NTeCH14dh5LQwggUwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMU/nyHTNbJ6XkWl/fmeS/rb8KzBROW9kVAuLcqbfGtd4eRN08bNSaoJH3Sqt1zUc42x0mAX6xXHiG+smgd80Nqn1vPyKm6QslGsSgJ8ig23BcGlUhhBBLe8GWOhWDkMQrXJI2DBD3kw8zE3jy2FuJPpX1K3LybBYOfp84+DRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0IH8T+y; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0IH8T+y"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a44e94f0b0so88037371cf.1
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750271312; x=1750876112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBNwlkpaocLR47kfEWHgZ8WUOF+VnXXbL2c3oyrL6wg=;
        b=B0IH8T+yRN7OqcdRKE0PSSRMtIObVIUD38aeGxhSvqzcj5V+v8WLuRO/2SJev0OGYj
         EUJZBhuy+6TLbvxS1GZFC4eqgRc+J/jjqbqrd437xrDuaw0iGziVVwhoaz24P3JEyo4O
         tpFFKbzffKbgJKOvStLvJE+gdtIAHT10whHuuXUmOgNKGhSKce2ayYDvnQV2cPLoxmV5
         R5QlH4jpFWqHd88WgtLf/8AoQojpISJf4qa/N2hvFWWX66mVLrfcP18RhbcTkuWqOlK0
         DigG1JcFkAS7dpGeACvqoHv10BdhfO8btR2Qcxf1Ycgp/4GBUeM7sdb4LX8jqKT9HB7e
         aUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750271312; x=1750876112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kBNwlkpaocLR47kfEWHgZ8WUOF+VnXXbL2c3oyrL6wg=;
        b=JdpA1P1q/zNQSF/UC/g9I2JKXTvHHe3L78KT9fohq2VAiNoPI42rix5ZNkB/9aAO4i
         IZixg1pRJb5vnh9DktP3c4sNVQE4RCSYr44Yq0HJXrvxNgCdHZfOPTI1SW42nSejW98v
         ys+bb0HQHqUYIgkeIul5Ej95kdp8r3Ud+MTqoRqYvaIYhv7TslkjAvB+osvQow9FmTai
         vmV4Xi44kmPzJvsUFjI/waoA5Q6AXfViLMXNRO+PqdhqQ6n2BIf2OZj3dTB3b01rtOXC
         Jlo9/C+8RaqTv/35LhxGQk0jqlswclPwDe3H4yROJcjFb66EDG0FcJacIm6RTaMnFyJn
         et3Q==
X-Gm-Message-State: AOJu0Yz1F4VLh/GPbeXU2TdNhp1ImnJLp5SsYghCGHQp+DDL5GO5nU4e
	y5dUwlwGS7SSy5p01E36pq8jHJKHDutrgkMPmJhz5I2AtKyVt1ACch/ePttOJA==
X-Gm-Gg: ASbGncuauJUqh6oePOB7xdwseymBf7TmKrbQ63Zo0JXCuw3RfBwBRXqcw3blbmszk2/
	kBZ+S4FKb6ZeFeQTVXPcvJIeGML0y+noQ83bpfijW5QmPFLm54fsHs7/iJhvBsFV0GYLHaLIF0l
	g8VcGG0ac2XimjkKWrelGY1CW4GiMYVFkrE/LJSyOHC+FTaCG9J+puH+MvOAkpd18zH1zVXyK6L
	GvoqYQTJGGDLJZOoyKkpFJf91sfTWE+cC36pIpATiUZ+G5yUL8+5Yln1GRSC2yVxXkHErm3nhV6
	cfdku2Hl3MP9wbLnxVlp7cQ5Vysr6dAz4kiuB/lUeyUc7FQCse+ZPOdw0j9Qpb2swkEBfWw=
X-Google-Smtp-Source: AGHT+IGD+FdSFi1v2DseyvxPSGmx6LeyLYqMiKz5vIoiitL4lin4r7gBfflgIaoDhWA0KeGvT2EkCA==
X-Received: by 2002:ac8:5186:0:b0:494:950c:6dca with SMTP id d75a77b69052e-4a747b5cb07mr191929831cf.23.1750271312281;
        Wed, 18 Jun 2025 11:28:32 -0700 (PDT)
Received: from localhost.localdomain ([76.71.123.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a4b148esm75999141cf.40.2025.06.18.11.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:28:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: Make timerlat the default for rteval
Date: Wed, 18 Jun 2025 14:27:58 -0400
Message-ID: <20250618182758.57946-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618182758.57946-1-jkacur@redhat.com>
References: <20250618182758.57946-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return timerlat to be the default measurement module for rteval
Also make the default base interval 100us to match cyclictest

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval.conf                            | 4 ++--
 rteval/modules/measurement/timerlat.py | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rteval.conf b/rteval.conf
index 601410b51c28..46a9b1743716 100644
--- a/rteval.conf
+++ b/rteval.conf
@@ -6,8 +6,8 @@ duration:  60.0
 report_interval: 600
 
 [measurement]
-cyclictest: module
-# timerlat: module
+# cyclictest: module
+timerlat: module
 
 [loads]
 kcompile:  module
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index fe29f34bccbd..5bfc495217ea 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -509,7 +509,7 @@ class Timerlat(rtevalModulePrototype):
 def ModuleParameters():
     """ default parameters """
     return {"interval": {"descr": "Base interval or period of threads in microseconds",
-                         "default": 1100,
+                         "default": 100,
                          "metavar": "INTV_US"},
             "priority": {"descr": "Run rtla timerlat with this priority",
                          "default": 95,
-- 
2.49.0

