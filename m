From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests RFC 0/6] Patches for 0.84
Date: Thu, 22 Mar 2012 02:14:00 +0100
Message-ID: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>,
	Darren Hart <dvhart@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nicholas McGuire <der.herr@hofr.at>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54961 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab2CVBPf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 21:15:35 -0400
Received: by wibhj6 with SMTP id hj6so120206wib.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 18:15:34 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These are the patches that I've collected so far for the next version
of rt-tests.

I'd like to start cleaning up the tests to use more common interfaces.
In some case, we have 4 tests all reimplementing their own version of
print an error or info message using a va_list. With that in mind, I've
created a static library for such functions as a preliminary step.

Some of the patches are resends, but I've applied the patch from Darren
that touches the Makefile, and so do the patches that introduce a static lib,
so, I thought it best to just send them all out again.

Also, you run into some odd build problems without the gitignore patch.

I'm sure there is something missing in the Makefile for the libs, for example
some work will need to be done for the install step, but everything should
work properly for building and running in place.

I'm working on some patches to address the problem that Nicholas Mc Guire
pointed out about running with non-root, however I wanted to get these out
for your comments before I send out that patch.

Thankss

Darren Hart (1):
  Makefile: Support user supplied CFLAGS and LDFLAGS

John Kacur (4):
  gitignore: differentiate between program names and directories
  pi_stress: Check the status of sched_getaffinity
  Makefile: Introduce a static library
  Move info, warn, and fatal functions to error.[ch]

Steven Rostedt (1):
  rt-tests: Update rt-migrate-test to use ftrace infrastructure

 .gitignore                            |   31 +++++++-----
 Makefile                              |   48 ++++++++++---------
 src/cyclictest/rt_numa.h              |    1 +
 src/include/error.h                   |    3 +
 src/include/rt-utils.h                |    5 --
 src/lib/error.c                       |   31 ++++++++++++
 src/lib/rt-utils.c                    |   32 +------------
 src/pi_tests/pi_stress.c              |    8 +++
 src/pmqtest/pmqtest.c                 |    1 +
 src/ptsematest/ptsematest.c           |    1 +
 src/rt-migrate-test/rt-migrate-test.c |   85 ++++++++++++++++++---------------
 src/svsematest/svsematest.c           |    1 +
 12 files changed, 137 insertions(+), 110 deletions(-)

-- 
1.7.7.6

