Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B51D6AA
	for <linux-rt-users@vger.kernel.org>; Fri, 27 Feb 2026 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232374; cv=none; b=Alp/1Jgodc0eUH5QDuh4FVpZ7JnnDuXhvS5FWiId507SyQ2R6cTIHChOAmgh4X4FlZrQeQ52JLSJ3gh7tL8CHrGJua5HW+VG3zs6SpxwiiI09sg/n92b8qbv69+HQ1MHW3Y+it1xSFREeqkNTRGVZxwczik3eDDdve8ZHBEniLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232374; c=relaxed/simple;
	bh=/qXMYqZGMoU2zhuTkBdNVDlKgwLF+44xPhSHJ9AdiOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbkAJ7J8Un7P0fUtZf+Nr/nmacAoJYnOM8udatAT5iW67hGIZQli7B+f7EixIRG6ybSZ6N9WEDEKov2YBamkUbieMuAPou+PLW4H9QU7180rgXLZAUwToxHdxBd0IBMLqhbDH/SBtnWbDRGbGpFTx2Q1voaLBtxVUSPYbJ5vk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkbN8WO0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkbN8WO0"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb40030be5so249665785a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Feb 2026 14:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232371; x=1772837171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0g++K1qC8mViE13GfcAGGgWEtEvCIcAX+5LAErx02IU=;
        b=QkbN8WO0dqUbxUhVFj/YnkiAIbQvh4vCUooUQt6rJChsS8H17hD13KrsZ/JKgM2Dka
         8EX2NS4VGeYBZRw8DDCffeBwNyYc+O2vVWqUZY7R1xtRmCRAnxRrleaR3PEiMOCmux27
         OK/1R2s8nYopUppsN34VQg8F91iUuNC9zd/qKk5ToaNq6dbcbf/4giDv+LnE47c1fzCn
         tQeSSdjk0uZlnYzL1ahsE89co2mN0LXV0p9bC4ebmzVaJAX22BRR+ePHOwaaWRIZXVZu
         RkzAbZ05QvpR/p+C+fQNZLyjyd89bE1ymroHdwezOrWbeTAlFkhoyTHeOxWtUdjLzHHf
         lxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232371; x=1772837171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g++K1qC8mViE13GfcAGGgWEtEvCIcAX+5LAErx02IU=;
        b=QoLKs27VipJKEzniW0fytNTwzt2gmdBJzizRJXDW7vWw/HKPgqnIZw50NhVYfu4W2a
         Xmf7Mh59NHigk4/W1rYxsoRw3TGkqNsUcwCdSc8dx38bYJ6gBC0RCXbWo7/wWEtq/2rK
         0lAzaBCVH9X0sEhsIRadeNUipDQZrMgUccSGEUDgubOcDjE8yRi/dJE3Gp8xjYhIoxSM
         XGgCjG/ADjWb7I23PbXptUnoJn8VXbA0eNvWen1TNH2h5iRaXEsddVLmU1zjztKumFvl
         NUZVf/rISNaQmHMGdFnQmf6aNU16N7Q8TBI6IG6zNQd2w8yf+dUSNgEWlCQK3JD9RD4e
         h5pw==
X-Gm-Message-State: AOJu0YyfmCqpJ+vQkIabyZuV7IkRHVALdVhYCbXChC81yKMwXgN/ZI1N
	JYGmdT0MhmBbb7QcyrRqXm3169D8zLJYIeTBgc6BydNojlz97EShLWnheqLCgZGS
X-Gm-Gg: ATEYQzxF8RSFqbgALxiA6tzQQlXGa8FvgA3leouQjbTF1MOkz/oR4/VF9VvD/Y1IWuu
	O27XXaQdafgGDYb8hNnj47uGhLvE7q4QXI0E2bOZ8+psd08H1R6dFkPnR+G7EqiYccxfYNIyAnn
	kzUgtLg7shhVIk4nrIWFi8fWLG4BZtdgptx2RUz9pbTSJU9AphpM1pHGhtAZ+4k1sN8SZxHW7/2
	sBvvlAMLj7MFOClgaeiiEUvJIJEutt8L+LGq9t79EDTz0h0gv/A0rVWeBXsE9KB70GWHzn9aZZ/
	Kf+8bHP3vmH5LeLu38xzTDfbFGOp44J8aZZ+aAB+EGHRN9FO1Pv1OwlpcLFO9YP1GT1mu0s+QkF
	KOmD7gDoVGECEqSnaVp5rOsj3CmJ6+/ZcNc+dPAFVzBw5x2LOyLRPvfMCIXvTnsBrzNDm6Q3Hbm
	PQ75iGBIqNJ5N3RY+UVkK1N6P/6MNtDk4Q6U7eW3Hi3louNLn8swUwbZPGCQZXgoFKVxGtSV9m2
	B006Oeb21VkOvOf3w==
X-Received: by 2002:a05:620a:4141:b0:8c7:19f4:b585 with SMTP id af79cd13be357-8cbc8e4b595mr588101485a.43.1772232371141;
        Fri, 27 Feb 2026 14:46:11 -0800 (PST)
Received: from Cumhall.redhat.com ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf673060sm574247085a.14.2026.02.27.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:46:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.10
Date: Fri, 27 Feb 2026 17:45:34 -0500
Message-ID: <20260227224534.219835-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are pleased to announce rt-tests-2.10

To fetch: 

Clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main
Tag: v2.10

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Thank to everyone who contributed.
patches and bug-reports are always welcome.

John Kacur

Cheng-Yang Chou (8):
  rt-utils.c: Check return values of write()
  pmqtest.c: Check return values of write() and ftruncate()
  ptsematest.c: Check return values of write() and ftruncate()
  rt-migrate-test.c: Check return values of write() and ftruncate()
  cyclicdeadline.c: Check return values of write() and ftruncate()
  deadline_test.c: Check return values of write() and ftruncate()
  sigwaittest.c: Check return values of write() and ftruncate()
  svsematest.c: Check return values of write() and ftruncate()

Costa Shulyupin (2):
  rt-tests: hwlatdetect: Add field count to samples output
  hwlatdetect: Add MTBF calculation

Derek Barbosa (1):
  ssdd: mitigate tracee starvation

Gabriele Monaco (1):
  rt-utils.c: Fix write() return value check

John Kacur (5):
  hwlatdetect: Make count field backward compatible
  hwlatdetect: Add bounds checking and improve code readability
  rt-tests: cyclictest: Remove duplicate option in getopt string
  rt-tests: hwlatdetect: Add check that width is not zero
  rt-tests: Makefile: Bump version to v2.10

Luis Claudio R. Goncalves (1):
  hwlatdetect: correctly get CPU number from different sample formats

Sebastian Andrzej Siewior (10):
  README: Drop "debug" from the tracing path
  rt-utils: Remove mount_debugfs()
  rt-utils: Rename get_debugfileprefix() and let it look for tracefs
  queuelat, rt-migrate-test: Use tracefs for tracing
  rt-utils: Remove fileprefix.
  rt-utils: Simplify trace_file_exists()
  rt-utils: Decouple writing trace-marks with trace stopping
  sched_deadline: Use tracemark() from rt-utils instead custom
    implementation
  sched_deadline: Check the resulting size returned from snprintf()
  cyclicdeadline: Don't test for /sys/kernel/debug/sched_features

Tomas Glozar (1):
  rt-tests: cyclictest: Fix -A long name in manpage

 Makefile                              |   2 +-
 README.markdown                       |  13 ++-
 src/backfire/sendme.c                 |   2 +-
 src/cyclictest/cyclictest.8           |   4 +-
 src/cyclictest/cyclictest.c           |   3 +-
 src/hwlatdetect/hwlatdetect.py        |  46 +++++++-
 src/include/rt-utils.h                |   4 +-
 src/lib/rt-utils.c                    | 116 +++++++------------
 src/oslat/oslat.c                     |   1 +
 src/pmqtest/pmqtest.c                 |   8 +-
 src/ptsematest/ptsematest.c           |   8 +-
 src/queuelat/queuelat.c               |   2 +-
 src/rt-migrate-test/rt-migrate-test.c |   9 +-
 src/sched_deadline/cyclicdeadline.c   | 155 ++++++--------------------
 src/sched_deadline/deadline_test.c    |  37 +++++-
 src/sigwaittest/sigwaittest.c         |  15 ++-
 src/ssdd/ssdd.c                       |  65 ++++++++---
 src/svsematest/svsematest.c           |  15 ++-
 18 files changed, 257 insertions(+), 248 deletions(-)

