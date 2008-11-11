Return-Path: linux-kernel-owner@vger.kernel.org
From: Gregory Haskins <ghaskins@novell.com>
Subject: [RFC PATCH 0/3] Series short description
Date: Tue, 11 Nov 2008 09:26:13 -0500
Message-ID: <20081111142323.28477.41235.stgit@dev.haskins.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@elte.hu, rostedt@goodmis.org, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, =linux-rt-users@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo, Steven, Peter,
  This series applies roughly to mainline as an enhancement to the sched_rt
  logic.  Peter and I were discussing some of the unecessary overhead in
  pull_rt_tasks() via IRC, and this is my RFC attempt to address the problem.

  I have built/booted this on a 4-way C2D Xeon box and it passes preempt-test.

  Comments, please.

  -Greg

---

Gregory Haskins (3):
      sched: use highest_prio.next to optimize pull operations
      sched: use highest_prio.curr for pull threshold
      sched: track the next-highest priority on each runqueue


 kernel/sched.c    |    8 ++-
 kernel/sched_rt.c |  158 +++++++++++++++++++++++++++++++----------------------
 2 files changed, 99 insertions(+), 67 deletions(-)

-- 
Signature
