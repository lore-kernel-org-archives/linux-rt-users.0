Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240792F56
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898255; cv=none; b=tLDTQZJ2cphr1wiBE8GtmiRjSF9Bgvx1JjJVBdi5y885Vz3z76QXkF/I91ijVuPTJbpbn32IVrZ/SXOWG+Q8namBZ50p77P1KVpIseQOXvgj+2utg/4ZbIkKTBmc/44AUWnbjpPmfxPQEbHy61j8wfgg7xCgfrP+eD6ppxuDRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898255; c=relaxed/simple;
	bh=kIupS8VUp9KAjIQeHlMA69/vTFKehEgRgMOFYx0CmE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glQ6PtWOlG5tPZh+X83vnwFLOAuC2oYtg+QSCUUYR4LDe/1jBnuAj1vDNiVgREZuwTHpyxHJO0LnwKaE37v/67iZ8PPmL4EpiOcEm4zMwaqKXVYk2+IoaXd2yWbQSCPq5WYx+ZFCxl85b70wCO+7edULwpzo+AE6J85cn2bjg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jjwNh+Ju; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVJge5ss; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jjwNh+Ju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVJge5ss"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VOHqeLYnQA9XYiAOSVJh0llGy3oN0kiQz8CmFEACjng=;
	b=jjwNh+JuMMqq4oSRV8kSfsEN07t5ZkQRwm/T6VCJ1YbZk/4l46vWSSIb2BZYoCccFkdlxx
	XaAFiH+6qaiaseP0IvSRVUNoV6P+xm4tiBCMhO2Lh7ZuzHjVwVZP95Zemi1riMCYGqZpza
	7KwkMqCEvYV5DvOrmtwTLQ/hOMB2K5ssI01TAbuWsfHdxTv2fALZ3vnXV5/9mzKf6rQvPn
	xVjOZBGEW+L7UxBHAlY8LRCwaih6mJjSkdhyPCSOdxFakkcgjqdN4ahidDYLnORhZcaExc
	nXlhNMKHQx+5p9hBkAUc9b4RGqMWoJT/afdZRNEbUzak0fLw+CZbjP9aZFNOhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VOHqeLYnQA9XYiAOSVJh0llGy3oN0kiQz8CmFEACjng=;
	b=dVJge5ssaEt3Chx5U2Fy2bmKtD/ciifyRMUxJKwE+JIx/NI3KQbsUYr/Q0hu1TMdX6c+Ht
	wwiBhuLlSEO8WuCA==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 00/10] rt-tests: Remove debugfs usage
Date: Wed,  3 Sep 2025 13:17:07 +0200
Message-ID: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v6.17 starts to complain if /sys/kernel/debug/tracing is used instead of
the "official" directory. Official as "it is in use since v4.1" which
was released over 10 years ago.
All the "I need to mount it here" kind of workarounds are also outdated
and not needed since distros mount it properly.
There is no need of a "special work around" for this since other tools
such as trace-cmd expect that these folder exist.

Anyway. Started a small clean up, diffstat looks nice.

Sebastian Andrzej Siewior (10):
  README: Drop "debug" from the tracing path
  rt-utils: Remove mount_debugfs()
  rt-utils: Rename get_debugfileprefix() and let it look for tracefs
  queuelat, rt-migrate-test: Use tracefs for tracing
  rt-utils: Remove fileprefix.
  rt-utils: Simplify trace_file_exists()
  rt-utils: Decouple writting trace-marks with trace stopping
  sched_deadline: Use tracemark() from rt-utils instead cusstom
    implementation
  sched_deadline: Check the resulting size returned from snprintf()
  cyclicdeadline: Don't test for /sys/kernel/debug/sched_features

 README.markdown                       |  13 +--
 src/backfire/sendme.c                 |   2 +-
 src/cyclictest/cyclictest.c           |   1 +
 src/include/rt-utils.h                |   4 +-
 src/lib/rt-utils.c                    | 105 +++++++--------------
 src/oslat/oslat.c                     |   1 +
 src/pmqtest/pmqtest.c                 |   2 +-
 src/ptsematest/ptsematest.c           |   2 +-
 src/queuelat/queuelat.c               |   2 +-
 src/rt-migrate-test/rt-migrate-test.c |   4 +-
 src/sched_deadline/cyclicdeadline.c   | 128 ++------------------------
 src/sigwaittest/sigwaittest.c         |   2 +-
 src/svsematest/svsematest.c           |   2 +-
 13 files changed, 61 insertions(+), 207 deletions(-)

--=20
2.51.0

