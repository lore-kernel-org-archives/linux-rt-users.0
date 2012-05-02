From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH 1/4] rt-tests: printf format compile warning
Date: Tue, 1 May 2012 19:35:22 -0700
Message-ID: <4FA09D6A.2050101@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <jkacur@redhat.com>, <dvhart@linux.intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:53540
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756556Ab2EBCfq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 May 2012 22:35:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Fix printf format string to allow for 32 bit and 64 bit word size.

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
@@ -1575,7 +1576,7 @@ int main(int argc, char **argv)
 		print_tids(parameters, num_threads);
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
-			printf("# Break value: %lu\n", break_thread_value);
+			printf("# Break value: %" PRIu64 "\n", break_thread_value);
 		}
 	}
 	

