From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/9] Linux 3.18.129-rt111-rc1
Date: Fri, 21 Dec 2018 09:21:12 -0600
Message-ID: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hello RT Folks!

This is the RT stable review cycle of patch 3.18.129-rt111-rc1.

Please scream at me if I messed something up. Please test the
patches too.

The -rc release will be uploaded to kernel.org and will be
deleted when the final release is out. This is just a review
release (or release candidate).

The pre-releases will not be pushed to the git repository,
only the final release is.

If all goes well, this patch will be converted to the next
main release on 12/24/2018.

To build 3.18.129-rt111-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.129.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.129-rt111-rc1.patch.xz


You can also build from 3.18.129-rt110 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.129-rt110-rt111-rc1.patch.xz

Enjoy!
   
   Tom

Changes from v3.18.129-rt110:
---
Daniel Bristot de Oliveira (1):
  sched/core: Avoid __schedule() being called twice in a row

Kurt Kanzenbach (1):
  tty: serial: pl011: explicitly initialize the flags variable

Lukas Wunner (1):
  pinctrl: bcm2835: Use raw spinlock for RT compatibility

Sebastian Andrzej Siewior (5):
  efi: Allow efi=runtime
  efi: Disable runtime services on RT
  crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
  work-simple: drop a shit statement in SWORK_EVENT_PENDING
  drm/i915: disable tracing on -RT

Tom Zanussi (1):
  Linux 3.18.129-rt111-rc1

 crypto/cryptd.c                   | 18 ++++++++----------
 drivers/firmware/efi/efi.c        |  5 ++++-
 drivers/gpu/drm/i915/i915_trace.h |  4 ++++
 drivers/pinctrl/pinctrl-bcm2835.c | 16 ++++++++--------
 drivers/tty/serial/amba-pl011.c   |  2 +-
 kernel/sched/core.c               |  9 +++++++--
 kernel/sched/work-simple.c        |  2 +-
 localversion-rt                   |  2 +-
 8 files changed, 34 insertions(+), 24 deletions(-)

-- 
2.14.1
