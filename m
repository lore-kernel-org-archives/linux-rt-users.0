From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/4] *** Add a get_cpu() library ***
Date: Mon, 21 Dec 2009 22:45:46 +0100
Message-ID: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41653 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757234AbZLUVqG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 16:46:06 -0500
Received: by bwz27 with SMTP id 27so3775817bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2009 13:46:02 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have added a get_cpu() library which should just do the right thing for you
whether your system uses sched_getcpu() (the most common case), getcpu()
or the vsyscall version of getcpu().

I have tested on Fedora, RHEL5 both 32 and 64-bit versions which cover all of
the cases above. I would really appreciate more testing and reports on other
distributions. Of course comments and patches are also welcome.

While doing this I changed the Makefile quite extensively. I hope you will find
the changes simply and unify the Make process considerably. This could be
further improved too - for example by creating a build directory.

In addition to the changes below, Clark has fixed the odd CRLF issue, and
has a patch queued-up from Carsten that was missed last time.

Clark, you can pull the following changes from:
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch: rt-tests-dev

Thanks

Carsten Emde (1):
  Completely remove VERSION_STRING until we have a better solution.

John Kacur (3):
  rt-tests: Makefile - Changes to unify and simplify the Makefile
  rt-tests: Add a get_cpu() function to the library.
  rt-tests: Clean-up - protect rt-utils.h

 Makefile                              |   53 ++++++++++++++++++++------------
 src/backfire/backfire.c               |    2 +-
 src/backfire/sendme.c                 |    9 +++--
 src/cyclictest/cyclictest.c           |    1 -
 src/lib/rt-get_cpu.c                  |   25 +++++++++++++++
 src/lib/rt-get_cpu.h                  |   46 ++++++++++++++++++++++++++++
 src/lib/rt-utils.h                    |    5 +++
 src/pi_tests/pi_stress.c              |    7 +---
 src/ptsematest/ptsematest.c           |   12 +++----
 src/rt-migrate-test/rt-migrate-test.c |    2 +-
 src/sigwaittest/sigwaittest.c         |    8 +++--
 src/svsematest/svsematest.c           |   31 ++++---------------
 12 files changed, 135 insertions(+), 66 deletions(-)
 create mode 100644 src/lib/rt-get_cpu.c
 create mode 100644 src/lib/rt-get_cpu.h

