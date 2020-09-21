Return-Path: <SRS0=Fule=C6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_TONAME_EQ_TOLOCAL_HDRS_LCASE,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E5C35257
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Sep 2020 19:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E64216C4
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Sep 2020 19:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjzoxmTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgIUTdF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUTdF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Sep 2020 15:33:05 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D261FC061755;
        Mon, 21 Sep 2020 12:33:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d1so957992qtr.6;
        Mon, 21 Sep 2020 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version;
        bh=5zbgEP4qz3pAr7cmiqVB/297RflQwQ/jCBIChTJLB40=;
        b=FjzoxmTYrzR8Uy+e+7G2SNu64OXtTgLwtyWN8rgSWJEfWo5mfJZtQgdQMIivh75s3+
         3urIxbOq6AA9vDdDftUfNckYhEnY8dWr5Ma/R/FmZBBGSpYgxbft2iZmj3f2OfWRZ+sE
         czQeTmH2YBKHdno65kfAX0OGwDX5Fq5KT6//hsYMNltM/vKFJmNFHnU3TNDdUENetmYw
         0Ru0VgdL2NI6dyH6fEkgxSPrGQpnlrJZW/djHfDhjCHx0bo4sRTDfRlJkuYMrcRADb7n
         iZlcMKAal27q75krfZj8KiHtbpY3LNGwzeCScBfD7dMVnBagKhZsBcktBPmqwg62wIhz
         0JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version;
        bh=5zbgEP4qz3pAr7cmiqVB/297RflQwQ/jCBIChTJLB40=;
        b=LvqqVmEl71M4vWhb6gCGR8dLJfHpl6R8rutgwrrL60RRL4Nr1vi5cbDGH9H/gXg4oz
         J/DyuLODzKrqy1tLLp/lF1YtnZcJU3iEHysOnZI65H65GC7Y2lI2WzlRYvpytYIC1lLl
         SUGrV0JNTPhdiB6hzetBPWoCw/S9kusQvZWVfIbl8NA8O5qM7HSQQCuJ4RV6hPWrDapo
         X9dP8qTXy4vmzCtsQ/KNush9WhM6Nkn/HL/jRsXa7y8EryFUzzS/wB25BiE+PjLfJjIc
         b3GAzvw/1UYJtufzUec/lcIoHJxgD1NMoIBnvGIewlO6ahNf3z4kjBPVX8EcBVLc+qiu
         9zbQ==
X-Gm-Message-State: AOAM533qhmf1UXbuNuzlI6UEXE+L+atCjjeYXhPRq/Pn6j6rfWj4Cws0
        qoqY7C/+LAMXhBGa3Mq/KGqDzbo7wNM=
X-Google-Smtp-Source: ABdhPJwV+2QeIZiAWuQnwH9SY1JWi+UBQZEOKKk9Ty3rcn920toAaXEPT0BzLpz9iFyrOAGPH/4TLQ==
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr1142207qtr.263.1600716783894;
        Mon, 21 Sep 2020 12:33:03 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-180.dsl.bell.ca. [184.147.140.180])
        by smtp.gmail.com with ESMTPSA id 76sm9894818qkl.127.2020.09.21.12.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 12:33:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Mon, 21 Sep 2020 15:32:55 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
cc:     Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] rt-tests-1.9
Message-ID: <alpine.LFD.2.23.451.2009211516250.7550@fionn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello rt-folks! We're pleased to announce a new release of rt-tests - v1.9

- There is a new test called oslat from Peter Xu
- Daniel Wagner started to move some shared functionality into common 
headers
- Clark Williams provided a fix to pi_stress, to put a limit on the number 
of inversion groups.
- And there are various micellaneous fixes from Yunfeng Ye, and from 
myself too.

To download rt-tests:
using git, clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

The latest tag is v1.9

Tarballs are also available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Your fixes, development or just bug reports are always welcome!

Enjoy!

John Kacur

Clark Williams (1):
  pi_stress: limit the number of inversion groups to the number of
    online cores

Daniel Wagner (4):
  rt-utils: Move timestamp calc helper to common header
  rt-utils: Move time defininitions to common header
  rt-utils: Move ARRAY_SIZE to common header
  signaltest: Only print from the first thread stats when quiet

John Kacur (11):
  cyclictest: Fix setaffinity error on large NUMA machines
  rt-tests: queuelat: Fix storing unsigned long long in int
  rt-tests: improvements to the python style in get_cyclictest_snapshot
  rt-tests: pi_stress.8: Remove unused -t n from the manpage
  rt-tests: ptsematest.8: Update the ptsematest man page
  rt-tests: Add a man page for get_cyclictest_snapshot
  rt-tests: Tweak the cyclictest man page
  rt-tests: Add some files like get_cyclictest_snapshot to .gitignore
  rt-tests: get_cyclictest_snapshot: Warn if no cyclictest instance
    found
  rt-tests: Install new man page get_cyclictest_snapshot.8
  rt-tests: Makefile - update version to v1.9

Peter Xu (3):
  rt-tests: cyclictest: Move ftrace helpers into rt-utils.[ch]
  rt-tests: oslat: Init commit
  rt-tests: oslat: Proper reformat of code

Yunfeng Ye (3):
  rt-tests: cyclictest: Fix -a option fail when max_cpus is more
  rt-tests: hachbench: Update the usage and man page for -F|--fifo
    option
  rt-tests: cyclictest: remove the debug log "pid = xxx" in
    rstat_shm_open()

 .gitignore                                |   7 +
 Makefile                                  |  13 +-
 src/backfire/sendme.c                     |   3 -
 src/cyclictest/cyclictest.8               |   2 +-
 src/cyclictest/cyclictest.c               | 159 +---
 src/cyclictest/get_cyclictest_snapshot.8  |  44 ++
 src/cyclictest/get_cyclictest_snapshot.py |  59 +-
 src/hackbench/hackbench.8                 |   6 +-
 src/hackbench/hackbench.c                 |   2 +-
 src/include/rt-utils.h                    |  51 ++
 src/lib/rt-utils.c                        |  82 ++
 src/oslat/oslat.8                         |  66 ++
 src/oslat/oslat.c                         | 871 ++++++++++++++++++++++
 src/pi_tests/pi_stress.8                  |   6 -
 src/pi_tests/pi_stress.c                  |  23 +-
 src/pmqtest/pmqtest.c                     |   4 -
 src/ptsematest/ptsematest.8               |   6 +-
 src/ptsematest/ptsematest.c               |   2 -
 src/queuelat/queuelat.c                   |  13 +-
 src/signaltest/signaltest.c               |  22 +-
 src/sigwaittest/sigwaittest.c             |   2 -
 src/svsematest/svsematest.c               |   2 -
 22 files changed, 1216 insertions(+), 229 deletions(-)
 create mode 100644 src/cyclictest/get_cyclictest_snapshot.8
 create mode 100644 src/oslat/oslat.8
 create mode 100644 src/oslat/oslat.c

