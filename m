Return-Path: <SRS0=0v2v=3E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E4C33CB1
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jan 2020 15:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371462465A
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jan 2020 15:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WymoTkNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAOPZY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:25:24 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]:35232 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgAOPZX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jan 2020 10:25:23 -0500
Received: by mail-qv1-f45.google.com with SMTP id u10so7532241qvi.2;
        Wed, 15 Jan 2020 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdUAz6sa4LFq6afQBt16w036Li3pPsTl72+VHxglyUI=;
        b=WymoTkNOvsAbv2uEQGt6IfczcVaeXfk+I/Eou9+3zRmlSNjhJ/9Bl5+kLXBuKMSRhI
         9WPEQM3yhGEUzBGlCnxpjQA2nccgUqhsXRAGsc+g/4JI9fC+gv2O72AjWIKyXJSi23Db
         Bt6IM/YxabcHl/e73+0FAqLaeFmKErp78b9WiQYzQs7zcewjk4KoIJ6Kn5CZEf2fpOcR
         mzSQKdeGRU086El7uINhsNKfhGwbInHrdpO6sNfDWmnHR8BghB8cnnaGzKMHC/p+Q6PC
         XuMEIcpMrt+71iI7m1rG8ivm/uWk0VIpz9yIal8mZ1ZiD2xk9HPryeLsHhII/jWIrBH3
         W1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NdUAz6sa4LFq6afQBt16w036Li3pPsTl72+VHxglyUI=;
        b=cuZFZ6MoixroiwU/tA4IZ0uHer2gsPEXRjkDEo52QonwEZPmnqdWZpRghiZ7WssolY
         hWQnvE84ItPVxbogXasvV9eQQTOEUIwgsJHOyCYJWEJK7iFD/zBVhrzmu/Q1Z607j/nC
         nUveRPWdtDcyJjrxWWHa6WgJAeMPnSV+X/4Uw3KdUZJiX5zLwWFv+QTxmFOngl5h0S2i
         Yv8sAs/dhqGt9ynDkmwkceVZlw4PcnV4Pe5nblC57PKr/XbtaPNrJzefSOBPPHuOCjgo
         /YcmgkAcFngXS68+8Xq0/M2opBHVm8VswqYLzp35HVJZmYTTq7Jk93i0q77up3rUNnwW
         ZYiA==
X-Gm-Message-State: APjAAAUZf9j6Y3OLXhvCSEHH0j69lKGwBwvR6Et4qku3m/3BHUMWQ4ow
        8SUK1aVXnEa8Kg2ITRocNdp6lSPujd4=
X-Google-Smtp-Source: APXvYqyUN1ByxiF0SvZ5OkFkzDNyvHJgHkhpALNOo9q382TVQoFtNWKtSOgnbc8GEsKcHtFj6qaQ0g==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr22846777qvs.177.1579101922320;
        Wed, 15 Jan 2020 07:25:22 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id x126sm8601708qkc.42.2020.01.15.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:25:21 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-1.6
Date:   Wed, 15 Jan 2020 16:25:12 +0100
Message-Id: <20200115152512.7057-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is a new feature to get a snapshot of a running instance of
cyclictest without stopping it, by sending SIGUSR2 to the PID and
reading a shared memory segment. This is especially useful if you are
running cyclictest over a long period of time.

We are now using SPDX tags.

Then there are various fixes from different people. Thanks to everyone
for contributing, keep-up the good work.

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: unstable/devel/latest

Tag: v1.6

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Afzal Mohammed (2):
  rt-tests: Allow cross compilation
  rt-tests: Let git ignore cscope generated files

Daniel Wagner (4):
  pmqtest: Increase buffer to avoid overflow
  sigwaittest: Increase buffer to avoid overflow
  svsematest: Increase buffer to avoid overflow
  deadline_test: Increase buffer to avoid overflow

John Kacur (15):
  rt-tests: Set affinity before applying numa
  rt-tests: cyclictest.8: Remove invalid tracing options from the
    manpage
  rt-tests: cyclictest: Make tracemark work correctly again
  rt-tests: cyclictest: Fix  warning: ‘cpu’ may be used uninitialized
  rt-tests: cyclictest: Don't allow OPT_SYSTEM with OPT_POSIX_TIMERS
  rt-tests: cyclictest: Assume libnuma version 2 by default
  rt-tests: cyclictest: Just use LIBNUMA_API_VERSION 2
  rt-tests: queuelat: Fix some warnings in determine_maximum_mpps.sh
  rt-tests: ssdd: Add short and long functions as well as help
  rt-tests: cyclictest: Get a snapshot of cyclictest without
    interuppting it
  cyclictest: Sync manpage with the help option
  svsematest: Add -S, --smp option to manpage
  rt-tests: Add SPDX tags V3
  rt-tests: Add SPDX tag to hackbench.c
  rt-tests: Makefile - update version

Sultan Alsawaf (1):
  rt-tests: backfire: Don't include asm/uaccess.h directly

Uwe Kleine-König (3):
  cyclictest: fix typos
  Makefile: don't create empty directories in install target
  queuelat: use ARM implementation of gettick also for all !x86 archs

 .gitignore                               |   1 +
 Makefile                                 |  10 +-
 src/backfire/backfire.c                  |  19 +-
 src/cyclictest/cyclictest.8              |  42 +---
 src/cyclictest/cyclictest.c              | 242 +++++++++++++++++++++--
 src/cyclictest/rt_numa.h                 |  99 +---------
 src/hackbench/hackbench.c                |   1 +
 src/hwlatdetect/hwlatdetect.py           |   8 +-
 src/include/bionic.h                     |   1 +
 src/include/error.h                      |   1 +
 src/include/pip_stress.h                 |   1 +
 src/include/rt-get_cpu.h                 |   1 +
 src/include/rt-sched.h                   |  24 +--
 src/include/rt-utils.h                   |   1 +
 src/lib/error.c                          |   1 +
 src/lib/rt-get_cpu.c                     |   1 +
 src/lib/rt-sched.c                       |  25 +--
 src/lib/rt-utils.c                       |   1 +
 src/pi_tests/classic_pi.c                |  22 +--
 src/pi_tests/pi_stress.c                 |  22 +--
 src/pi_tests/pip_stress.c                |  14 +-
 src/pi_tests/sigtest.c                   |  22 +--
 src/pi_tests/tst-mutexpi10.c             |  27 +--
 src/pmqtest/pmqtest.c                    |  20 +-
 src/ptsematest/ptsematest.c              |  17 +-
 src/queuelat/determine_maximum_mpps.sh   |  18 +-
 src/queuelat/get_cpuinfo_mhz.sh          |   3 +
 src/queuelat/queuelat.c                  |  10 +-
 src/queuelat/targeted-ipi/targeted-ipi.c |   7 +
 src/rt-migrate-test/rt-migrate-test.c    |  19 +-
 src/sched_deadline/cyclicdeadline.c      |   8 +
 src/sched_deadline/deadline_test.c       |  26 +--
 src/signaltest/signaltest.c              |   2 +
 src/sigwaittest/sigwaittest.c            |   4 +-
 src/ssdd/ssdd.8                          |  10 +-
 src/ssdd/ssdd.c                          |  57 ++++--
 src/svsematest/svsematest.8              |   3 +
 src/svsematest/svsematest.c              |  18 +-
 38 files changed, 392 insertions(+), 416 deletions(-)

-- 
2.20.1

