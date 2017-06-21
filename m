From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 0/2] rt: Increase/decrease the nr of migratory tasks when enabling/disabling migration
Date: Wed, 21 Jun 2017 21:28:59 +0200
Message-ID: <cover.1498068819.git.bristot@redhat.com>
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This should be the v2 of the:
  [RFC] rt: Some fixes for migrate_disable/enable

However, migrate_disable/enable was reworked during the
4.11-rt window, so it turns out that 2 of 3 problems were fixed.
Good! :-)

But there is still one problem, which is the dl/rt_nr_migratory inc/dec.

The problem is reproducible with the following command [in a 4 CPU box]:

  # chrt -f 1 taskset -c 3 cat /dev/full | taskset -c 0-2 grep 'batman'

By applying only the patch 1/2, it is possible to see the problem with
the following command:

  # cat /proc/sched_debug | grep rt_nr_migratory
    .rt_nr_migratory               : 18446744073709542849
    .rt_nr_migratory               : 18446744073709538566
    .rt_nr_migratory               : 18446744073709548257
    .rt_nr_migratory               : 0

The detailed description of the bug, and the fix, is in the log
of the patch 2/2.

Changes from RFC:

 - The problems addressed in the patches:
   x  rt: Update nr_cpus_allowed if the affinity of a task changes while its
      migration is disabled
   x  rt: Checks if task needs migration when re-enabling migration

  were fixed, so these patches are not needed anymore, while patch:

   x  rt: Increase/decrease the nr of migratory tasks when
      enabling/disabling migration

  is still needed, so it was reworked for the new implementation.

 - The patch showing the rt/dl_nr_migratory was added.

Daniel Bristot de Oliveira (2):
  sched/debug: Inform the number of rt/dl task that can migrate
  rt: Increase/decrease the nr of migratory tasks when
    enabling/disabling migration

 kernel/sched/core.c  | 40 ++++++++++++++++++++++++++++++++--------
 kernel/sched/debug.c | 15 +++++++++++++--
 2 files changed, 45 insertions(+), 10 deletions(-)

-- 
2.9.4
