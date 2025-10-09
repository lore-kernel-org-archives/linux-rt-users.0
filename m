Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CF1E511
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Oct 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041667; cv=none; b=l9lZ6fnJroTdn34KDqiyvrOIYaa6ZbGh9HSgs6T0EQao9rQCZNNJs4OtyonIty/LLAxG9rSVwnfWDpBg1HpX8qCLIhm0/yi5oxgRbVZpPCE2r5pwuJ2R2vahFvGA90TsNKRaX5ENPYJKoWzFSQBUcVUfo61Ft9tQYcN9PxKDOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041667; c=relaxed/simple;
	bh=Y4R+QZx9B1Vk4jIAxOYIi+UZmzBRDVrhlBXX9ezi2gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRezA/XiTullIWcUcAi1CQscod2MAeAcQi6t7/DV/Y5CEmH9mtP9k2bxgWif4frXQHrcsNY0jtoUaQ1TNwLh6JXbme4eGCTlhhzT+VDwhXfyFw8g4pKn+quLIc99vb2+VGHYJwyQu2ZwbQlTH+Rng2Fdoe27rB7kcbIeAIEsKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5SJIcjY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5SJIcjY"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-796fe71deecso13114156d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Oct 2025 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760041664; x=1760646464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdvsIZluu+eB6Xf36RTbl3CvStphzfEwlPJ1PqDTfrw=;
        b=k5SJIcjY2db63QoZTsGPMrqbtz7SwzuGNByF0nrrR3HqRJ6CBc0MHeeVWPFn6l/nn8
         5LPYuFrefa7ceI0lU2tSprTD06WHrSWwNXiXFnvW1SGIr+UrwgQttMNH7+eEuFyo2zpx
         dItaKMaWhkc3lxsiqWdDpXpzcIT1ZfB7xf/IuaZSN0wcRZD+Uz9miOzxHh63A/orPHQR
         wMaNnsBirPOm7iBtToKwYPWGAmI+HQwHIuHst+ktENNPnAZYrSd8dM9N5QpQPhQUYk9r
         6lmDAUhWiJuugIUNkR+b+wtuzCBNXSZgycHWWy1UW+tx/mNH+JGnCSNzLpvcyRk6A0lf
         tE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760041664; x=1760646464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdvsIZluu+eB6Xf36RTbl3CvStphzfEwlPJ1PqDTfrw=;
        b=OtRbUdRkQ4U3RCHs6kfhJMcRgF/Ra4lFtjvnVj93f+STKNRmYY0EnttYol132Nh1PI
         79Ze3VIDWwL9f5WpE81T0+u3uIAwO48a6W/UsVhWekmqgWCyoK8VY7ZZGyzYJhFDJvZO
         DMIB3Udbc8YwHcSJpF5vLswaHA7Lt1qNlCi4i/UJUMFdN8I2gvttlve+OH1hLG+ZDBK3
         h1rSivnrPauG9SwfrLVSoZtskAW02u+Ok1O+N/k/R2uCyCZExVaApZkJ7lhn8dVU0fzs
         NOvE35+eN0nI4OKh7+TpXahbafTpEHQyPoYa0qdoopBvAGgqx+a120G4s7ukQsqrz5u4
         xocw==
X-Gm-Message-State: AOJu0Yzrho3tAdoNs4b6lOn35Z0CRFdvaLsDjiMzs0KE/fcKpzI1cqV9
	REhRMH3J4UNVtUsYMKIPnP3yq+zra+XIAi5ZhUALpI1//7HXc8KY8EDMUT0ag84BUrw=
X-Gm-Gg: ASbGncuHGNnTt2IHQgcjttgWpgXoMDmiPisJ+s5ZM1Xj8tenUVgMqEza8HQBcG6HeWr
	772zSGk39BChp7B81MMCh9cZLg6KFSE227cywl+46VNpuZoT6NVpjhU0YPU37c+OHJkcEZFKG3D
	QzhgUicYs/nO4hPWGvmUKleSe3+GeawuTxtsFaI/ndM9qf7D56ZYCMiVGlRNxxDLlxzQmb994wB
	ga2e4jsUSl53fCyb74fLHvoZ1EwfrkLsf+8RTSph8bKEhQ7HOHssw+aGmuGXOyMG1upbwiP2lqC
	fQaqWyhJe34UjPBKWnB9hiZsq2mc/WHN9PBBqO4bIMOnIXQQJpMOClf+qGILa2XSCpGuCVQ58qA
	ebv+DsDegNEwtpsi6eJYpG4Zdv6uJHwF1vBJFoMrsiWM/PKQWS3vWoyu7V3rEB6t14gIIKLec3q
	Psys8yAxrO5BsnqvcHlSUHHC8txC4tre1ILYY=
X-Google-Smtp-Source: AGHT+IFE9s/wnE5PujzyVCRT9MSnh+GT5g3lqurp4vhpBaIq2E9zsLR1PxO+0Mul0DnVD8FxytT8oA==
X-Received: by 2002:a05:6214:40b:b0:879:e961:670c with SMTP id 6a1803df08f44-87b21014dd9mr127548646d6.7.1760041664306;
        Thu, 09 Oct 2025 13:27:44 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35713ccsm2664286d6.37.2025.10.09.13.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:27:43 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/4] python-linux-procfs: Remove import of range from six.moves
Date: Thu,  9 Oct 2025 16:27:29 -0400
Message-ID: <20251009202732.57880-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're fully python3, remove import of range and just use the python3
built-in

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 procfs/procfs.py  | 2 --
 procfs/utilist.py | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/procfs/procfs.py b/procfs/procfs.py
index 7cc7371b53e2..e3f9f44614ef 100755
--- a/procfs/procfs.py
+++ b/procfs/procfs.py
@@ -11,12 +11,10 @@ import platform
 import re
 import time
 from functools import reduce
-from six.moves import range
 from procfs.utilist import bitmasklist
 
 VERSION = "0.7.3"
 
-
 def is_s390():
     """ Return True if running on s390 or s390x """
     machine = platform.machine()
diff --git a/procfs/utilist.py b/procfs/utilist.py
index e6314f0fd89c..e36c739862a4 100755
--- a/procfs/utilist.py
+++ b/procfs/utilist.py
@@ -6,9 +6,6 @@
 # Copyright (C) 2007 Red Hat, Inc.
 #
 
-from six.moves import range
-
-
 def hexbitmask(l, nr_entries):
     hexbitmask = []
     bit = 0
-- 
2.51.0

