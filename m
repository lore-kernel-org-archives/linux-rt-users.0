Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067FF4DA9C7
	for <linux-rt-users@vger.kernel.org>; Wed, 16 Sep 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591453; cv=none; b=FsZKciaeYljQWirg0EqggwAykfKzkofA48K/HtzySNYlbRWYwiGGSj3U3GkArKnmgPOBWdQDZx1jnk0mQwemaIu/atMI1G8enRGtBj323PUyZTeFRLAGnmVDCaw0GZiSzewaca4VTRB693tzQ4DsU5TXfkwb0ptGNmZwGED8Igo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591453; c=relaxed/simple;
	bh=nF7AXE2oK+SyYZ+x/sFO8sHhl4Pfns9IDb+N6dybQeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mjlm2AXdYYG6tIA+VQY1ywZT5WA+24b655PWutQejF/WDxCX6Tl6qGGOCbwoq6lkglMGtVpkW47BVhmd98XnXBq74lmVhOqkUpPzbTqfZ7CGIdCzmpUZPHq6MJUjlGTJIHqQmg6AvIKv6iOHEjofDSZwGyAbYD0BevsgNHogQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag0iCw3N; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag0iCw3N"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109f067cso6691385a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Sep 2026 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789591437; x=1790196237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yi1Rfr9drk8zScNg2s6ZLOqeNm8GiRX36Fti9lQIdVA=;
        b=ag0iCw3NWbjpow9eqHTVQQACmR6NMftum3i1coYcK4jOcpIcF720FVRftQabERGVPV
         O8wwfJpcIpVjwY7y9suy9MY7o6ItWvCTvRhEeUUJyrYFP9/+pqGWj5KtXQjfIT2pXeoo
         hisEX7lQsaOfVoLf8ufBdOSJ9ewExtjwcocHMGjdcunqNTjo23bHCcDi9Vh5xBljTKfK
         rVLWxcjRrsvOA72FmSSSl9OoH9nijBnuQd9gOM1l8PhaLhF/TA5vZxvPXm/vifaaQoVk
         mbIdWJcCJsgpED+65vI7wPm7RRrgzJda+9hpuNHJTjei4FBtmgL54S/9xmC2/p9fhVaT
         bIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789591437; x=1790196237;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yi1Rfr9drk8zScNg2s6ZLOqeNm8GiRX36Fti9lQIdVA=;
        b=lP0dom/ZxGqAFxo2lpeIO3+VZL9P9Uj08hLN1/TAChtdigQHgNlKRhXcVIDelUNftP
         EvfAmATo9/YVwQXIu+K0wlFnwWcg5xEQU7ZYpS6SMkEOn7gOjUoYWqZg98Stya5GGUI4
         lptmdLxbUYgvZ06zWWibGcSaGcxzVoTzMxmFhDHLesl7M18GFIdler9QwVJomqykab+M
         Dzrl0yWKoBi7PySQC+tXQ0ZghxVZFphfaFQEtzGBcW1y6uRUsjM2BTRXMpcqKGKofvxK
         55ynC9sLF3UFme6hrDVtcY9/y4IadFZoEuQJPm8xFaGA8nYTKo9yDLV6/sipuK1mWH+h
         Pj5A==
X-Gm-Message-State: AFuF++m4apxqHBuuyDOCKhmxCkWyTEssSia3JHUHds6E5uoTmR9rc5OU
	l2xB22Ya54eqXL+WRF/IotB4A9QAmyA+vDPA1vKfeDx8oFVR7EPFzjQZZQw8+w==
X-Gm-Gg: AYBFou2fudW3SCaRPrfOUR6nOXHvNKI8rvLOkVwBf2bEwOmpR4VM603iMNnpcQMpsKl
	yZqjmvMGugkxg3bI3l3fkK9E5wWiGi9j4XGYVMK3/P7ZZcfu0ErgkFnwRK8166/+E1xUEMHrGKb
	zNsCuTU+49N9q8IpkQkIGBs8H2QyolHVKsY1OsdBeOjwTlmFlQdR9XvtfgAGtmS4rptd2kE2B20
	C1msYi97isGdLneotTJcEXY5QOBR83j2akfG5KKD8soeT4ySBkPkz2jJkDL4+ry92KpzqkQMQaK
	JoNDlOp6Iqv5zfTmKHVmdMChSIGFnXNi9aFZZR/oWf9+jYpXJgOSrC4Am7ykQUKs91LJJcySRHt
	s2kyOMHP1rT7vlbfzfk+YIJthAYtJPuqztUGErdluhaQ2gkR7XwWGgDsZJdv63BS2FPR7gx3kv9
	X3dHDcB9qDU10yBIafcX/l9ZIuqGzKOPCW1P9vPn0ZQJa4zFT3eAbOlSJou8fW0PW6DvuDX1jdw
	hM3oHWVkb+8yYK50XmO+f/EUHQJmPAFesgEAuY5uuO4bgCm
X-Received: by 2002:a05:620a:2809:b0:936:77d7:55a4 with SMTP id af79cd13be357-93bb76b85cfmr676967785a.19.1789591437256;
        Wed, 16 Sep 2026 13:43:57 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b78255316sm295176785a.29.2026.09.16.13.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:43:56 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.11
Date: Wed, 16 Sep 2026 16:43:41 -0400
Message-ID: <20260916204341.238841-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are pleased to announce rt-tests-2.11

To fetch:

Clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main
Tag: v2.11

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Thank to everyone who contributed.
patches and bug-reports are always welcome.

John Kacur


Ahmed S. Darwish (28):
  cyclictest.8: Comment-out SPDX license tag
  cyclictest.8: Synopsis: Remove -U
  cyclictest.8: Synopsis: Remove -w/-W
  cyclictest.8: Synopsis: Remove -y
  cyclictest.8: Synopsis: Remove -h flag
  cyclictest.8: Standardize --verbose paragraph formatting
  cyclictest.8: Remove left-over comments
  cyclictest.8: Align source file to 75 columns
  cyclictest.8: Separate source sections
  cyclictest.8: Capitalize section headers
  cyclictest.8: Synopsis: Fix parameters list rendering
  cyclictest.8: Rework the Synopsis blurb
  cyclictest.8: Synopsis: Distinguish --help mode
  cyclictest.8: Group system-altering options
  cyclictest.8: Group sleep-mechanism (clock) options
  cyclictest.8: Group thread wakeup timing options
  cyclictest.8: Group SMP-related options
  cyclictest.8: Group memory options
  cyclictest.8: Group thread priority options
  cyclictest.8: Group tracing options
  cyclictest.8: Group test duration options
  cyclictest.8: Group output options
  cyclictest.8: Group x86 options
  cyclictest.8: System options: Deprecate --laptop
  cyclictest.8: Options: Expand --default-system description
  cyclictest.8: Options: Reference clock_getres(2)
  cyclictest.8: Add example invocation
  cyclictest.8: Reference rtla-timerlat(1)

Costa Shulyupin (2):
  rt-tests: hwlatdetect: Add timestamp delta
  rt-tests: hwlatdetect: Add --time-format argument

John Kacur (13):
  Makefile: Use relative symlinks for Python scripts
  cyclictest: Simplify auxiliary clock parsing
  rt-tests: README: Remove obsolete -n option from cyclictest examples
  rt-tests: Add SPDX identifiers and fix documentation issues
  rt-tests: Add AGENTS.md guide for AI coding assistants
  pi_stress: Fix inconsistent barrier wait logic to prevent deadlock
  pi_stress: Validate numeric command-line arguments
  pi_stress: Improve error message for permission failures
  pi_stress: Fix error and debug message formatting
  pi_stress: Ensure null-termination of JSON filename
  cyclicdeadline: Fix potential path truncation in open_cpuset()
  rt-tests: rt-migrate-test: Report trace_marker write errno once and
    stop
  rt-tests: Create v2.11

Lukas Beckmann (1):
  cyclictest: fix growing shm stat file

Sebastian Andrzej Siewior (4):
  rt-tests: cyclicdeadline: Remove unused `alloverflows'
  cyclictest: Acquire a lock before invoking pthread_cond_signal()
  cyclictest: Make break_thread_id_lock a PI lock
  cyclictest: Make trigger_lock a PI lock

Suneeth D (1):
  cyclictest: Fix BUILD failure for GCC_VER < 14

Thomas Weißschuh (Schneider Electric) (6):
  cyclictest: Centralize clock option parsing
  cyclictest: Test the return value of timer_create()
  cyclictest: Fix error error returns for uclibc clock_nanosleep()
    fallback
  cyclictest: Correctly print clock_nanosleep() errors
  cyclictest: Allow symbolic clock names
  cyclictest: Add support for auxiliary clocks

 AGENTS.md                             | 416 ++++++++++++++++++++++++++
 Dockerfile                            |   1 +
 MAINTAINERS                           |   2 +
 Makefile                              |   6 +-
 README-Dockerfile                     |  11 +-
 README.markdown                       |   6 +-
 get_pylib.py                          |   1 +
 src/cyclictest/cyclictest.8           | 405 ++++++++++++++++---------
 src/cyclictest/cyclictest.c           |  93 ++++--
 src/hwlatdetect/hwlatdetect.py        |  26 +-
 src/pi_tests/README                   |  10 +-
 src/pi_tests/pi_stress.c              |  44 ++-
 src/queuelat/README                   |   3 +-
 src/queuelat/targeted-ipi/README      |   1 +
 src/rt-migrate-test/rt-migrate-test.c |  22 +-
 src/sched_deadline/cyclicdeadline.c   |   9 +-
 16 files changed, 850 insertions(+), 206 deletions(-)
 create mode 100644 AGENTS.md

-- 
2.55.0

