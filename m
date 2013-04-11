From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] hackbench: init child's struct before using it
Date: Thu, 11 Apr 2013 17:20:05 +0200
Message-ID: <1365693605-22704-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Sommerseth <davids@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44665 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936405Ab3DKPUK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Apr 2013 11:20:10 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Commit ad27df7 ("Reimplement better child tracking and improve error
handling") changed the way of reporting pid/error after creating a
child. It will return an union which is a mix pid_t, pthread_t and a
signed long long for errors.
Now on 32bit x86 both pid_t and pthread_t are four byte in size and are
stored in the first 4 bytes. Now if the most significant bit of the long
long variable happens to be set by chance (because nobody really
initializes the variable here) then error variable will be negative. On
little endian machines the assignment of pid or threadid won't reset the
sign bit and you see this:

| Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
| Each sender will pass 100 messages of 100 bytes
| 0 children started.  Expected 40
| sending SIGTERM to all child processes
| signaling 0 worker threads to terminate
| Creating workers (error: Success)

A machine with proper endian handlig (that is big endian) would reset
the sign bit during the assignment of pid and I would not have to make
this patch :)

While here, I make create_worker() since it is not used outside of this
file.

Cc: David Sommerseth <davids@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/hackbench/hackbench.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 8baeb23..c21b4db 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -189,13 +189,14 @@ static void *receiver(struct receiver_context* ctx)
 	return NULL;
 }
 
-childinfo_t create_worker(void *ctx, void *(*func)(void *))
+static childinfo_t create_worker(void *ctx, void *(*func)(void *))
 {
 	pthread_attr_t attr;
 	int err;
 	childinfo_t child;
 	pid_t childpid;
 
+	memset(&child, 0, sizeof(child));
 	switch (process_mode) {
 	case PROCESS_MODE: /* process mode */
 		/* Fork the sender/receiver child. */
-- 
1.7.10.4

