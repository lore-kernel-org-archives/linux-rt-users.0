Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17337AA92
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899879; cv=none; b=nFof8Uz0UrR5vscr3RzuPc9sgeiHH64VMKGq7+Te180yPnVZb2hUfBIlPXQWvLMV3qio3XEOP3WhR0CUO9h4DiNKdnzWAdRJfprU9lVg2WHHlAWm6DnYZ8htharTZrOSbjvj4sUetly2EpDy2Gm1rY8iRVCFMhJl8N06fq49bSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899879; c=relaxed/simple;
	bh=AsWezCWdef1rsk9u/aKiEwh2s1ihQuModdczV2pBQPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dt/GCnre/prqm1DG2opEJeDV9lTNS3VeU2Ia++h7/x0WNDWW84f8qtCHNii1uAjZ7caDtqax0U34lX4lAyeYSKK9dVLqNHPv/vKQ9sOxOuf1U0nynDIenlkxcHFiT/bJIwUfLcmJjYnG5D5YX5G5bRI7S0IyJswUGTpkofWoyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfuLuES6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfuLuES6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8PDFYq6+4B3o7wWlL+5PyBmojRGFzeLWZxJ6PE4qxZ4=;
	b=KfuLuES6EmFI+UimsknZVkTykJLYc3il7uJ4fgyWf1KYgNdE+bAR1YcKWYAIH9pgYZ3UeT
	SRozAvB1PLiwNtptSi6MsilFkfPbeo+FcQB7IqIj5LR8qMysmfkZABqii6mvQXz1VRCEKR
	ZaaIOkbnAqnHcK/V+AOQ1BdgJLKRwyg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-L-Ji-iKrN6a5YDfwO8EX0g-1; Mon,
 30 Mar 2026 15:44:36 -0400
X-MC-Unique: L-Ji-iKrN6a5YDfwO8EX0g-1
X-Mimecast-MFC-AGG-ID: L-Ji-iKrN6a5YDfwO8EX0g_1774899875
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B315018002DD;
	Mon, 30 Mar 2026 19:44:34 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D4021954102;
	Mon, 30 Mar 2026 19:44:31 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 00/36] tests: Replace timing-dependent synchronization with event-driven helpers
Date: Mon, 30 Mar 2026 16:43:23 -0300
Message-ID: <20260330194410.103953-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The stalld test suite relies heavily on hardcoded sleep calls for
synchronization: waiting for stalld to initialize, for starvation
to be detected, and for boosting to occur. These fixed delays make
the tests both slow (sleeping the full duration even when the event
happens instantly) and unreliable (too short on slow systems, too
long on fast ones).

This series replaces approximately 120 sleep calls across 20 test
files with event-driven helpers that return as soon as the expected
event occurs. The core mechanism is wait_for_log_message(), which
uses process substitution with tail -f to detect log patterns
instantly rather than polling. On top of this, domain-specific
helpers like wait_for_starvation_detected(), wait_for_boost_detected(),
start_starvation_gen(), and start_stalld_with_log() encapsulate
common synchronization patterns into reusable functions with proper
readiness detection and cleanup.

The series also introduces pass() and fail() helpers to standardize
test result reporting, replaces duplicated stalld invocation
boilerplate with shared helpers, and fixes several pre-existing test
bugs exposed by the tighter synchronization: invalid argument tests
that never actually failed, a multi-CPU detection grep that was too
restrictive, and FIFO fallback behavior that was incorrectly treated
as an error. A stalld source fix is included to die on invalid CPU
affinity, which was silently ignored.

Clark Williams (1):
  tests: Add pre-test and post-test cleanup of stalld processes

Wander Lairson Costa (35):
  tests/helpers: Fix stalld daemon detection in start_stalld()
  tests/helpers: Remove duplicate log() function
  tests: Add per-test runtime measurement to run_tests.sh
  tests/functional: Fix and refactor test_backend_selection.sh
  tests/functional: Fix test_logging_destinations.sh path and backend
  tests/helpers: Replace sleep with poll in start_stalld_with_log()
  tests/helpers: Fix stop_stalld() timeout and shutdown logic
  tests/helpers: Fix relative path in backend detection functions
  tests/functional: Remove redundant post-stop_stalld sleeps
  tests/functional: Fix false positive log matching in
    test_logging_destinations
  tests/helpers: Rewrite wait_for_log_message() with process
    substitution
  tests/helpers: Add wait_for_stalld_ready() and use in
    start_stalld_with_log()
  tests/helpers: Fix fractional sleep timeout bugs
  tests/helpers: Flush stdout after starvation_gen startup messages
  tests/helpers: Add start_starvation_gen() helper function
  tests/helpers: Add wait_for_starvation_detected() and
    wait_for_boost_detected()
  tests/functional: Use start_starvation_gen() helper
  tests/functional: Replace detection sleeps with event-driven helpers
  tests/functional: Remove duplicated -a flag in
    test_fifo_priority_starvation
  tests/functional: Add missing -a flag in test_starvation_detection
  tests/functional: Use start_stalld_with_log() in test_log_only
  tests/functional: Use start_stalld_with_log() in
    test_logging_destinations
  tests/functional: Use start_stalld_with_log() in test_cpu_selection
  tests/functional: Use wait_for_stalld_ready() in
    test_backend_selection
  tests/functional: Use timeout for error path in test_force_fifo
  tests/functional: Use timeout for invalid argument tests
  tests: Add pass() helper and replace assert_equals hack
  tests/functional: Use pass() for all test pass reporting
  tests: Add fail() helper and use for all test failures
  tests/helpers: Use pass()/fail() in assert functions
  tests/functional: Fix multi-CPU detection in test_starvation_detection
  tests/functional: Accept FIFO fallback in test_fifo_boosting
  tests/functional: Fix readiness detection and FIFO fallback in
    test_force_fifo
  tests/functional: Fix invalid pidfile test in test_pidfile
  stalld: die on invalid CPU affinity

 src/stalld.c                                  |   6 +-
 tests/functional/test_affinity.sh             |  43 +--
 tests/functional/test_backend_selection.sh    | 193 +++-------
 tests/functional/test_boost_duration.sh       | 118 ++----
 tests/functional/test_boost_period.sh         | 116 ++----
 tests/functional/test_boost_restoration.sh    |  79 ++--
 tests/functional/test_boost_runtime.sh        | 132 ++-----
 tests/functional/test_cpu_selection.sh        |  79 +---
 tests/functional/test_deadline_boosting.sh    | 116 +++---
 tests/functional/test_fifo_boosting.sh        | 133 +++----
 .../test_fifo_priority_starvation.sh          | 106 ++----
 tests/functional/test_force_fifo.sh           | 101 ++---
 tests/functional/test_foreground.sh           |  18 +-
 tests/functional/test_idle_detection.sh       |  40 +-
 tests/functional/test_log_only.sh             |  46 +--
 tests/functional/test_logging_destinations.sh |  51 ++-
 tests/functional/test_pidfile.sh              |  75 ++--
 tests/functional/test_runqueue_parsing.sh     | 118 +++---
 tests/functional/test_starvation_detection.sh | 136 +++----
 tests/functional/test_starvation_threshold.sh |  98 ++---
 tests/functional/test_task_merging.sh         |  69 ++--
 tests/helpers/starvation_gen.c                |   1 +
 tests/helpers/test_helpers.sh                 | 351 ++++++++++++------
 tests/run_tests.sh                            |  61 ++-
 24 files changed, 905 insertions(+), 1381 deletions(-)

-- 
2.53.0

