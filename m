From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH v2 0/4] Android: clean-up patches
Date: Wed, 21 Oct 2015 21:00:07 +0200
Message-ID: <1445454011-18839-1-git-send-email-haustad@cisco.com>
Cc: John Kacur <jkacur@redhat.com>, Henrik Austad <henrik@austad.us>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-2.cisco.com ([173.38.203.52]:59110 "EHLO
	aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538AbbJUTEZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 15:04:25 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Henrik Austad <henrik@austad.us>

Changes since v1:

- Changed ifdef in bionic.h to PTHREAD_BIONIC instead of the previous 2
- Moved pthread_setaffinity_np() out of cyclictest and into bionic.h
- Marked the end of #ifedf with /* __UCLIBC__ */ to avoid future confusion

Initial changelog:

Some of these are a respin of previous patches. I considered adding
bionic.h to src/arch/bionic/include, but that was a horrible path and
the file must be included unconditionally by android-target anyway.

src/arch/bionic was renamed to src/arch/android for the sake of clarity.

Tested on android/arm64, tilegx and x64


Henrik Austad (4):
  Android: clean up the bypass ifdeffery
  android: rename arch from bionic to android
  android: Expand match for android in ostype
  rt-sched.h: do not unconditionally define syscall-numbers

 Makefile                    |  3 +--
 src/arch/android/Makefile   | 24 ++++++++++++++++++++++++
 src/arch/bionic/Makefile    | 25 -------------------------
 src/cyclictest/cyclictest.c | 35 ++++-------------------------------
 src/include/bionic.h        | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/include/rt-sched.h      |  4 ++++
 6 files changed, 75 insertions(+), 58 deletions(-)
 create mode 100644 src/arch/android/Makefile
 delete mode 100644 src/arch/bionic/Makefile
 create mode 100644 src/include/bionic.h

-- 
1.9.1

