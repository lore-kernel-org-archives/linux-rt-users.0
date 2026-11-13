Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613587;
	b=3DcbB/mdcq/b5iY7+Poir9xqyDKnjR9z+SUt6HcWWIe0KH+gaUrVZkgD9VdnE6dWTLuk
	 ROpqja6CI2A9Ql/QjAjlKURKDTXn3AEfc43KaRTVf5B77Huc4RXhZEtExVOviIeFvftPN
	 o8wkLpg1bLz3Qg3M6HfIwi/9/JlNTwhjeLEFBdW2tuJE+hfQ+c4PFaNLBGjub5R2E7vyJ
	 U9/xfOXXhimC+EbVjVY+Hk8UX01FYI+wFIwK4TnGJgjvLppa3gis8M3M2luOrQjWtfNsk
	 gKxDfRM1pJ8qM72vPWe6ZQ41H3GhkvnsYPvPxGJx4/s3QrCIEKhrWmSwUwV19AcePmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613587;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=hmFiVjCHkHzUr03pSnCQ8bKjfOyhaFNMjs6WTvmGNrU=;
	b=WkAeEJ6yiu5JR+PeiTjI8JOWKEzg0mOvPaphQRhbOexcmxnc2AckCpZEU92r5U3A/dRT
	 b4dAO7BTcantIB3Uzmz6SAQkYWKuYIUP4E11F2Ee6u2tolFHedPEXwCsK70f6YhhGRgWF
	 qKgyH5B+CdipB8C5EecmtDpiIinN3jjuFkSYF9vlrZg7+rs1V0h5as1MXSDN2GcaBevt4
	 QGyxPW8zwb47D6yq/PK+zAnLdsZzoyqCfGdIeCE2FTFoSdrYXoWEgR8MZuMQ4SVk4k0ZX
	 cRBbBT5OPfL7zAqvhQBIJJWPCgiqSQe29pLxvGUlKuNoraYw9FltLKJzIjUmCuax1Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ja/QeTkN";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BF606A338
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281BF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ja/QeTkN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794613585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hmFiVjCHkHzUr03pSnCQ8bKjfOyhaFNMjs6WTvmGNrU=;
	b=Ja/QeTkN9RUhh8Z7s1ntRVUIEhQ9ac4mcUciTT14OwleWPKnuSYX7TSVFV0IakOUog5Xqk
	seQENXn3IV/R5OOJu1lCcUhTnLyF4P4ZHdyVOXkAxsnMt8wmVnaOvL9vE/0vB4UTnJqZFP
	51QLi2swOdZZraZVrUgv3kBg21yylEE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-KnTsm8a-PC2sZsvwbbeKBQ-1; Fri,
 13 Nov 2026 18:46:23 -0500
X-MC-Unique: KnTsm8a-PC2sZsvwbbeKBQ-1
X-Mimecast-MFC-AGG-ID: KnTsm8a-PC2sZsvwbbeKBQ_1794613582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD2A51956095
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:22 +0000 (UTC)
Received: from dev-workstation (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB22D30001B9;
	Fri, 13 Nov 2026 23:46:21 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 0/5] tuna: cpuset isolation error handling, state save/restore, and robust teardown
Date: Fri, 13 Nov 2026 15:46:15 -0800
Message-ID: <20261113234620.1608227-1-chwhite@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series hardens tuna's cgroup v2 cpuset isolation and teardown paths
and adds state save/restore capabilities to allow cleanly undoing CPU
isolation.

Overview of changes:
- Patch 1: Check cpuset partition state on isolation and propagate errors.
  Ensures that when creating an isolated partition, tuna verifies the
  partition state became 'isolated' (and raises with kernel reason text if
  invalid), rather than silently ignoring errors or invalid partitions.
- Patch 2: Verify cpuset controller is enabled in parent cgroup before
  creating child cpusets, and remove the new directory if activation fails.
- Patch 3: Handle EBUSY and EPERM in thread isolation loops consistently
  with processes, and aggregate unmovable IRQ warnings on stderr into a
  single line. The single line is deliberate: callers can parse it to
  learn which IRQs stayed on the isolated CPUs. The pre-isolation IRQ
  masks are also read at the runtime CPU count rather than from procfs's
  online-CPU-width copy, so masks referencing offline CPUs are not
  truncated and mistaken for modifications.
- Patch 4: Add 'tuna isolate --save-state <file>' and 'tuna restore --state <file>'.
  Saves pre/post thread affinities, IRQ affinities, default SMP affinity, and
  boot_id atomically to JSON. On restore, tasks whose affinity drifted or whose
  PID was reused are skipped, while unaffected tasks and IRQs are restored.
  tests/test_isolate_state.py drives every branch of save, load, capture and
  restore with the /proc helpers mocked, and needs no root.
- Patch 5: In destroy_cpuset, demote partition to 'member' before rmdir so
  that isolated CPUs are immediately released back to root, and retry rmdir
  on EBUSY with a 1-second bounded backoff to allow terminating or migrating
  tasks to finish draining. The same helper backs Cpuset.destroy(), so the
  auto_destroy context manager drains the same way. The EBUSY case is
  reproducible, not theoretical: a caller tearing the partition down right
  after workload exit needed its own 20 x 50 ms retry around
  'tuna cpuset destroy' to keep runs from failing, and that retry now lives
  in tuna where the drain happens.

All five patches were tested and verified by running tuna isolation
scenarios with SameStack's runtime isolation lease, which drives
'tuna isolate ... --save-state', reads the partition state back, and calls
'tuna restore --state' on release. The B-tuna campaign ran this series on
realtime-04, and a 40-round isolate/destroy/restore soak covered centos-dev.
Every commit also carries unit tests that run without root, except the
invalid-partition test, which requires root and cgroup v2.


Chris White (5):
  tuna: Check cpuset partition state on isolation and propagate errors
  tuna: Verify cpuset controller is enabled in parent cgroup
  tuna: Handle thread EBUSY/EPERM and aggregate unmovable IRQ warnings
  tuna: Add --save-state to isolate and a restore command
  tuna: Demote partition and retry rmdir on EBUSY in destroy_cpuset

 Makefile                      |   7 +-
 docs/tuna.8                   |  13 +
 tests/README.md               |  15 +-
 tests/test_cpuset_errors.py   | 411 +++++++++++++++++++++++++
 tests/test_isolate_errors.py  | 174 +++++++++++
 tests/test_isolate_restore.py | 155 ++++++++++
 tests/test_isolate_state.py   | 550 ++++++++++++++++++++++++++++++++++
 tuna-cmd.py                   |  38 ++-
 tuna/cpuset.py                | 124 ++++++--
 tuna/isolate_state.py         | 233 ++++++++++++++
 tuna/tuna.py                  |  35 ++-
 11 files changed, 1723 insertions(+), 32 deletions(-)
 create mode 100644 tests/test_cpuset_errors.py
 create mode 100644 tests/test_isolate_errors.py
 create mode 100644 tests/test_isolate_restore.py
 create mode 100644 tests/test_isolate_state.py
 create mode 100644 tuna/isolate_state.py

-- 
2.52.0

