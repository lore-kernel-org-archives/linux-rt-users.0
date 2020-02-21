Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8CBC35669
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B54207FD
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX+9MTfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBUVVe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:21:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33796 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBUVVd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:21:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so3245756qkm.1;
        Fri, 21 Feb 2020 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ElrgyGt3aPABV2nXv5o0YBnfRSrXqTbK+erUkIwFAlc=;
        b=RX+9MTfvMFTXoGCzukIKGNwP2i+7FGJ23hyyBesjzXr5Tz/g9keibb8Z7GBrOQMXoo
         OkcePZpYO0hWV2HKgSQAc11KNB+6aAM74aT9zp24RE6ST3DtrwjXFJNWL8FV4k+/w8v/
         h0Ef0eL+bnCDLG/ZeGkqCdg22fovFAaAGPB7HTlxNk2MNLe9Wb5qlT1iOqTP8c5poxJa
         C3bt+rtEjnHvPd82Oy+G9SmJelfh1YCZCzFxKaiW+/xIccyPBLFBqgHp0bprl7Yk9Yj7
         4XZTSIgcAx70MrcgWvZICt3vckfs3Xi+O/v+hb46Y8jml6Ly8qF2+aT16e2XjhRN9pIb
         jaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ElrgyGt3aPABV2nXv5o0YBnfRSrXqTbK+erUkIwFAlc=;
        b=Xdks59MzqBy7palm20ZLSBcyzWbPVcg7JmagzOSXntRP8Kt4bUUeHYdw2hoizYOXLr
         m7eC/Evyzlsr8UQoZHCBuWeQ7PR6Ph+R/oh5/8iy0XoLhfPIX3i1VbS4joeqnHSz//mM
         d3M+BuG8ljaTZGApD5f+yE39Ad3VUw3bJwsKogjI61IRIlmEoUyD19sMqoQHtoF70LaL
         nyXR0iT1b9KK4Er7ydzxiDj3dzGDDz9A2miSXEY0Ws13j7iorCBV0CyW3LTIFJ5r2Ss2
         14TF45B9SvW6+hUisYqKU2G9ZJMzTbcxAkg7HxrpF5CXdIAkqHssm590waqirZPd/0HE
         lHkg==
X-Gm-Message-State: APjAAAUAgFySl/iOUiMSwNxpLXh7/lVk0NUCFvQnp3SYq8x/hg2ambHh
        fgScYfmoeYuh3/bhqYxI89mf60eO5Yk=
X-Google-Smtp-Source: APXvYqyONOj5SX1/vq3sFT1ak6bHSUAp9rVWLFpOVTNJwIcCfloQ+VTcEC7uGk7pC1mRji5VqD/T2A==
X-Received: by 2002:ae9:e206:: with SMTP id c6mr35012453qkc.454.1582320092516;
        Fri, 21 Feb 2020 13:21:32 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id o21sm2038829qki.56.2020.02.21.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:21:32 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-1.7
Date:   Fri, 21 Feb 2020 16:21:20 -0500
Message-Id: <20200221212120.14841-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Fixes to queuelat script
- Little fixes to options and man pages of various programs in the suite
- Fixes / changes to the new snapshot feature
- New script get_cyclictest_snapshot to use the snapshot feature

The snapshot feature gets a snapshot of a running cyclictest instance.
Imagine you are running one or multiple instances of cyclictest on a
large machine, perhaps with the -q option so that you would only get
output at the very end, this feature allows you to see the status so far
without halting cyclictest.

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: unstable/devel/latest

Tag: v1.7

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

John Kacur (14):
  rt-tests: queuelat: Assume queuelat is in the path
  rt-tests: cyclicdeadline: Add a simple manpage for cyclicdeadline
  rt-tests: pi_stress: Add short options to usage message
  rt-tests: pi_stress: Sync man page with help
  rt-tests: queuelat: get_cpuinfo_mhz.sh highest value
  rt-tests: determine_maximum_mpps.sh: Fix quoting and other shell issue
  rt-tests: ptsematest: Update man page and add -h option
  rt-tests: queuelat: Fixes to man page and display_help
  rt-tests: svsematest: Display help with an error message for -h
  rt-tests: Use a distinct shm file for each cyclictest instance
  rt-tests: cyclictest: truncate shm files to zero when USR2 received
  rt-tests: Add the get_cyclictest_snapshot.py utility
  rt-tests: Add get_cyclictest_snapshot to Makefile
  rt-tests: Makefile - update version

Kurt Kanzenbach (1):
  make: Make man page compression configurable

 Makefile                                  | 77 +++++++++++++++++------
 src/cyclictest/cyclictest.c               | 25 +++++---
 src/cyclictest/get_cyclictest_snapshot.py | 76 ++++++++++++++++++++++
 src/pi_tests/pi_stress.8                  |  9 +--
 src/pi_tests/pi_stress.c                  | 34 +++++-----
 src/ptsematest/ptsematest.8               |  3 +
 src/ptsematest/ptsematest.c               | 10 +--
 src/queuelat/determine_maximum_mpps.sh    | 75 +++++++++++-----------
 src/queuelat/get_cpuinfo_mhz.sh           |  5 +-
 src/queuelat/queuelat.8                   |  4 +-
 src/queuelat/queuelat.c                   | 22 ++++---
 src/sched_deadline/cyclicdeadline.8       | 53 ++++++++++++++++
 src/svsematest/svsematest.c               |  3 +-
 13 files changed, 291 insertions(+), 105 deletions(-)
 create mode 100755 src/cyclictest/get_cyclictest_snapshot.py
 create mode 100644 src/sched_deadline/cyclicdeadline.8

-- 
2.20.1

