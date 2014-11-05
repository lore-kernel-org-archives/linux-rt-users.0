From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 1/9] hackbench: Don't re-assign context for each fd
Date: Wed,  5 Nov 2014 10:09:37 +0100
Message-ID: <1415178585-3192-2-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52808 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753268AbaKEJJt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:49 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

A small optimization. Setting it once is enough.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 src/hackbench/hackbench.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 34a27ef..c42257c 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -326,12 +326,12 @@ static unsigned int group(childinfo_t *child,
 			close(fds[0]);
 	}
 
+	snd_ctx->ready_out = ready_out;
+	snd_ctx->wakefd = wakefd;
+	snd_ctx->num_fds = num_fds;
+
 	/* Now we have all the fds, fork the senders */
 	for (i = 0; i < num_fds; i++) {
-		snd_ctx->ready_out = ready_out;
-		snd_ctx->wakefd = wakefd;
-		snd_ctx->num_fds = num_fds;
