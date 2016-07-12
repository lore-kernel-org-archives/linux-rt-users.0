From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] Linux 4.4.12-rt20-rc1
Date: Tue, 12 Jul 2016 10:21:53 -0400
Message-ID: <20160712142153.609204728@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.4.12-rt20-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/14/2016.

Enjoy,

-- Steve


To build 4.4.12-rt20-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-4.4.12.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.12-rt20-rc1.patch.xz

You can also build from 4.4.12-rt19 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.12-rt19-rt20-rc1.patch.xz


Changes from 4.4.12-rt19:

---


Luiz Capitulino (1):
      mm: perform lru_add_drain_all() remotely

Mike Galbraith (1):
      work-simple: Rename work-simple.[ch] to swork.[ch] for consistency

Sebastian Andrzej Siewior (2):
      locallock: add local_lock_on()
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (1):
      Linux 4.4.12-rt20-rc1

----
 arch/x86/kernel/cpu/mcheck/mce.c         |  2 +-
 drivers/thermal/x86_pkg_temp_thermal.c   |  2 +-
 fs/aio.c                                 |  2 +-
 include/linux/cgroup-defs.h              |  2 +-
 include/linux/locallock.h                |  6 ++++++
 include/linux/{work-simple.h => swork.h} |  0
 kernel/sched/Makefile                    |  2 +-
 kernel/sched/{work-simple.c => swork.c}  |  2 +-
 kernel/trace/trace_events.c              |  8 +++++++
 localversion-rt                          |  2 +-
 mm/swap.c                                | 37 ++++++++++++++++++++++++++------
 11 files changed, 51 insertions(+), 14 deletions(-)
 rename include/linux/{work-simple.h => swork.h} (100%)
 rename kernel/sched/{work-simple.c => swork.c} (99%)
