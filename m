From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 0/4] Android/Bionic cleanup patches
Date: Wed, 21 Oct 2015 15:48:58 +0200
Message-ID: <1445435342-16969-1-git-send-email-haustad@cisco.com>
Cc: Henrik Austad <henrik@austad.us>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-4.cisco.com ([173.38.203.54]:62094 "EHLO
	aer-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbJUNxQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 09:53:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Henrik Austad <henrik@austad.us>

Some of these are a respin of previous patches. I considered adding
bionic.h to src/arch/bionic/include, but that was a horrible path and
the file must be included unconditionally by android-target anyway.

src/arch/bionic was renamed to src/arch/android for the sake of clarity.

Tested on android/arm64.

Henrik Austad (4):
  Android: clean up the bypass ifdeffery
  android: rename arch from bionic to android
  android: Expand match for android in ostype
  rt-sched.h: do not unconditionally define syscall-numbers

 Makefile                    |  2 +-
 src/arch/android/Makefile   | 25 +++++++++++++++++++++++++
 src/arch/bionic/Makefile    | 25 -------------------------
 src/cyclictest/cyclictest.c | 25 +++----------------------
 src/include/bionic.h        | 32 ++++++++++++++++++++++++++++++++
 src/include/rt-sched.h      |  4 ++++
 6 files changed, 65 insertions(+), 48 deletions(-)
 create mode 100644 src/arch/android/Makefile
 delete mode 100644 src/arch/bionic/Makefile
 create mode 100644 src/include/bionic.h

-- 
1.9.1

