Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1503CB90A
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2026 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180510; cv=none; b=txK46pXpv+p7n3dk+ipFCj4fRrrOr76v1iWqD6V+HNVc+yxGRnfb/s3qP1o11SluJLNkzLtr4uScM+yY3QlFWTQwIeCIpfKQnnXNtfVOApGOCk4dL05ZkCD+QqyPmuRdiFvowXHvLj+vTRhnqDsCrmKLY/K/fb/kbQ8p+hNHp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180510; c=relaxed/simple;
	bh=nT2KvRleZbqRA2JGc7PHNhjl4paOpZRxeU0Ysv582zE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s16bfVjumLU5bTGWyZcsz9t6PjFYyS6n8ElD+zMNY6V6xcFvMVREtqLWDcR9OHjh4qc7gT9WpEuor7hFNJNIYM1haBqhhoaSjS1VmCVcNVkZTfLFc2JfTA20GjfDhOZP05dztPgDcioBOepS+FAU+JiJgH25nplEtmZEmo3KYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMfvUCE4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMfvUCE4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92ed3993c1eso175390685a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2026 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785180507; x=1785785307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b6HCE1pk0QhRpNN9/WuNsW0kYIjZE4iiMVpH6XtI0Fs=;
        b=WMfvUCE4KhEyp4JJl9vMe8xuFuaHJYRmdwqMldZhNNvfaXIX89OhG6nZw//KMTPx4K
         WIKPjpx350pYhKulvkWwdvvwAh84pgJyPXt3zZpbZhMfpK0YJXHD0dB36+3HpioDGWGy
         cgyEqHjbtld6K39/MbeHvrv5jz/N7VAfXzFpFXM1S0l1xb1VxBakkr0zAymvIjn+UeMe
         prwfc8JjSY+OwuJ6CdWF72E3seSojzugXia8+Sa17A2gDnRQgSmxg74pou3uQEYh8/z3
         7e2n/6tK1n9T7NGd8cab3VPWhUvNt0bgSJt4qNe+349kbWlkllWbUQq/IAuSDO3xNt9e
         91QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180507; x=1785785307;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b6HCE1pk0QhRpNN9/WuNsW0kYIjZE4iiMVpH6XtI0Fs=;
        b=OG3LbACUukDVcFIwTgC+ZmEyJzXscORWxQ0SJjayIzdSbbadOdxN/MkY7+BvxgbYgB
         sjZppc/mDW0DGhjqw0VMNgICNvAnVz7OI5qkFFS/t/DqRyOE4y9sJRiycBjg7O1uGRos
         hWH+mKhH9PrSqXg3myfTHewpP9GyYk+CuA4wKDp2CsNEXfTw0g0VjI++JRxCFglxHnSO
         LECWRz53qB2hP+w3pycIn+Naip0FLodma1dndaKg6RMApZXBnv//gDxLiIoTttlfzS9T
         J4dmM9xCXSX6i15i8vDmYW08WEhZaN3KUZNwRSEWMNRw0yPbbESxAyupOqoQL0Zi/T2O
         GpTQ==
X-Gm-Message-State: AOJu0YwgaTL/FTTka+7qdDHQN+yap9a+4+VcydrhVva50ufTKlGnCB0o
	3oa/tu1d1ICoWlU9AbadzoF92VVUau6CG/uENlKSITFed+gzeKoh+MIs/WZ2EA==
X-Gm-Gg: AR+sD12ebBpPdTMx3eox6HzI+8X4RyoVkPOnfqrHqXj2iukxoPCC3012o7mIUsJ6zqU
	a09JRDePsJhnyojj5+mDHuakUiVFU52BDlhXDxS9gjA+j/InF7nEjIekpsl03EGxctIEbflj1Y/
	hWkD+XsYqJckJInGNum2lhfu0f+LjcesskrGN1IVDIABKpo+zp+GgYsZrLIxZMwAH9hije0yntG
	qL4b19hAM1NVrgCCtK00Ep/LRZzgop67gVo2wCBrt4E7LtuL5ZSR8ZNaiKgiZVcX9Qx6TQ1xrZR
	YPawWiflcv7/Z1b8X2n+iPpl+YVg03dxlx309eTx/Iy4NB7BFFrnUJtSxHuFxnLTfuaIJBUVqBV
	OrmNxE88+bkdPIVMbTHVsRB6u3BVrm6nLw6m1GSL91E1EXmFFcPt3DSdeBshb0RYUWcEYJXhwLB
	8CaWG/m5vq6ErryL0deBjeTbi/mjtjJ+DL7xAxrg6N+aTOKZHkjugPnE0fqKSK/4tTWInhb1I46
	ahEOcQnvhPvvcxNixCyYJYmT17x3U0RdfhK/ysAzb5ZMP/WIxKt19dN7puM
X-Received: by 2002:a05:620a:1725:b0:92b:67e6:8ace with SMTP id af79cd13be357-932df724e68mr1026408385a.72.1785180507518;
        Mon, 27 Jul 2026 12:28:27 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de6729ebsm684224385a.42.2026.07.27.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:28:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] rteval-v3.12
Date: Mon, 27 Jul 2026 15:28:10 -0400
Message-ID: <20260727192810.166664-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are happy to announce the release of rteval-3.12
rteval-3.12 focuses on robustness improvements and container support.

New Features:
* Container detection and warning - Detects when running in containers
* Overflow bucket support - Handles extreme latencies exceeding histogram range
* --housekeeping-isolated flag - Better CPU isolation control

Improvements:
* Improved histogram parsing robustness for cyclictest and timerlat
* Enhanced timerlat stoptrace trace analysis and XML capture
* Process blocklist to prevent shutdown issues
* Better cpuset migration and debug logging

Bug Fixes:
* Fix stressng --taskset argument parsing
* Fix collapse_cpulist to handle duplicate CPU numbers
* Make thread excepthook portable and support chaining

Documentation:
* Add AGENTS.md guide for AI coding assistants
* License harmonization (GPL-2.0-only → GPL-2.0-or-later)

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.12

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older

To accommodate distributions that require this, I have linked the last
version v3.11 from the older directory to the current directory

Bug reports, patches, etc are always welcome.

Enjoy!

Stats: 21 files changed, 1833 insertions, 48 deletions

John Kacur (19):
  rteval: cyclictest: Improve handling of truncated histogram output
  rteval: timerlat: Improve handling of truncated histogram output
  rteval: Add container detection module
  rteval: Add container detection and warning
  rteval: Add AGENTS.md guide for AI coding assistants
  rteval: Fix collapse_cpulist to handle duplicate CPU numbers
  rteval: Add process blocklist to prevent shutdown issues
  rteval: Make thread excepthook portable and support chaining
  rteval: Set measurement cpuset to partition=isolated for CPU isolation
  rteval: Add --housekeeping-isolated flag
  rteval: Fix measurement module cpuset migration and debug logging
  rteval: Fix timerlat stoptrace trace analysis capture in XML
  rteval: Change test file licenses from GPL-2.0-only to
    GPL-2.0-or-later
  rteval: Fix stressng --taskset argument parsing
  cyclictest: Add overflow bucket to handle latencies exceeding
    histogram range
  rteval: Improve overflow bucket handling and add timerlat support
  rteval: Refactor timerlat parsing and fix max line duplication bug
  rteval: Reduce verbose debug logging in timerlat stoptrace parsing
  rteval: Create rteval-3.12

 AGENTS.md                                | 466 +++++++++++++++++++++++
 Makefile                                 |  14 +-
 README-tests                             |   6 +
 rteval-cmd                               |  20 +-
 rteval/__init__.py                       |  17 +-
 rteval/cpulist_utils.py                  |   4 +-
 rteval/cpuset.py                         |  41 ++
 rteval/cpusetmanager.py                  |  11 +-
 rteval/modules/loads/hackbench.py        |  10 +-
 rteval/modules/loads/stressng.py         |   2 +-
 rteval/modules/measurement/cyclictest.py | 102 ++++-
 rteval/modules/measurement/timerlat.py   | 171 ++++++++-
 rteval/rteval_text.xsl                   |  34 +-
 rteval/sysinfo/__init__.py               |   5 +-
 rteval/sysinfo/containercheck.py         |  92 +++++
 rteval/version.py                        |   2 +-
 tests/README.md                          | 322 ++++++++++++++++
 tests/run_tests.sh                       |   5 +
 tests/test_cpusetmanager.py              | 412 ++++++++++++++++++++
 tests/test_process_blocklist.py          | 143 +++++++
 tests/unittest-legacy.py                 |   2 +-
 21 files changed, 1833 insertions(+), 48 deletions(-)
 create mode 100644 AGENTS.md
 create mode 100644 rteval/sysinfo/containercheck.py
 create mode 100644 tests/README.md
 create mode 100644 tests/test_cpusetmanager.py
 create mode 100644 tests/test_process_blocklist.py

-- 
2.55.0

