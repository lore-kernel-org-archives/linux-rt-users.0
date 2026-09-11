Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F13C196B
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152976; cv=none; b=mbiV8DlYaeT12gmBY5Ywjdk6300c2jK6EcS7+IkDVaqNmA6LgXsxdSD8Z2q2ONJdMgPs59vluogl4MdfAz85QTFrORxwY6wwYgbcSN93ZKPfaW6h2pp4KBNJY0IOHoP9jWMyiMfLQFgG0MCWj3SlK3BSmGU+HZFQjZxSfU3hzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152976; c=relaxed/simple;
	bh=a7dOAuQqsvOOdZ0brlvZsJckROHCuCL0qlusDKwIzLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Juhhk9OEP2oRFsxiS9/d2BBgRjEAPx6OGYpgyOE5mf9Wz5eAMemK8jPybg4B2dpbPK7VZRlOxuX+NDSJdMfCSTKTsXAjeMeQJkFAqRvFiGT9CltiuJc0L7EmqcX63KuAjnuQRjTWgzNrJS9btPG80ih+xA6o5jzjC1fOi+0afBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSNCGamk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSNCGamk"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90cd8e45460so15334276d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152965; x=1789757765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=esmtb5TDbb9AJ3l/gPy/9cxe/byvaVc7phNQuORDn28=;
        b=rSNCGamkgdEHv1u7F1uycxGsVB5QrtsufmeUWpf+yqhpI3WpcbUJFxMC7P5mskBs+m
         Fyplc7Gzc0NTmnojaE/cpyK+YzqvbqSAL8QJuODrq+BrbtRAudIXkjHqpORIBQ22R0rJ
         IIG0UInplXm66V60Ov+8p/vCf9eJX4MfnpRMUs655tT4s3hFuKVWgmH0TcZV5bcfq35k
         iUyCSZoYW9oQ7RR/Dscej5VWIH7gZvJKKQ7NUpfDqpNKxEar51LdGCtHTpPReUm+Ansq
         jUoSYM59cfu8AbCmmBzh1Zmb+RMAlNUcty7ytUyG6HwA58/i+nwUEXHVGKqP2PTh7BwU
         oEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152965; x=1789757765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esmtb5TDbb9AJ3l/gPy/9cxe/byvaVc7phNQuORDn28=;
        b=FSwIGW8A3zGGDoj0QJnIkV34OxsMs3KoIQDB+X36GVvUs2H/8puBckq0snuEXgDe9p
         GBKzd9bsLYhH5aysj2PtenwJTH1dTV3LDqoqfg/Gg2FCNDnE7VUEDFN9avf5b5MYG9Ms
         EMdu+OuyweSjk2uDUbUQ9O6h3cMCBn4czUB2bTAlP+UjPmOiyiXJSNDoVSWmQssGQBqe
         FW+z9rqKLfWUeexTazLCORqB4vjJswJEWg+3PVDec0eJyPqghntKPtcgPzYrPR7HE/ul
         hDMtKIrscQxA4nEY7RxrlGX+2i+5U+zrCfo+6meVdqzPQ7rnuuDWG33QTFWGGt/G+iPM
         Om4g==
X-Gm-Message-State: AFuF++nrXeYS/UdXX0RyPTZF6ANsU0HadJlPHyGIlYjWwTplveSiXmLS
	W6aV5bBqmNxuBjRY75C72V4w94ys0H/j0d95KlkJDvQ7dgEIABIjM0AHWyzNHQ==
X-Gm-Gg: AYBFou1nrYvYANr7WCAeHbYqJ5p9VnQF02fyxPEI92lcYyEMWXOL59Vegj5L5nrD3I3
	I4DW9+8Dpb809Tah5d/EaVjmiJFy2QvK47AUcL+hzj/d5iwIXmxctgH32gz+Rlseh00uBVzupmZ
	O7s0vmGpnQArgxPa+Nef0BheyOqConTN1shDjlaA+CCpWRSnHryP5vE1MI0t8DrzXzAK+yhH98c
	9p4EqOZxB2+eD4pARu/Cw8THpG7W6wToMKAsAYUbYbMvYPV70n+nVIzrl4GEmU/WURrPBcpxoRi
	BbDvQcR0rO8qvNDpXwSP5WS6bHly7Cz/zTldqMoPVLzha81qzpN/rxCKg6bHHIB7wEJN4ppR9FP
	FoTcyErapABAObmxl+sHGxepY7LzMfe4cwz3kwM1PozfCIO7sRvMsL+3m2pq7R/zWV+vbxb8Ne1
	c7S2V1hxEgIK+yd9m0YtI6JIg8eN8gAyabSSFyplT9QNLlN2pg2cJGzLx1+BKH+ocW5xhcra/O0
	DUeCPeShKC4bOQE7ruf40kdDX4rtqCMUs1PfmzsbT+rUNsABBIQ7DDxdNPbxC2U
X-Received: by 2002:a05:6214:2b0c:b0:910:3453:505d with SMTP id 6a1803df08f44-912120f346bmr70392276d6.31.1789152965550;
        Fri, 11 Sep 2026 11:56:05 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:05 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 00/10] rteval: Test suite fixes and improvements
Date: Fri, 11 Sep 2026 14:55:33 -0400
Message-ID: <20260911185549.604199-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series collects a number of fixes and improvements to the rteval
test suite.

Tomas Glozar's patch updates the E2E measurement tests to cover several
recent changes. The remaining patches make the test tooling more robust:
the top-level Makefile now defaults to help and gains a test-all target
that runs every suite, the unit test harness now fails on test failures
instead of masking them, stale malformed-data log patterns in the
regression tests are corrected, the cpuset test detects rteval-cmd
regardless of the directory it is run from, *.log test artifacts are
ignored, and the cpuset tests expect the correct 'isolated' partition
type for the measurement cpuset.

The last three patches concern the cpuset and regression suites. 'set -e'
is removed from the cpuset suite (it aborted the whole run on the first
backgrounded rteval that exited non-zero). Three cpuset tests are
temporarily skipped: they exercise an unresolved interaction where an
isolated measurement cpuset removes its CPUs from the root cgroup, so
taskset-bound loads overlapping the measurement CPUs fail; they are
skipped with an explanatory TODO until the design decision on the
measurement cpuset partition type / load CPU placement is made. Finally,
the cpuset and regression suites now write their logs and work
directories under tests/logs/ instead of the repository root, with a
new 'test-clean' target to remove them.

John Kacur (9):
  rteval: Default make to help and make test-all run every test suite
  rteval: Make the unit test harness fail on test failures
  rteval: Fix stale malformed-data log patterns in regression tests
  rteval: Fix rteval-cmd path detection in cpuset test
  rteval: Ignore *.log test artifacts
  rteval: Fix expected partition type in cpuset tests
  rteval: Do not use set -e in the cpuset test suite
  rteval: Temporarily skip cpuset tests pending isolated-partition
    decision
  rteval: Write test artifacts to tests/logs/ instead of the repo root

Tomas Glozar (1):
  rteval: Update E2E tests to cover multiple recent changes

 .gitignore                                    |  2 +
 Makefile                                      | 27 ++++---
 tests/cpusets/test-cpusets.sh                 | 70 +++++++++++++++----
 tests/e2e/measurement.t                       | 14 ++--
 .../test-cyclictest-error-handling.sh         | 26 +++++--
 .../test-timerlat-error-handling.sh           | 29 ++++++--
 tests/run_tests.sh                            | 40 +++++------
 tests/unittest-legacy.py                      |  6 ++
 8 files changed, 153 insertions(+), 61 deletions(-)

-- 
2.55.0

