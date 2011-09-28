From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH] rt-tests, cyclictest - fix printf format for 32 bit systems
Date: Wed, 28 Sep 2011 15:18:16 -0700
Message-ID: <4E839D28.5020603@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: Clark Williams <williams@redhat.com>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:22773
	"EHLO DB3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485Ab1I1WSd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Sep 2011 18:18:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


The printf() format for a uint64_t is %l on a 64 bit system and %ll on
a 32 bit system.  Use the ugly but portable format descriptor.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |    3 	2 +	1 -	0 !
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -24,6 +24,7 @@
 #include <time.h>
 #include <errno.h>
 #include <limits.h>
+#include <inttypes.h>
 #include <linux/unistd.h>
 
 #include <sys/prctl.h>
@@ -1561,7 +1562,7 @@ int main(int argc, char **argv)
 		print_tids(parameters, num_threads);
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
-			printf("# Break value: %lu\n", break_thread_value);
+			printf("# Break value: %" PRIu64 "\n", break_thread_value);
 		}
 	}
 	

