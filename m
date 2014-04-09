From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] rwsem-rt: Make rwsem rt closer to mainline
Date: Tue, 08 Apr 2014 22:47:00 -0400
Message-ID: <20140409024700.702797305@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Looking at mainline's down_read() I noticed that reader locks of rwsems
are not made to nest. In fact, they should not. Although, it may seem
fine if a down_read() nests as multiple readers can have the lock,
rwsems are fair locks. That is, if a writer were to block on a rwsem
while readers have the lock, a new reader will also block. If a reader
were to try to take the lock again while a writer was waiting, it
would block, and cause a deadlock as it has the lock its trying
to grab and wont let it go as the writer is waiting.

I also found that the rt_mutex_init() is identical in the two places
it is defined in rtmutex.h.

Steven Rostedt (Red Hat) (2):
      rwsem-rt: Do not allow readers to nest
      rtmutex: Remove duplicate rt_mutex_init()

----
 include/linux/rtmutex.h  | 12 +++---------
 include/linux/rwsem_rt.h |  1 -
 kernel/rt.c              | 37 ++++++++-----------------------------
 3 files changed, 11 insertions(+), 39 deletions(-)
