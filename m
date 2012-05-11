From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests v0.84
Date: Fri, 11 May 2012 16:47:53 +0200
Message-ID: <1336747673-14602-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	Darren Hart <dvhart@linux.intel.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Markus Kohlhase <mail@markus-kohlhase.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58913 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2EKOsI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 May 2012 10:48:08 -0400
Received: by eaaq12 with SMTP id q12so997428eaa.19
        for <linux-rt-users@vger.kernel.org>; Fri, 11 May 2012 07:48:06 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It's been a while since we've released a new rt-tests.
Clark silently pushed v0.84 to git, so this note is to let you know.
This release is git only - at least for now.

Repo: git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
Branch: master
Tag: v0.84

I also collect patches in my own repo to push to our fearless leader. :)

This is at
 git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git

Where I've started branch rt-tests-0.84-devel

Thanks, enjoy!

Clark Williams (5):
  [cyclictest] added priority spreading option --priospread
  Revert "cyclictest problem/bug as non-root"
  report number of samples written in hwlatdetect
  change cyclictest measurement thread to check returns and exit on
    error
  version bump to 0.84

Darren Hart (1):
  Makefile: Support user supplied CFLAGS and LDFLAGS

Frank Rowand (6):
  rt-tests: cyclictest segfault with '-a'
  rt-tests: cyclictest avoid unneeded warning
  rt-tests: cyclictest warn of interaction between '-a', '--smp', and
    '--numa'
  rt-tests: Makefile get machinetype from compiler instead of uname
  rt-tests: incorrect first latency value for --verbose option
  rt-tests: printf format compile warning

John Kacur (7):
  gitignore: differentiate between program names and directories
  pi_stress: Check the status of sched_getaffinity
  Makefile: Introduce a static library
  Move info, warn, and fatal functions to error.[ch]
  install: Fix failed to create symbolic link hwlatdetect file exists
  install: Fix failed to create symbolic link hwlatdetect file exists
  rt-tests / cyclictest: Make cyclictest fail if it cannot run with
    requested priority.

Markus Kohlhase (1):
  added description from osadl.org

Nicholas Mc Guire (1):
  cyclictest problem/bug as non-root

Steven Rostedt (1):
  rt-tests: Update rt-migrate-test to use ftrace infrastructure

