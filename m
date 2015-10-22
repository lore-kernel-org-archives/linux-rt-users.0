From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-v0.96
Date: Thu, 22 Oct 2015 13:06:19 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510221252430.5687@riemann>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="461456403-1155104725-1445511980=:5687"
Cc: LKML <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33127 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090AbbJVLGX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 07:06:23 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--461456403-1155104725-1445511980=:5687
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Dear RT Folks

We are pleased to announce the latest version of rt-tests

There is the usual round of clean-ups.
- we are continuing to improve the make system
- Henrik cleaned up the new feature to run cyclictest in Android
specifically he removed all the ugly #ifdefs to an android specific file

There is a new feature to trace information about latency spikes,
to see if we can find any patterns to the spikes

Here is what a sample run with the new feature looks like. (non-rt kernel)

su -c './cyclictest -t4 -p99 --spike=30 --duration=60'
Password:
policy: fifo: loadavg: 0.69 0.78 0.60 1/641 6420

T: 0 ( 6385) P:99 I:1000 C:  59996 Min:      2 Act:    2 Avg:    2 Max:
1476
T: 1 ( 6386) P:99 I:1500 C:  39999 Min:      1 Act:    2 Avg:    2 Max:
952
T: 2 ( 6387) P:99 I:2000 C:  29999 Min:      2 Act:    2 Avg:    3 Max:
504
T: 3 ( 6388) P:99 I:2500 C:  23999 Min:      1 Act:    2 Avg:    2 Max:
1423

T: 2 Spike:     504: TS:    490531620
T: 2 Spike:     270: TS:    526847386
T: 2 Spike:      51: TS:    527211167
T: 2 Spike:      44: TS:    528261160
T: 1 Spike:      31: TS:    528952631
T: 2 Spike:      32: TS:    529253148
T: 2 Spike:      52: TS:    529317169
T: 0 Spike:    1444: TS:    530049519
T: 1 Spike:     419: TS:    530049520
T: 0 Spike:    1476: TS:    530318551
T: 1 Spike:     952: TS:    530318553
T: 3 Spike:    1423: TS:    530318551
T: 0 Spike:     972: TS:    531532046
T: 0 Spike:      34: TS:    531987109
spikes = 14

Summary of Changes
------------------

Clark Williams (3):
  Makefile: add target to create OBJDIR before use
  specfile: add signaltest manpage to files section and remove trailing
    whitespace in changelog
  Makefile: have distclean remove .asc file for tarball

Henrik Austad (4):
  Android: clean up the bypass ifdeffery
  Android: rename arch from bionic to android
  Android: Expand match for android in ostype
  rt-sched.h: do not unconditionally define syscall-numbers

John Kacur (6):
  cyclictest: Clean-ups in timerthread before working on it
  Makefile: OBJDIR should be an order-only-prerequisite
  Makefile: Move TARGETS back to a more logical place in the Makefile
  cyclictest: Add a feature to record spikes
  cyclictest: fix #ifdef broken by NO_PTHREAD_SETAFFINITY
  Makefile: Version bump to v0.96

Uwe Kleine-König (1):
  Fix some trivial typos found by codespell(1)

You can fetch it via git by cloning one of the following repos

git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

tag: v0.96

You can also fetch the tarball here
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-0.96.tar.xz
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-0.96.tar.gz

older versions are in
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests/older

I've pushed a branch for new development, so you can start sending us your 
patches, and bug reports.

branch: devel/v0.97

Enjoy!

John Kacur
--461456403-1155104725-1445511980=:5687--
