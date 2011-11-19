From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] Suggested patches for v3.0.9-rt26
Date: Sat, 19 Nov 2011 13:50:25 +0100
Message-ID: <1321707028-12487-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steve Rostedt and rt-folks

I would also suggest the following three patches for v3.0.9-rt26 in addition
to the ones you already posted.

The two patches from Thomas Gleixner are in v3.2-rc2-rt3
and the patch from Paul McKenney is upstream. (non-rt)

You can pull them from my tree.
git://git.kernel.org:/pub/scm/linux/kernel/git/jkacur/linux-rt.git
branch: v3.0-rt-fixes

Thank You
John Kacur

Paul E. McKenney (1):
  rcu: Drive configuration directly from SMP and PREEMPT

Thomas Gleixner (2):
  rcu-more-fallout.patch
  sysctl-include-fix.patch

 include/linux/sysctl.h |    1 +
 init/Kconfig           |    6 +++---
 kernel/rcutiny.c       |    2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.7.2.3
