From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH RFC] rt-tests: Makefile get machinetype from compiler instead
 of uname
Date: Tue, 1 May 2012 19:34:13 -0700
Message-ID: <4FA09D25.7090808@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <jkacur@redhat.com>, <dvhart@linux.intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:44416
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756556Ab2EBCeg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 May 2012 22:34:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Fix the machinetype check for cross-compiling.

This has been tested on an x86_64  Fedora host for an x86_64 target and
an ARM target.  Additional testing would be greatly appreciated.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 Makefile |    4 	2 +	2 -	0 !
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -14,8 +14,8 @@ bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 srcdir	?= $(prefix)/src
 
-machinetype = $(shell uname -m | \
-    sed -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
+machinetype = $(shell $(CC) -dumpmachine | \
+    sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
 ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
 NUMA 	:= 1
 endif

