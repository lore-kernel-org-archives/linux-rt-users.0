From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH] rt-tests - allow build without NUMA
Date: Fri, 23 Sep 2011 12:26:03 -0700
Message-ID: <4E7CDD4B.2070202@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: Clark Williams <williams@redhat.com>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:34998
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751286Ab1IWT1F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Sep 2011 15:27:05 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



"NUMA=0 make" does not remove numa from the build.  Fix.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 Makefile |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -26,7 +26,7 @@ else
 	CFLAGS	+= -O0 -g
 endif
 
-ifdef NUMA
+ifeq ($(NUMA),"1")
 	CFLAGS += -DNUMA
 	NUMA_LIBS = -lnuma
 endif

