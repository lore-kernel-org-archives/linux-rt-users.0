From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/12] fs, jbd: pull your plug when waiting for space
Date: Tue, 17 Jul 2012 11:31:21 -0400
Message-ID: <20120717153243.850568822@goodmis.org>
References: <20120717153115.606116459@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <mgalbraith@suse.de>,
	Theodore Tso <tytso@mit.edu>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-fs-jbd-pull-your-plug-when-waiting-for-space.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Mike Galbraith <mgalbraith@suse.de>

With an -rt kernel, and a heavy sync IO load, tasks can jam
up on journal locks without unplugging, which can lead to
terminal IO starvation.  Unplug and schedule when waiting for space.

Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Theodore Tso <tytso@mit.edu>
Link: http://lkml.kernel.org/r/1341812414.7370.73.camel@marge.simpson.net
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/jbd/checkpoint.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jbd/checkpoint.c b/fs/jbd/checkpoint.c
index 05f0754..d8efcbc 100644
--- a/fs/jbd/checkpoint.c
+++ b/fs/jbd/checkpoint.c
@@ -129,6 +129,8 @@ void __log_wait_for_space(journal_t *journal)
 		if (journal->j_flags & JFS_ABORT)
 			return;
 		spin_unlock(&journal->j_state_lock);
+		if (current->plug)
+			io_schedule();
 		mutex_lock(&journal->j_checkpoint_mutex);
 
 		/*
-- 
1.7.10.4
