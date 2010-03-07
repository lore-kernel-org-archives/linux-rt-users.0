From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 2/2] remove-incorrect-options-from-smp-help-message-in-cyclictest.patch
Date: Sun, 07 Mar 2010 21:39:57 +0100
Message-ID: <20100307204243.501654843@osadl.org>
References: <20100307203955.895980022@osadl.org>
Cc: RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60222 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab0CGV3r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 16:29:47 -0500
Content-Disposition: inline; filename=remove-incorrect-options-from-smp-help-message-in-cyclictest.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The help message of cyclictest's -S option says that it equals -a -t -n -m -d0.
In reality, it only equals -a -t -n.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -777,8 +777,8 @@ static void display_help(int error)
                "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
                "-y POLI  --policy=POLI     policy of realtime thread (1:FIFO, 2:RR)\n"
                "                           format: --policy=fifo(default) or --policy=rr\n"
-	       "-S       --smp             Standard SMP testing (equals -a -t -n -m -d0)\n"
-               "                           same priority on all threads.\n"
+	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
+               "                           same priority of all threads\n"
 	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"
                "                           thread data structures allocated from local node\n",
 	       tracers

