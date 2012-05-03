From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH v2] rt-tests: printf format compile warning
Date: Thu, 3 May 2012 12:48:48 -0700
Message-ID: <4FA2E120.1020909@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <jkacur@redhat.com>, <dvhart@linux.intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:59386
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751933Ab2ECTuj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 15:50:39 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


V2: use type casting instead of ugly constant in format string


Fix printf format string to fix compile warning for ARM 32 bit target.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1575,7 +1575,7 @@ int main(int argc, char **argv)
 		print_tids(parameters, num_threads);
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
-			printf("# Break value: %lu\n", break_thread_value);
+			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
 		}
 	}
 	

