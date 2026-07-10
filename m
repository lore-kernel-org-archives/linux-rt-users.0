Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C238E5DA
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690715; cv=none; b=Bivs2bhRMqByPbgAYel12GOe4Sag/y/1mcgiHvPiK/eGHkd357CnlDp244b0/FdCZhqWcFzm5EPhYm43hKQ0OgIGCGbs3FU9r1zql25jXkmwAoQVhDRcboEds7PlTyalx0jwR6fz1qXqFkusuJ5N5WD/RyysOCgyixYew7MP6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690715; c=relaxed/simple;
	bh=cd1FzwTnexHcrZZ+0P0S3UBKmhMtRJhKk7u4TLelI9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvvMzQn8VQz2z3X9z3A1Xja5Stjlr7i+Xbv0nw2Bv9eYpVqg0hA9ZIIy5xj7nTk8lAFl/bSv19zLT95e4dmFVxw7nurrlv8C7KyUFNM3Vhbkdx7NYprVZ6QQICLy/lq9ujA9iKMZhpiP1hwAS/eJiDDH7reJnxqNtCez2TSrhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uu7SPclB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uu7SPclB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rSNDHSLuWkP3Ru445ukHiY5+jlTQSv68Q/AacevZwGQ=;
	b=Uu7SPclBZrZP+mMXqzvOnaTm1J2BzT5iaVRsPdoy+azr4dLz2YJdfmzp4dQWh74MfruImH
	WVLDV60WDAPIE5HPLACCbl7DFYzm2P9qHcb3tIBaFYVuS2PADMhoBCuuT+XGa/4+Sn9zRj
	Cpvpd240rxzdCNnb7PmQBWVsUDUwxD0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-5M8pK49qOe-Yo5bXucoapA-1; Fri,
 10 Jul 2026 09:38:27 -0400
X-MC-Unique: 5M8pK49qOe-Yo5bXucoapA-1
X-Mimecast-MFC-AGG-ID: 5M8pK49qOe-Yo5bXucoapA_1783690705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 916471955DD7;
	Fri, 10 Jul 2026 13:38:25 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3F5F195608E;
	Fri, 10 Jul 2026 13:38:22 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 00/11] tests: harden functional test suite against flakiness
Date: Fri, 10 Jul 2026 10:37:59 -0300
Message-ID: <20260710133810.72398-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The functional test suite had several sources of intermittent
failure and weak diagnostics that made CI failures hard to
reproduce and debug: readiness detection for both stalld and
starvation_gen relied on fragile heuristics and racy liveness
checks, a test-ordering assumption used across several test
files turned out to be backwards, and the stalld startup
timeout was too short for PREEMPT_RT systems with large CPU
counts, where BPF tracepoint attachment can take well over 15
seconds due to SRCU synchronization. On top of that, many
assertion and startup failures did not dump the relevant log
output, and the test framework's own logging polluted the
system journal that other tests inspect directly.

This series addresses these issues end to end. stalld gains a
single deterministic "monitoring started" log marker emitted
once initialization completes, giving the test helpers a
stable synchronization point instead of matching internal
debug messages that could change across refactors. The
starvation_gen readiness check is reordered to check the log
file before process liveness, so a transient kill -0 miss no
longer aborts an otherwise healthy test. All 15 affected test
sections across five functional test files (test_fifo_boosting.sh,
test_fifo_priority_starvation.sh, test_starvation_detection.sh,
test_starvation_threshold.sh, and test_log_only.sh) are
reordered to start stalld before starvation_gen, since source
analysis showed the previous ordering rested on an unfounded
assumption about stalld's scanning loop and was itself a
source of intermittent timeouts. The stalld initialization
timeout is raised from 15s to 240s to tolerate slow BPF/SRCU
synchronization on large-CPU RT systems, paired with startup
timing instrumentation so the actual latency stays visible.
Diagnostics are improved by dumping log contents on every
assertion and startup failure, and helper functions are
switched to consistently call fail() instead of silently
swallowing errors. The test framework's own logging is
trimmed to stdout only, removing journal writes that had been
contaminating journalctl-based assertions in other tests.
Finally, run_tests.sh gains --verbose and --fail-fast options
for faster local debugging and CI triage.

With the exception of the single log marker added to stalld's
initialization path, every change in this series is confined
to the test framework and functional test scripts; no other
daemon runtime behavior is touched.

Wander Lairson Costa (11):
  stalld: add readiness log marker for tests
  tests: use fail() for error paths in helpers
  tests: add --verbose flag for bash trace output
  tests: drop journal logging from test framework
  tests: fix intermittent starvation_gen readiness failure
  tests: add --fail-fast flag to stop on first failure
  tests: dump log contents on assert_log_contains failure
  tests: dump log on start_stalld_with_log failure
  tests: start stalld before starvation_gen in all tests
  tests: add startup timing to stalld launch helpers
  tests: increase stalld initialization timeout to 240s

 src/stalld.c                                  |  2 +
 tests/functional/test_backend_selection.sh    |  2 +-
 tests/functional/test_fifo_boosting.sh        | 22 ++---
 .../test_fifo_priority_starvation.sh          | 38 ++++----
 tests/functional/test_log_only.sh             | 10 +--
 tests/functional/test_starvation_detection.sh | 18 ++--
 tests/functional/test_starvation_threshold.sh | 23 ++---
 tests/helpers/test_helpers.sh                 | 86 +++++++++----------
 tests/run_tests.sh                            | 23 ++++-
 9 files changed, 109 insertions(+), 115 deletions(-)

-- 
2.55.0

