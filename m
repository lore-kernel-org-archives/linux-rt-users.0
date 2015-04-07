From: Thavatchai Makphaibulchoke <tmac@hp.com>
Subject: [PATCH v2 0/2] rtmutex Real-Time Linux: fix BUG at kernel/locking/rtmutex.c:997!
Date: Mon,  6 Apr 2015 19:26:00 -0600
Message-ID: <1428369962-74723-1-git-send-email-tmac@hp.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
Cc: mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, umgwanakikbuti@gmail.com,
	Thavatchai Makphaibulchoke <tmac@hp.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424395866-81589-1-git-send-email-tmac@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch series compose of 2 patches.

First patch, fixing kernel BUG at kernel/locking/rtmutex.c:997!

Second patch, some code optimation in kernel/locking/rtmutex.c

Changed in v2:
        - Use idle_task on the processor as rtmutex's owner instead of the
          reserved interrupt handler task value.
        - Removed code to hadle the reserved interrupt handler's task value.

Thavatchai Makphaibulchoke (2):
  rtmutex Real-Time Linux: Fixing kernel BUG at
    kernel/locking/rtmutex.c:997!
  kernel/locking/rtmutex.c: some code optimization

 kernel/locking/rtmutex.c | 107 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 38 deletions(-)

-- 
1.9.1
