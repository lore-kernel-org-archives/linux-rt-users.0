From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/5] *** Add new priority inversion test, plus lib changes ***
Date: Wed, 23 Dec 2009 17:02:55 +0100
Message-ID: <1261584180-13922-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:53385 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbZLWQDI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 11:03:08 -0500
Received: by fxm5 with SMTP id 5so7112407fxm.28
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2009 08:03:06 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These patches add a new priority inversion test (pip) similar to pi_stress
The difference is, that pi_stress uses pthreads and pip uses processes.

In addition there are changes to put the headers files in src/include
and to add some common error handling routines to our library.

Clark: You can pull these patches from
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch: rt-tests-dev-new

Thank You

John Kacur (5):
  rt-tests: Add error routines to the library
  rt-tests: Add a new test pip - priority inheritance with processes
  rt-tests: Move header files from src/lib to src/include
  rt-tests: pip - Use check_privs() from the rt-utils library.
  rt-tests: Add a "make tags" option.

 .gitignore               |    2 +-
 Makefile                 |   12 ++-
 src/include/error.h      |   15 ++
 src/include/pip.h        |   41 ++++++
 src/include/rt-get_cpu.h |   46 ++++++
 src/include/rt-utils.h   |   11 ++
 src/lib/error.c          |   49 +++++++
 src/lib/rt-get_cpu.h     |   46 ------
 src/lib/rt-utils.h       |   11 --
 src/pi_tests/pip.c       |  347 ++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 520 insertions(+), 60 deletions(-)
 create mode 100644 src/include/error.h
 create mode 100644 src/include/pip.h
 create mode 100644 src/include/rt-get_cpu.h
 create mode 100644 src/include/rt-utils.h
 create mode 100644 src/lib/error.c
 delete mode 100644 src/lib/rt-get_cpu.h
 delete mode 100644 src/lib/rt-utils.h
 create mode 100644 src/pi_tests/pip.c

