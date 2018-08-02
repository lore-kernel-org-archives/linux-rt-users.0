From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 10/15] Revert "fs, jbd: pull your plug when waiting for space"
Date: Thu,  2 Aug 2018 17:25:25 -0500
Message-ID: <ef5dcd697ed99939625442de90495f60c63e2f1a.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This reverts commit 3b5cf23e6b87a938522eb074baeb034e66dc9cb3.

Similar to commit d5bc2c7b2cc0 Revert "fs: jbd2: pull your plug when
waiting for space", according to Sebastian Siewior: this "is the same
thing but for ext3/jbd.  The code was removed at some point so I did
not revert in my tree."

>From the original commit message: "This was a duct-tape fix which
shouldn't be needed since commit "locking/rt-mutex: fix deadlock in
device mapper / block-IO".

Cc: stable-rt@vger.kernel.org
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 fs/jbd/checkpoint.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/jbd/checkpoint.c b/fs/jbd/checkpoint.c
index 95debd71e5fa..08c03044abdd 100644
--- a/fs/jbd/checkpoint.c
+++ b/fs/jbd/checkpoint.c
@@ -129,8 +129,6 @@ void __log_wait_for_space(journal_t *journal)
 		if (journal->j_flags & JFS_ABORT)
 			return;
 		spin_unlock(&journal->j_state_lock);
-		if (current->plug)
-			io_schedule();
 		mutex_lock(&journal->j_checkpoint_mutex);
 
 		/*
-- 
2.14.1
