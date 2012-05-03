From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH] rt-tests: incorrect first latency value for --verbose option
Date: Wed, 2 May 2012 17:02:40 -0700
Message-ID: <4FA1CB20.5000209@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<williams@redhat.com>, <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:39861
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752525Ab2ECADB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 20:03:01 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


When the --verbose option is selected, the first value for each thread is
incorrectly reported as zero.

This is because when collecting the first value, the index into stat->values is
incremented from zero to one before storing the value.  But when printing the
values, the first value printed is stat->values[0], which has been initialized
to zero.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |    3 	2 +	1 -	0 !
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -756,7 +756,6 @@ void *timerthread(void *param)
 			pthread_mutex_unlock(&break_thread_id_lock);
 		}
 		stat->act = diff;
-		stat->cycles++;
 
 		if (par->bufmsk)
 			stat->values[stat->cycles & par->bufmsk] = diff;
@@ -769,6 +768,8 @@ void *timerthread(void *param)
 				stat->hist_array[diff]++;
 		}
 
+		stat->cycles++;
+
 		next.tv_sec += interval.tv_sec;
 		next.tv_nsec += interval.tv_nsec;
 		if (par->mode == MODE_CYCLIC) {

