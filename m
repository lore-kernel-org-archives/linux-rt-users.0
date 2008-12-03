From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH v2 0/4] sched: track next-highest priority
Date: Wed, 03 Dec 2008 17:09:29 -0500
Message-ID: <20081203220628.11729.42174.stgit@dev.haskins.net>
References: <20081203204025.GA31376@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, rostedt@goodmis.org, ghaskins@novell.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755378AbYLCWGD@vger.kernel.org>
In-Reply-To: <20081203204025.GA31376@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Ingo,
  This version of the patches is logically equivelent to v1 with the following
  exceptions.

1) Rebased to tip/master df9fc0207
2) split v1-1/3 into v2-1/4 (cleanup) and v2-2/4 (changes)


I talked to Peter today about reviewing/acking these.  I told him to wait for
v2, so here it is.  Hopefully he will have a chance to look at these soon.


Thanks guys,
-Greg

---

Gregory Haskins (4):
      sched: use highest_prio.next to optimize pull operations
      sched: use highest_prio.curr for pull threshold
      sched: track the next-highest priority on each runqueue
      sched: cleanup inc/dec_rt_tasks


 kernel/sched.c    |    8 ++-
 kernel/sched_rt.c |  156 +++++++++++++++++++++++++++++++----------------------
 2 files changed, 98 insertions(+), 66 deletions(-)

-- 
Signature
