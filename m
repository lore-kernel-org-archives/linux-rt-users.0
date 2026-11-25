Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635306;
	b=0c0gSzIn3LZU30NBouWYphrUL6gC8rXA66GwRlOCNKYiCnFPL4jyiJ/nVUVZu2RRhTLx
	 rP3kRwZBbzS+HUHeYmurSBZqUIhQN2HppoEOVWcnGv70VNeXB2AczPTYvsRLk8O6Gvi5T
	 waOzZTbyAmc5Tr5pArXOfPIaRuqKcHfOqQpjthYsipTQibNOQ8OC5mqI8+MfbsnuRdKwy
	 mVQn8sxJvuuIlZollARYyJFsthjkwGmaxhSxIwphASpa3g1allNcLf3QjeagbCm0moSsV
	 1p4/ldN/t9mjaI+a0GuLudAi4FAhm1V8f7BIq/F9pUA6nzXcQWDtaydiANatxQgULCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w41M/nkG0tcfkmvwtqN4/ZmEsM1MLvHHsaYGRLIX9ME=;
	b=SmsH132FENqbJNblDyDG9YSSTkPN0yI9BeB78YIY+qcIcU/UpL577WkJjRUL6BdS9/5I
	 wvtWkiSNzU8+gCWg378hOrcf3SWS4tuxH08li42qfcfgh2jRmES3qnBsr6FklHpDk/snU
	 M6L2ssD0a6U+ENXE6R9XMo7yfsa90Y2KI9dwzQfZ3uIad/Qxf28yQ2ITfmfhdfq9AuCEC
	 Fyv2a0FVna7R2P8q9TNCQsBQMnlwXamLoxLI0Ff2YOIItt1+DkoPQgy+ZOqGjwB5vw3i+
	 0y45vFgIni+sQ6eZCSJJNn45Es6+WvGDksDd4k4A13GZx8R1B/O/w73i/P9RTq7gg4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qEAHT311;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69AC606A321
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Nov 2026 19:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D69AC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qEAHT311
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53634b8328eso58526331cf.0
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Nov 2026 11:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795635305; x=1796240105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w41M/nkG0tcfkmvwtqN4/ZmEsM1MLvHHsaYGRLIX9ME=;
        b=qEAHT3110WGbzerpGwah3ie/Pk0Fgl/TMTAWqF/ymY4BjZPFLBzW2Gn8CeOyaorI/l
         BHZz0W2wYDiEKEvixZQggquYHsss94giDFT4rVUwzEE6i6twkf95fgW31510WhvP+qCb
         UeTyjAyUhT7QIaBgrjMa/GQ9pkrnYc6oP2444ehHBGffqfVVDXNdRaHny+CHiwT1iRIe
         xhmgf3tXyGbbewaRrdfs97Np7lEWvHGz1pckkeVOKy8OE52Os8jPrgKneqJWxvi/9KeY
         Fp39eyBvYtGc/OnK3e1i0ZYwrIYrHjGVGUF6J5krpO/LzcGiezT4yOw5g0VBgEUwPyBo
         LZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635305; x=1796240105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w41M/nkG0tcfkmvwtqN4/ZmEsM1MLvHHsaYGRLIX9ME=;
        b=RwNSGtS4U4cnZ0FBaBs7wIIpT1h6/2KoCh1SIo21IgOvmE1AiWT8ae6hVLvfq67TGG
         RquIXs7A1RUj/zZ6GPnktJptNkBF8FEu+1KAX5L1CBdS7kMwrGiGdBFLVfkmmXcHZ4rk
         8lmg7z7JQAX3VywFErXSYVzDnkmIN/9d83dL/zIGISvBnilMRuKQsIZZkyr++E24kg8P
         htY9y6FD4tnIXLJRfMEjalQ27fvbPuTCw1JzaiowcRGFls95MvCoBAvTMUPlgFBeNXj/
         CUBGK0ElFGNuWkKWNZIYVe0w3kJWxTX9MT0Wq0rOxdLafZJ4kzg13uP65v+9bEkIg9Hn
         0FIg==
X-Gm-Message-State: APuU4Z9HPCd1k/29ryoMfVrNuCEYbTKieuDVDRVxJupbgkMauUaEPLIx
	SQVDOfAX0cRB4CGc5HHJpLNV8+DoVzrm1wkXjS0Aym4SS8GTR83OVTVYpvi5ig==
X-Gm-Gg: AZFdTZdJixWtJqVRlD7d8AqgilZw0pipFtiP8yt0SvkNWZNh349GHzcrGu/s/dezQGX
	q0KIzhyvdBSm9viUHNgnDWvn7NKXp0M4RRz58ygGIT+Yu39BdfB9l98m5WaSNZPOu3NLKmFreKO
	kuJqVE1KWE7ELe7o1PU2yoKUn/DwfpxtHWkyn+cxCTlvnZEgmqzt6WavYiz6ge0uGSUWvVto5Dq
	akgfbk10NK2wnefQjbeNQYQZQQvXp4ST/xpdDTffFldI8nBK2GkDnmsTR8RyKyfaAmTDPUZVAuB
	aEs3Gf2xM6sOVb7Vp4U4Q2x+WX+WRdJCld6MxzcBK9YGwO5diiaPyhUNiKZEVAD/ZxXd88AyAtY
	R3LLrZt1joo0lxHVYcdV8ym7VvkHiMXYCBKMbtxqnuy4qTM6eoFZlSAy2DdEEL9dDstlRQzbbhI
	1WaQMdUllIvEFaySIy1vXvBJKCVWo7wq9a9JgQh8oghuGuTTD11flZMxc/KG925ak5GyzSsU96r
	qvHJcBtJ08ykO8zYe5nvC+Vg+1kuxLwFirQej9OF0fiq/yAqoNsWmjnkZ39d1ZyiK9V1NU2rY/F
	3qRSiQK+KY3+4/m4B6T381A6SbCwwrG7zhTcP8Chk+2ZZXZKqNefCL34eFTYzcDRjDSjh1GEmd/
	w
X-Received: by 2002:a05:622a:4c87:b0:533:9381:7603 with SMTP id d75a77b69052e-55d76a27d57mr332102951cf.12.1795635304819;
        Wed, 25 Nov 2026 11:35:04 -0800 (PST)
Received: from brigit ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e32dsm165726201cf.13.2026.11.25.11.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:35:04 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [ANNOUNCE] rteval-v3.14
Date: Wed, 25 Nov 2026 14:34:50 -0500
Message-ID: <20261125193450.73229-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are happy to announce the release of rteval-3.14
rteval-3.14 focuses on multi-stressor support for stress-ng and finer
control over the CPUs used by loads and measurements.

New Features:
* stress-ng multi-stressor support - drive several stress-ng stressors in
  a single run (Sana Sharma)
* --loads-cpuset - confine the load modules to a specific member cpuset
* --measurement-member - place the measurement threads in a member cpuset,
  guarding against measurement/load cpuset overlap

Improvements:
* No measurement cpuset is created when running with --onlyload
* Added CpuList intersection and difference helpers

Testing:
* make test-all runs every suite and the test harness now fails on failures
* Expanded unit tests, including stress-ng validation and argument building
  (Sana Sharma)
* End-to-end tests updated to cover multiple recent changes (Tomas Glozar)
* cpuset and core-sharing tests are now independent of host SMT topology

Bug Fixes:
* Guard load-module config iteration against non-string values

Documentation:
* Document enabling the rteval-mcp server at user scope (ENABLING.md)
* Add README-colors explaining the washed-out --help colors

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.14

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older

To accommodate distributions that require this, I have linked the last
version v3.13 from the older directory to the current directory

Bug reports, patches, etc are always welcome.

Enjoy!

Stats: 30 files changed, 1520 insertions, 231 deletions

John Kacur (27):
  rteval_mcp: Register MCP server at user scope in ENABLING.md
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
  rteval: Add SPDX and copyright headers to test files
  rteval: Improve test_stressng output readability
  rteval: Add CpuList intersection/difference helpers
  rteval: Don't create measurement cpuset with --onlyload
  rteval: Add --measurement-member and guard against measurement/load
    overlap
  rteval: Re-enable cpuset overlap tests for the new behavior
  rteval: Move --measurement-member into the measurement module option
    group
  rteval: Add tests for overlap-check gating and --measurement-member
    help
  rteval: Guard load module config iteration against non-string values
  rteval: Add --loads-cpuset to confine loads to a member cpuset
  Add README-colors to explain washed-out --help colors
  rteval: Test stressng opt-out and arg building
  rteval: Fix validate_stressors() docstring Raises claim
  rteval: Make core-sharing tests independent of host SMT topology
  rteval: Skip cpuset partition tests when CPUs are not cgroup-usable
  rteval: Pick cpuset integration-test CPUs from cpuset.cpus.effective
  rteval: Create rteval-3.14

Sana Sharma (3):
  rteval: Added unit tests for stress-ng validation
  rteval: Fixed hardcoded paths in class TestCpusetManagerCLIIntegration
  rteval: Add multi stressor support

Tomas Glozar (1):
  rteval: Update E2E tests to cover multiple recent changes

 .gitignore                                    |   2 +
 Makefile                                      |  27 +-
 README-colors                                 |  56 ++
 rteval-cmd                                    |  51 +-
 rteval/__init__.py                            |  42 +-
 rteval/cpulist_utils.py                       |  26 +
 rteval/cpuset.py                              |  37 +
 rteval/cpusetmanager.py                       | 125 +++-
 rteval/modules/__init__.py                    |  20 +-
 rteval/modules/loads/__init__.py              |   6 +-
 rteval/modules/loads/hackbench.py             |   7 +-
 rteval/modules/loads/kcompile.py              |  12 +-
 rteval/modules/loads/stressng.py              |  88 ++-
 rteval/modules/measurement/cyclictest.py      |  13 +-
 rteval/modules/measurement/timerlat.py        |  13 +-
 rteval/version.py                             |   2 +-
 rteval_mcp/ENABLING.md                        |   9 +-
 tests/cpusets/test-cpusets.sh                 | 633 ++++++++++++++++--
 tests/e2e/measurement.t                       |  14 +-
 .../mock-cyclictest-partial-output.py         |   2 +
 .../mock-rtla-timerlat-partial-output.py      |   2 +
 .../test-cyclictest-error-handling.sh         |  28 +-
 .../test-timerlat-error-handling.sh           |  31 +-
 tests/run_tests.sh                            |  41 +-
 tests/test_core_sharing_validation.py         |  25 +
 tests/test_cpulist_class.py                   |  62 ++
 tests/test_cpusetmanager.py                   | 183 ++++-
 tests/test_measurement_module_selection.py    |   1 +
 tests/test_stressng.py                        | 187 ++++++
 tests/unittest-legacy.py                      |   6 +

--
2.56.1
