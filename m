Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12B15ECF2;
	Tue,  7 May 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092960; cv=none; b=NugQDbzSQlZ1UOsAQ2SOUL+j0VutUHlf5LSkTEmHzdZyo2EFQMTiEBZdLaph2fAFNglc+untfRtY52kVOrYfD19sHoBbuBjp6V0ZKjDbCd3FC/v581MuLSexu4nCq+hTEMhigEuPcZeo5FrORdo9fU41xSeKIBEkm56I05llQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092960; c=relaxed/simple;
	bh=2hDHe+BxfhbTIY+eRrN47IQp9mJ0BXA8h0pGpREmulU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxnSqnDDyYBY+C7ye8MxdtXmmnGl9RhJwjCOJI1mXHl2A12zpPf6gGyWzhOGizJr2z+dnkr5iOcsB4zD9USA2YDtUu4GrdBV0NniymEHKLCl3YxW1GEC4MR6sQjqj/HBAkjHdTe/TPm7Q1KjS0z9ADUu3wNuG+zyqVvdy82/tfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0xnmC1d; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0xnmC1d"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c97a485733so587411b6e.2;
        Tue, 07 May 2024 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715092957; x=1715697757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4sf/d1izAzYn8pGMlcSPp+yg8MEOH4IhpznhPjUIMeI=;
        b=H0xnmC1dya106GzD5iPH0tua8h4eAAHP3ZITcU5/0TeE5abuj3byTNfl7Vz5PhTHjd
         /HX5cS2oTbYXIEw62esUN6TU1WfAUp6yT6kzdoRO2l1F45Rq+mLEeqoeoynkVHRgLf5s
         I1zDfYobybcCLfkcAXNjoj6Hyf1iqtEJPD3pCWXMAkL07mmjPzJNe1d7jTO1V6GoYrJi
         9L9WMr+Ju0l4C9nX4Oocvii8UVaWstBLdLKqIPOpsA9MIlhAghZcJjgK/zgQocEqqQP2
         HVydVCa2jp7yroVInO3VRxRkP47Q2QiZB0elIch3l/9WhlVQZHwHtL3uFN4dWj4wXrMX
         oY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715092957; x=1715697757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sf/d1izAzYn8pGMlcSPp+yg8MEOH4IhpznhPjUIMeI=;
        b=FthdtrItx8qckTcf74ztUB1YD/4epReXxKzIDff6S//NDV6hlTA0axIJssFeHieIWG
         W+FKQ7V3WDW4+O912NA1f7/OXhZ0wBfjX1ax9kg8DfgFW5mt3ryIyX8npNjP9NXLOHBL
         WuyfQTg3fgSIbMoIVXPnTr7YbGyD9w8LgONHHMQH/WSlARhKdS2O3ZL2vV7P/HU4uFE6
         sViiEU3C5XGLGcfQTP77WdvMvWd9QqG+RrDr99uH0+E+TGwHyc/5H2Jz1Vm+S1GYRNgk
         jLn8C11I4yl2xWTjvouwZ1gqd8bq/eOC3Gos8R9ZwrpfuHPcOoO8oaLPycV1h6PbUSQO
         mmXQ==
X-Gm-Message-State: AOJu0YzLElNYWbhapDKzWpMkBvriALlNcbtVzE5Y3j85zCBRnDdWr28v
	hEcj3jhPKzVokVmVqzpGLqh8l30lPL7HAzZDfofPHZwdE+u6PkYWTJpxAD1B
X-Google-Smtp-Source: AGHT+IHigzRue/7XVS9M6mYwNQD8aM3IkuuuN4CaPpPfqTKlH1xnPiTL2C7FDEPg4oLSnOd5LigDFw==
X-Received: by 2002:a05:6808:1687:b0:3c7:2607:c541 with SMTP id bb7-20020a056808168700b003c72607c541mr18182153oib.13.1715092957394;
        Tue, 07 May 2024 07:42:37 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-16-74-12-5-183.dsl.bell.ca. [74.12.5.183])
        by smtp.gmail.com with ESMTPSA id t10-20020a0cef0a000000b006a0f7d872ccsm4719722qvr.59.2024.05.07.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:42:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: ANNOUNCE rt-tests version 2.7
Date: Tue,  7 May 2024 10:42:29 -0400
Message-ID: <20240507144229.42909-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am pleased to announce rt-tests-2.7

The most significant changes here are from Crystal who changed the
cyclictest histogram code into a library and added it to cyclicdeadline.
This makes it possible for tools like rteval to parse the results.

histogram output could be added to other tools in the rt-tests suite as
well.

In addition Chris White has added a dockerfile for people who want to
experiment with running rt-tests in a container.

In addition there are various tweaks and fixes from a few different
people, thank you to everyone who contributed.

Bug reports and patches are always welcome

To get rt-tests

Clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main
Tag: v2.7

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Note in some distributions such as Fedora and RedHat the program is 
renamed realtime-tests because of a naming conflict.

Chris White (2):
  rt-tests: Add interactive source-to-image Dockerfile
  rt-tests: Add Dockerfile README

Crystal Wood (8):
  rt-tests: Fix warnings
  rt-tests: cyclictest: Remove histogram totals
  rt-tests: cyclictest: Replace histogram code with library
  rt-tests: cyclicdeadline: Add histogram support
  rt-tests: cyclics: Fix json segfault when not using histogram
  rt-tests: cyclicdeadline: Print the histogram regardless of quiet
  rt-tests: cyclicdeadline: Remove dead "verbose" code in print_stat()
  rt-tests: cyclictest: Omit empty histogram buckets

John Kacur (4):
  rt-tests: Add missing SPDX licenses
  rt-tests: Remove remaining unnecessary texts after adding SPDX
    licenses
  rt-tests:ssdd: Ensure there are one or more iterations
  rt-tests: Change to version v2.7

Marcelo Tosatti (2):
  rt-tests: oslat should use MHz, not Mhz
  rt-tests: oslat: convert to nanoseconds correctly

Mathias Krause (1):
  rt-tests: Makefile: Restore support for Exuberant Ctags

Nam Cao (1):
  rt-tests: hackbench: drop incorrect and unnecessary usage of optind

Rodrigo Queiro (1):
  Support --smi on newer processors

 .gitignore                               |   1 +
 Dockerfile                               |  26 +++
 Makefile                                 |  15 +-
 README-Dockerfile                        |  49 ++++++
 src/backfire/backfire.4                  |   1 +
 src/backfire/sendme.8                    |   1 +
 src/backfire/sendme.c                    |  15 +-
 src/cyclictest/cyclictest.8              |   1 +
 src/cyclictest/cyclictest.c              | 196 +++++------------------
 src/cyclictest/get_cyclictest_snapshot.8 |   1 +
 src/hackbench/hackbench.8                |   1 +
 src/hackbench/hackbench.c                |  12 +-
 src/hwlatdetect/hwlatdetect.8            |   1 +
 src/include/histogram.h                  |  42 +++++
 src/lib/histogram.c                      | 181 +++++++++++++++++++++
 src/oslat/oslat.8                        |   1 +
 src/oslat/oslat.c                        |   4 +-
 src/pi_tests/pi_stress.8                 |   1 +
 src/pi_tests/pip_stress.8                |   1 +
 src/pmqtest/pmqtest.8                    |   1 +
 src/ptsematest/ptsematest.8              |   1 +
 src/queuelat/determine_maximum_mpps.8    |   1 +
 src/queuelat/queuelat.8                  |   1 +
 src/queuelat/targeted-ipi/Kbuild         |   1 +
 src/queuelat/targeted-ipi/Makefile       |   1 +
 src/rt-migrate-test/rt-migrate-test.8    |   1 +
 src/sched_deadline/cyclicdeadline.8      |   1 +
 src/sched_deadline/cyclicdeadline.c      | 164 ++++++++++++++-----
 src/sched_deadline/deadline_test.8       |   1 +
 src/sched_deadline/deadline_test.c       |  10 +-
 src/signaltest/signaltest.8              |   1 +
 src/signaltest/signaltest.c              |   4 -
 src/sigwaittest/sigwaittest.8            |   1 +
 src/sigwaittest/sigwaittest.c            |  20 +--
 src/ssdd/ssdd.8                          |   3 +
 src/ssdd/ssdd.c                          |   5 +-
 src/svsematest/svsematest.8              |   1 +
 37 files changed, 512 insertions(+), 256 deletions(-)
 create mode 100644 Dockerfile
 create mode 100644 README-Dockerfile
 create mode 100644 src/include/histogram.h
 create mode 100644 src/lib/histogram.c

-- 
2.44.0

