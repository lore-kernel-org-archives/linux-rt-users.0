From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 4/4] hackbench: cleanup error handling in create_worker
Date: Thu, 27 Aug 2015 19:19:51 -0500
Message-ID: <5c68fad0c2c190d491c26e05d5e074eb82f2adc8.1440720422.git.joshc@ni.com>
References: <cover.1440720422.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org, "Song.Li" <Song.Li@windriver.com>,
	Jesse Zhang <sen.zhang@windriver.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:33510 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751823AbbH1ATx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Aug 2015 20:19:53 -0400
In-Reply-To: <cover.1440720422.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The childinfo_t union shares the 'long long error' member with a
'pthread_t threadid'.  For a "sufficiently large" threadid, it's
possible that the error condition is incorrectly hit even though a valid
thread was created.

Stop conflating the error condition with legitimate thread/process
identifiers by modifying create_worker to explicitly return an error
code.

Inspired by a patch in OpenEmbedded authored by Song Li and Jesse Zhang.

Cc: Song.Li <Song.Li@windriver.com>
Cc: Jesse Zhang <sen.zhang@windriver.com>
Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/hackbench/hackbench.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index c42257c..ba804f5 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -64,7 +64,6 @@ struct receiver_context {
 typedef union {
 	pthread_t threadid;
 	pid_t	  pid;
-	long long error;
 } childinfo_t;
 
 childinfo_t *child_tab = NULL;
@@ -189,52 +188,44 @@ again:
 	return NULL;
 }
 
-static childinfo_t create_worker(void *ctx, void *(*func)(void *))
+static int create_worker(childinfo_t *child, void *ctx, void *(*func)(void *))
 {
 	pthread_attr_t attr;
 	int err;
-	childinfo_t child;
-	pid_t childpid;
 
-	memset(&child, 0, sizeof(child));
 	switch (process_mode) {
 	case PROCESS_MODE: /* process mode */
 		/* Fork the sender/receiver child. */
-		switch ((childpid = fork())) {
+		switch ((child->pid = fork())) {
 			case -1:
 				sneeze("fork()");
-				child.error = -1;
-				return child;
+				return -1;
 			case 0:
 				(*func) (ctx);
 				exit(0);
 		}
-		child.pid = childpid;
 		break;
 
 	case THREAD_MODE: /* threaded mode */
 		if (pthread_attr_init(&attr) != 0) {
 			sneeze("pthread_attr_init()");
-			child.error = -1;
-			return child;
+			return -1;
 		}
 
 #ifndef __ia64__
 		if (pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN) != 0) {
 			sneeze("pthread_attr_setstacksize()");
-			child.error = -1;
-			return child;
+			return -1;
 		}
 #endif
 
-		if ((err=pthread_create(&child.threadid, &attr, func, ctx)) != 0) {
+		if ((err=pthread_create(&child->threadid, &attr, func, ctx)) != 0) {
 			sneeze("pthread_create failed()");
-			child.error = -1;
-			return child;
+			return -1;
 		}
 		break;
 	}
-	return child;
+	return 0;
 }
 
 void signal_workers(childinfo_t *children, unsigned int num_children)
@@ -291,6 +282,7 @@ static unsigned int group(childinfo_t *child,
 	unsigned int i;
 	struct sender_context* snd_ctx = malloc (sizeof(struct sender_context)
 			+num_fds*sizeof(int));
+	int err;
 
 	if (!snd_ctx) {
 		sneeze("malloc() [sender ctx]");
@@ -317,8 +309,9 @@ static unsigned int group(childinfo_t *child,
 		ctx->ready_out = ready_out;
 		ctx->wakefd = wakefd;
 
-		child[tab_offset+i] = create_worker(ctx, (void *)(void *)receiver);
-		if( child[tab_offset+i].error < 0 ) {
+		err = create_worker(&child[tab_offset+i], ctx,
+				    (void *)(void *)receiver);
+		if(err) {
 			return (i > 0 ? i-1 : 0);
 		}
 		snd_ctx->out_fds[i] = fds[1];
@@ -332,8 +325,9 @@ static unsigned int group(childinfo_t *child,
 
 	/* Now we have all the fds, fork the senders */
 	for (i = 0; i < num_fds; i++) {
-		child[tab_offset+num_fds+i] = create_worker(snd_ctx, (void *)(void *)sender);
-		if( child[tab_offset+num_fds+i].error < 0 ) {
+		err = create_worker(&child[tab_offset+num_fds+i], snd_ctx,
+				    (void *)(void *)sender);
+		if(err) {
 			return (num_fds+i)-1;
 		}
 	}
-- 
2.5.0

