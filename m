From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 0/3] Simple wait queue support
Date: Wed,  5 Aug 2015 15:30:45 +0200
Message-ID: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: paul.gortmaker@windriver.com, peterz@infradead.org,
	bigeasy@linutronix.de, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

It's a while since the last attempt by Paul to get simple wait ready
for mainline [1]. At the last realtime workshop it was discussed how
the swait implementation could be made preempt aware. Peter posted an
untested version of it here [2].

In order to test it, I used Paul's two patches which makes completion
and rcu using swait instead of wait. Some small renamings were
necessary to get it working, e.g. s/swait_head/swait_queue_head/.

My test system didn't crash or showed any obvious defects, so I
decided to apply some benchmarks utilizing mmtests. I have picked some
random tests (kernbench aim9 vmr-stream ebizz), which didn't require a
lot of tinker around to get them running. The results are here:

  baseline: v4.2-rc5-22-ged8bbba

  http://monom.org/mmtests-swait-peterz-v1/

I don't think the numbers are trustworthy yet. Mabye one could read
it as it doesn't explode and the numbers aren't to far away from
baseline. I need to figure out which tests are fitting for these
patches and what are the 'right' parameters for them.

Sebastian had some comments on Peter's patch. I haven't addressed them
yet [3].

cheers,
daniel

[1] https://lwn.net/Articles/616857/
[2] http://www.spinics.net/lists/linux-rt-users/msg12703.html
[3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg832142.html

Paul Gortmaker (2):
  sched/completion: convert completions to use simple wait queues
  rcu: use simple wait queues where possible in rcutree

Peter Zijlstra (1):
  KVM: use simple waitqueue for vcpu->wq

 include/linux/completion.h |   8 +--
 include/linux/swait.h      | 172 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  13 ++--
 kernel/rcu/tree.h          |   6 +-
 kernel/rcu/tree_plugin.h   |  18 ++---
 kernel/sched/Makefile      |   2 +-
 kernel/sched/completion.c  |  32 ++++-----
 kernel/sched/swait.c       | 122 ++++++++++++++++++++++++++++++++
 8 files changed, 334 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/swait.h
 create mode 100644 kernel/sched/swait.c

-- 
2.4.3
