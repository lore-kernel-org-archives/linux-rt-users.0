Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5EAC433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Jan 2021 17:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCA722BF3
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Jan 2021 17:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbhAKRek (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:34:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:50952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbhAKRek (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Jan 2021 12:34:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73A3FAB7A;
        Mon, 11 Jan 2021 17:33:58 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 0/6] Generate machine-readable output
Date:   Mon, 11 Jan 2021 18:33:45 +0100
Message-Id: <20210111173351.4971-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

changes v2:
  - Moved the common JSON parts into rt-util.[ch]
  - Add --output option to signaltest


The current output of cyclictest is optimized for humans to read. This
is all good when working directly with the tools. But for CI
integration it's a bit of pain. Furthermore, not all rt-tests use the
same output format.

By using some easy to parse existing machine-readable format we can use
standard libraries to parse the data. For example in jitterdebug there
is a short Python program[1] to visualize either the histogram[2] or
all samples[3].

The implementation for JSON output for this is very simple. The last
patch adds a version of jitterdebugs's JSON output, which looks like

{
  "file_version": 1,
  "version:": "cyclictest V 1.90",
  "num_threads": 2,
  "resolution_in_ns": 0,
  "cmdline:": "./cyclictest --affinity=1-2 --duration=1s --output=dump.json -h 1000 -p 80",
  "sysinfo": {
    "sysname": "Linux",
    "nodename": "beryllium",
    "release": "5.9.14-1-default",
    "version": "#1 SMP Sat Dec 12 06:57:32 UTC 2020 (c648a46)",
    "machine": "x86_64"
  },
  "thread": {
    "0": {
      "histogram": {
        "0": 16,
        "1": 853,
        "2": 80,
        "3": 50,
        "4": 1
      },
      "cycles": 1000,
      "min": 0,
      "max": 4,
      "avg": 1.17,
      "cpu": 1,
      "node": 0
    },
    "1": {
      "histogram": {
        "0": 14,
        "1": 833,
        "2": 93,
        "3": 56,
        "4": 4
      },
      "cycles": 1000,
      "min": 0,
      "max": 4,
      "avg": 1.20,
      "cpu": 2,
      "node": 0
    }
  }
}

It's just a rough version. I didn't try to make it generic for the
other rt-tests or make it as plugin as John was suggesting. I'd think
we could make this feature as compile option, if you want to keep the
program small. Obviously, we could also make the terminal output a
compile option, to keep it small.

Anyway, what do you think about it?

Thanks,
Daniel

[1] https://github.com/igaw/jitterdebugger/blob/master/jitterplot
[2] https://www.monom.org/data/jitterdebug/jitterplot-hist.png
[3] https://www.monom.org/data/jitterdebug/jitterplot-samples.png

Daniel Wagner (6):
  rt-tests: Rename error.h to rt-error.h
  cyclictest: Move thread data to struct thread_param
  signaltest: Move thread data to struct thread_param
  rt-utils: Add JSON common header output helper
  cyclictest: Add JSON output feature
  signaltest: Add JSON output feature

 src/cyclictest/cyclictest.c         |  87 +++++++++++----
 src/include/pip_stress.h            |   5 +-
 src/include/{error.h => rt-error.h} |   0
 src/include/rt-utils.h              |   4 +
 src/lib/error.c                     |   2 +-
 src/lib/rt-numa.c                   |   2 +-
 src/lib/rt-utils.c                  |  61 ++++++++++-
 src/oslat/oslat.c                   |   2 +-
 src/pi_tests/pi_stress.c            |   3 +-
 src/pmqtest/pmqtest.c               |   6 +-
 src/ptsematest/ptsematest.c         |   6 +-
 src/signaltest/signaltest.c         | 159 ++++++++++++++++++++--------
 src/sigwaittest/sigwaittest.c       |   2 +-
 src/svsematest/svsematest.c         |   3 +-
 14 files changed, 263 insertions(+), 79 deletions(-)
 rename src/include/{error.h => rt-error.h} (100%)

-- 
2.29.2

