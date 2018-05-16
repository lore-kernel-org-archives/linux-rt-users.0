From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] Linux 4.14.40-rt31-rc1
Date: Wed, 16 May 2018 09:36:42 -0400
Message-ID: <20180516133642.521479369@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.14.40-rt31-rc1.

This only includes patches that are in mainline that fix the new
histogram trigger code. This also needs to be applied to 4.16-rt
before I release this into 4.14-rt.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 5/22/2018.

Enjoy,

-- Steve


To build 4.14.40-rt31-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.40.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.40-rt31-rc1.patch.xz

You can also build from 4.14.40-rt30 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.40-rt30-rt31-rc1.patch.xz


Changes from 4.14.40-rt30:

---


Dan Carpenter (1):
      tracing: Uninitialized variable in create_tracing_map_fields()

Steven Rostedt (VMware) (1):
      Linux 4.14.40-rt31-rc1

Tom Zanussi (3):
      tracing: Add field modifier parsing hist error for hist triggers
      tracing: Add field parsing hist error for hist triggers
      tracing: Restore proper field flag printing when displaying triggers

----
 kernel/trace/trace_events_hist.c | 14 +++++++++++++-
 localversion-rt                  |  2 +-
 2 files changed, 14 insertions(+), 2 deletions(-)
