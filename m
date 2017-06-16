From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [RFC 0/3] rt: Some fixes for migrate_disable/enable
Date: Fri, 16 Jun 2017 12:39:45 +0200
Message-ID: <cover.1497607974.git.bristot@redhat.com>
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This RFC suggest three changes from the migrate disable/enable
mechanism. Two of them are fixes, and the last one is a
suggestion/improvement.

As migrate_disable/enable is RT specific, this patch set is
RT specific.

Daniel Bristot de Oliveira (3):
  rt: Increase/decrease the nr of migratable tasks when
    enabling/disabling migration
  rt: Update nr_cpus_allowed if the affinity of a task changes while its
    migration is disabled
  rt: Checks if task needs migration when re-enabling migration

 kernel/sched/core.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

-- 
2.9.4
