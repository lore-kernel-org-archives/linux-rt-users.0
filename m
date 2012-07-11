From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 6/7] fs, jbd: pull your plug when waiting for space
Date: Wed, 11 Jul 2012 22:05:20 -0000
Message-ID: <20120711215612.161878327@linutronix.de>
References: <20120711214552.036760674@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <cbe@osadl.org>,
	Mike Galbraith <mgalbraith@suse.de>,
	Theodore Tso <tytso@mit.edu>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=fs-jbd-pull-plug-when-waiting.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

With an -rt kernel, and a heavy sync IO load, tasks can jam
up on journal locks without unplugging, which can lead to
terminal IO starvation.  Unplug and schedule when waiting for space.

Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Theodore Tso <tytso@mit.edu>
Link: http://lkml.kernel.org/r/1341812414.7370.73.camel@marge.simpson.net
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/jbd/checkpoint.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-stable-rt/fs/jbd/checkpoint.c
===================================================================
--- linux-stable-rt.orig/fs/jbd/checkpoint.c
+++ linux-stable-rt/fs/jbd/checkpoint.c
@@ -129,6 +129,8 @@ void __log_wait_for_space(journal_t *jou
 		if (journal->j_flags & JFS_ABORT)
 			return;
 		spin_unlock(&journal->j_state_lock);
+		if (current->plug)
+			io_schedule();
 		mutex_lock(&journal->j_checkpoint_mutex);
 
 		/*
