Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176CC433E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B4922B3B
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbhAZRUM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:20:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:56052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390825AbhAZJPx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 04:15:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90E13ACF4;
        Tue, 26 Jan 2021 09:15:02 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v3 00/16] rt-numa.h cleanups
Date:   Tue, 26 Jan 2021 10:14:44 +0100
Message-Id: <20210126091500.31735-1-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This series cleans up the rt-numa.h header.

As we have a hard dependency on libnuma we can simplify the code in
cyclictest. This allows remove all the small helpers in rt_numa.h. And
with this we can remove the header and reduce the confusion with
rt-numa.h

While at it, I simplified the --smp vs --affinity vs --threads
logic. There is no need for additional variables to keep state. With
this we also make --affinity to behave as with the rest of
rt-tests. That is a plan -a will be the same as with -S. There is no
need for -S anymore but I think we should leave it in place for
backwards compatibility. I suspect, there must be a lot of muscle
memory out there :)

Since signaltest has the same code as cyclictest, cleanup this tool as
well.

With all those cleanups in cyclictest and signaltest, rt-numa.h
contains only a three functions. The final part of the series is to
remove unnecessary function arguments (max_cpus). This also fixes the
theoretical problem that a sparse cpumask would not be handled
correctly.

v3:
 - added error handling for numa_on_node() return value
 - added 'Rename error.h to rt-error.h' patch
 - rebased, dropped applied patches
 - fixed SoBs and stearing vs sterring spelling error

v2:
  - added more cleanup patches

Daniel Wagner (16):
  cyclictest: Use numa API directly
  cyclictest: Mimik --smp behavior with --affinity
  cyclictest: Simplify --smp vs --affinity vs --threads argument logic
  signaltest: Use affinity_mask for steering thread placement
  signaltest:  Simplify --smp vs --affinity vs --threads argument logic
  rt-numa: Remove unused definitions and numa_initialize()
  rt-numa: Add generic cpu_for_thread() helper
  rt-numa: Use mask size for iterator limit
  rt-numa: Remove max_cpus argument from parse_cpusmask
  signaltest: Remove unused max_cpus argument from process_options
  cyclictest: Remove unused max_cpus argument from process_options
  rt-numa: Use CPU_SETSIZE as upper loop limit
  rt-numa: Remove used max_cpus argument from cpu_for_thread()
  cyclictest: Remove max cpus used verbose information
  cyclictest: Remove unecessary local variable
  rt-tests: Rename error.h to rt-error.h

 src/cyclictest/cyclictest.c         | 111 ++++++++++------------------
 src/cyclictest/rt_numa.h            |  96 ------------------------
 src/include/pip_stress.h            |   5 +-
 src/include/{error.h => rt-error.h} |   0
 src/include/rt-numa.h               |  13 +---
 src/lib/error.c                     |   2 +-
 src/lib/rt-numa.c                   |  42 +++++------
 src/lib/rt-utils.c                  |   3 +-
 src/oslat/oslat.c                   |   5 +-
 src/pi_tests/pi_stress.c            |   3 +-
 src/pmqtest/pmqtest.c               |   6 +-
 src/ptsematest/ptsematest.c         |   6 +-
 src/sched_deadline/cyclicdeadline.c |   6 +-
 src/signaltest/signaltest.c         |  76 +++++--------------
 src/sigwaittest/sigwaittest.c       |   2 +-
 src/svsematest/svsematest.c         |   3 +-
 16 files changed, 98 insertions(+), 281 deletions(-)
 delete mode 100644 src/cyclictest/rt_numa.h
 rename src/include/{error.h => rt-error.h} (100%)

-- 
2.30.0

