Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F0369203
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577537; cv=none; b=DhgsVEsCKnMA6wwJBhJSjkc19bqjOsFKmipo2uMv+c5UaHp9pEkM8jM1Nb6FNrotvazX8zUVQirXJdePghmjvRLX7S40p0hIVd2wYsfQlKTDcCSktKm0xkPRnucYzhIlIth6/FmVj653xSznteXT+H3bECsgYGE0U8H/z7tX3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577537; c=relaxed/simple;
	bh=f4v/vTM+wJrMr7ETXNYr05OIXJe7NSge1AQuEtll5Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbrF9UDEs2fzykEf5tdH+3lFRLt9wf5YWM0R7D4CH3EUvMSQ4z/t5mu/vdC7DtOYzK8C6JBATYqIKuvH5+Rb13jZ51df/ZniLyzd9xoSxhxScV8+BGnp04GCFTKo8XILReZkCmo3TnBBvTInAq1Ut/lvSBWhFDkQfB9r9ILrIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH6Z7P/9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH6Z7P/9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50fbd79350dso11028611cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577535; x=1778182335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35XwAdGe6sjEM/OrrkxtABWfAzmTq1225pZ71V2Sb8A=;
        b=gH6Z7P/9fooBa/RkIqxSWII+k8Ym1uh0BHrICo6b6Y+ZGgzlXY3y97cpX5T1Ns8F6d
         5onG9sov9Sk74s2X9cvDtr8msA6/v1n3KafcyRaxwQVzOIoNTSOc5MwgdMvTFA+4/LGW
         XBdCttW/998RyBExOnZakZBtzFIHevd8i87I3ZYaccXXJLjaG0k0nyMsdKlJ7j8ahEWK
         5cjN+xFz1c+zyHaAH+CopoYUoedXJyk9clxlLKdZRcrY3jfNvjLGLGOp6xfyeG7bNcPn
         fqHhz/Db9nLeP/ibsxEUmxh7Ad+E3mNBcbJx5BOMPaLL2T6Nb3KuBFSpOETkpZiYcb9k
         DHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577535; x=1778182335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35XwAdGe6sjEM/OrrkxtABWfAzmTq1225pZ71V2Sb8A=;
        b=VNvlWI2QjPp/o4fY7UQ9Hjkxo812lWNk4SuaLVFaP5xMAtnTajJnPOFYCWvpL6p5ug
         wWLU/UFQemJA2szUz7PUV0opGzUlKQ1figh9AwqGVbsDJDGeH02Q6pA8nkOgDqwo/YgD
         j9aBNXKKZh7gMIjnWHh8Kr7zHDE4z8LSWmwjtBmELxw+8JWForUuNi4L9Su0+sqtFmXr
         VbiozPXUN8vf5qB0XNaJEhKrhixYnFj0pYXnMXj7rCD02/f5X7Yqcl15uc6NSZa/EdrU
         hCsxrGPeshYq2T2xK5aRblhvwYOwCvn520dVQGjxCXltjPtN/bu5VaadpRc+nrv8dbXM
         aXOQ==
X-Gm-Message-State: AOJu0YwRrdEQ9YcjnVQZcv3F9wxpx8lfz5vagkXA+0Qzx4q9L3MTrive
	fRv3CAgG2EDY7W7CoYuqm2xPlLkDC6UqOHB8/HilVBqBfemLCDyOPFTbr4BxlQ==
X-Gm-Gg: AeBDietD7y6BbzPKhXFfiv9NCIr3i/mLNLyryyi3idONPcmSkTI9rU1+UefsESM1BPG
	vz/Djsd05Fv3ZmDkSFY4qRQUx+gefjTHPfaLiPVUjnzpLgQlD4KDP/DUldLUR3W9xnaTE68g3KZ
	s/tTCUr1xU6b5GvyuPUEIX58SaF4yvFoJJMIuqsUuaXOI3WiYBlFGdUMEPOH4IwehmjWgYk0CR4
	4eCDWKktDrxZR5ie2/6VqCOYcHndRzJHv4+oJOoLLh098PhAEuEXvToCY5oJcMP8TvQwYnSwHIB
	sbk70fIBU8wthsMNT1Sbha7wVsjdK4ZT9yJF1tc6T3cbqV0w9j/L69GQLdr90ToK+Vb6Z3zLgDb
	JG2ynW6gmw1Dvcp9XfZ2VLoeCCXfYPlMXm4jCsgBO6gBDwHv1yt+S+RdGmbARQYHe9u2FhKGUO0
	PYVCj21Y7Z7g9OpwqOOvExVKaryAwaSw3sxuKxI499w4A+07SfQuWS2Ha4zboHMVXXqoNt82OZw
	5zBRMu0JHMqKaPE31qOXQzXW+SmHQ==
X-Received: by 2002:a05:622a:1a92:b0:50f:b9a6:82b5 with SMTP id d75a77b69052e-5102ab43134mr61205791cf.1.1777577534967;
        Thu, 30 Apr 2026 12:32:14 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d1c6957sm4270391cf.2.2026.04.30.12.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:32:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/7] rteval: Update cpuset documentation to reflect simplified implementation
Date: Thu, 30 Apr 2026 15:31:43 -0400
Message-ID: <20260430193144.354599-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430193144.354599-1-jkacur@redhat.com>
References: <20260430193144.354599-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update help text and docstrings to clarify that the simplified cpuset
implementation creates cpusets only for measurements and housekeeping,
not for loads. Loads use taskset for CPU affinity instead.

Changes:
- rteval-cmd: Update --cpusets help text to accurately describe that
  only measurement and housekeeping workloads get cpusets
- rteval/cpusetmanager.py: Update module docstring to clarify that
  loads use taskset rather than cpusets

This aligns the documentation with the simplified implementation
approach that mirrors isolcpus philosophy: measurements get isolation,
loads use affinity constraints.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd              | 2 +-
 rteval/cpusetmanager.py | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 29254a8f1a7c..37db9e5e2ce2 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -118,7 +118,7 @@ def parse_options(cfg, parser, cmdargs):
     # CPU Configuration Options
     parser.add_argument("--cpusets", dest="rteval___cpusets",
                       action="store_true", default=False,
-                      help="use cgroup v2 cpusets to isolate measurement, load, and housekeeping workloads")
+                      help="use cgroup v2 cpusets to isolate measurement and housekeeping workloads")
     parser.add_argument("--housekeeping", dest="rteval___housekeeping",
                       type=str, default="", metavar="CPULIST",
                       help="isolated CPUs reserved for system tasks (not used by rteval)")
diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
index c1aa04431f3a..2fe931cc4574 100644
--- a/rteval/cpusetmanager.py
+++ b/rteval/cpusetmanager.py
@@ -5,7 +5,8 @@
 Manager for rteval cpusets with automatic cleanup
 
 This module provides the CpusetManager class which orchestrates cpuset creation
-and process migration for rteval workloads (housekeeping, measurement, and loads).
+and process migration for rteval workloads (housekeeping and measurement).
+Loads use taskset for CPU affinity rather than cpusets.
 """
 
 import time
-- 
2.54.0

