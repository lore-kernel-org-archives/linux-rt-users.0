From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] fs: jbd2: pull your plug when waiting for space
Date: Fri, 21 Feb 2014 13:32:53 +0100
Message-ID: <20140221123253.GA12822@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx@linutronix.de
To: Mike Galbraith <bitbucket@online.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Two cps in parallel managed to stall the the ext4 fs. It seems that
journal code is either waiting for locks or sleeping waiting for
something to happen. This seems similar to what Mike observed on ext3,
here is his description:

|With an -rt kernel, and a heavy sync IO load, tasks can jam
|up on journal locks without unplugging, which can lead to
|terminal IO starvation.  Unplug and schedule when waiting
|for space.

This is on v3.2-RT. This cp testcase triggers about once in four runs.
It did not trigger once in 20 runs on v3.12-RT.
This brings me to the question: could it been fixed in the meantime and
we not need the jbd patches in latest -RT is there a better testcase?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/jbd2/checkpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 16a698b..c6443c3 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -129,6 +129,8 @@ void __jbd2_log_wait_for_space(journal_t *journal)
 		if (journal->j_flags & JBD2_ABORT)
 			return;
 		write_unlock(&journal->j_state_lock);
+		if (current->plug)
+			io_schedule();
 		mutex_lock(&journal->j_checkpoint_mutex);
 
 		/*
-- 
1.9.0.rc3
