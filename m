From: Thavatchai Makphaibulchoke <tmac@hp.com>
Subject: [PATCH 3.14.25-rt22 0/2] rtmutex Real-Time Linux: fix kernel BUG at kernel/locking/rtmutex.c:997! and some optimization
Date: Thu, 19 Feb 2015 18:31:04 -0700
Message-ID: <1424395866-81589-1-git-send-email-tmac@hp.com>
Cc: mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org,
	Thavatchai Makphaibulchoke <tmac@hp.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch series compose of 2 patches.

First patch, fixing kernel BUG at kernel/locking/rtmutex.c:997!

Second patch, some code optimation in kernel/locking/rtmutex.c

Thavatchai Makphaibulchoke (2):
  rtmutex Real-Time Linux: Fixing kernel BUG at
    kernel/locking/rtmutex.c:997!
  kernel/locking/rtmutex.c: some code optimization

 include/linux/spinlock_rt.h     |   4 +
 kernel/locking/rtmutex-debug.c  |  15 ++-
 kernel/locking/rtmutex.c        | 248 ++++++++++++++++++++++++++++------------
 kernel/locking/rtmutex_common.h |  21 ++++
 kernel/timer.c                  |   4 +-
 5 files changed, 214 insertions(+), 78 deletions(-)

-- 
1.9.1
