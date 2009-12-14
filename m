From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/7] *** SUBJECT HERE ***
Date: Mon, 14 Dec 2009 16:58:49 +0100
Message-ID: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:17516 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921AbZLNP7U (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 10:59:20 -0500
Received: by gv-out-0910.google.com with SMTP id r4so33107gve.37
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 07:59:18 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark:
Please pull the following patches from
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch: rt-tests-dev-carsten

These patches do two things
- They start the effort to separate common functionality into a library.
- They add a number of new tests.

I had to modify Carsten's original patches somewhat due to changes that have
occurred since the original send.
In addition I separated them out a little bit, and added my own fixes.


Carsten Emde (4):
  Start a separate library of functions for the rt-test suite. The
    first couple are taken from cyclictest.
  Make use of the library functions in cyclic test.
  Make use of the new library functions in signaltest.
  Add the following new tests - ptsematest - sigwaittest - svsematest -
    sendme

John Kacur (3):
  Use sched_getcpu - sched_getcpu is available since glibc 2.6 - the
    current tests were broken in anycase.
  Add the new tests to .gitignore
  The version of check_privs that got added to the library must have
    come from signaltest - because it doesn't have the fix that
    check_privs in cyclictest has - to return the sched_priority to 0

 .gitignore                    |    5 +
 Makefile                      |   43 ++-
 src/backfire/Makefile         |   14 +
 src/backfire/backfire.4       |   36 ++
 src/backfire/backfire.c       |  150 +++++++++
 src/backfire/sendme.8         |   42 +++
 src/backfire/sendme.c         |  291 +++++++++++++++++
 src/backfire/version.h        |    1 +
 src/cyclictest/cyclictest.c   |   84 +-----
 src/lib/rt-utils.c            |   66 ++++
 src/lib/rt-utils.h            |    6 +
 src/ptsematest/Makefile       |   16 +
 src/ptsematest/ptsematest.8   |   54 ++++
 src/ptsematest/ptsematest.c   |  423 +++++++++++++++++++++++++
 src/signaltest/signaltest.c   |   27 +--
 src/sigwaittest/Makefile      |   17 +
 src/sigwaittest/sigwaittest.8 |   57 ++++
 src/sigwaittest/sigwaittest.c |  618 ++++++++++++++++++++++++++++++++++++
 src/svsematest/Makefile       |   16 +
 src/svsematest/svsematest.8   |   57 ++++
 src/svsematest/svsematest.c   |  704 +++++++++++++++++++++++++++++++++++++++++
 21 files changed, 2621 insertions(+), 106 deletions(-)
 create mode 100644 src/backfire/Makefile
 create mode 100644 src/backfire/backfire.4
 create mode 100644 src/backfire/backfire.c
 create mode 100644 src/backfire/sendme.8
 create mode 100644 src/backfire/sendme.c
 create mode 100644 src/backfire/version.h
 create mode 100644 src/lib/rt-utils.c
 create mode 100644 src/lib/rt-utils.h
 create mode 100644 src/ptsematest/Makefile
 create mode 100644 src/ptsematest/ptsematest.8
 create mode 100644 src/ptsematest/ptsematest.c
 create mode 100644 src/sigwaittest/Makefile
 create mode 100644 src/sigwaittest/sigwaittest.8
 create mode 100644 src/sigwaittest/sigwaittest.c
 create mode 100644 src/svsematest/Makefile
 create mode 100644 src/svsematest/svsematest.8
 create mode 100644 src/svsematest/svsematest.c

