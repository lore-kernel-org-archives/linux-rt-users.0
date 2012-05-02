From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH 3/4] rt-tests: cyclictest avoid unneeded warning
Date: Tue, 1 May 2012 19:45:00 -0700
Message-ID: <4FA09FAC.8030505@am.sony.com>
References: <4FA09D6A.2050101@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "jkacur@redhat.com" <jkacur@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:40311 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758162Ab2EBCpZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 May 2012 22:45:25 -0400
In-Reply-To: <4FA09D6A.2050101@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Avoid annoying warning message when tracing is not requested and the debug
file system is not available. 

The same test already protects against calling event_enable_all().

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |    5 	3 +	2 -	0 !
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1605,8 +1605,9 @@ int main(int argc, char **argv)
 	if (trace_fd >= 0)
 		close(trace_fd);
 
-	/* turn off all events */
-	event_disable_all();
+	if (enable_events)
+		/* turn off all events */
+		event_disable_all();
 
 	/* turn off the function tracer */
 	fileprefix = procfileprefix;

