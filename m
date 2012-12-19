From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] Improve message when disabling sleep states
Date: Wed, 19 Dec 2012 16:35:25 +0100
Message-ID: <20121219153700.043524981@osadl.org>
References: <20121219153524.843471516@osadl.org>
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>
To: RT-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:45698 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab2LSPkO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 10:40:14 -0500
Content-Disposition: inline; filename=improve-message-when-disabling-sleep-states.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The message "/dev/cpu_dma_latency set to 0us" may not always correctly
transmit the message that the purpose of doing so is to disable sleep
states. Added this detail to the message.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -227,7 +227,8 @@ static void set_latency_target(void)
 			close(latency_target_fd);
 			return;
 		}
-		printf("# /dev/cpu_dma_latency set to %dus\n", latency_target_value);
+		printf("# /dev/cpu_dma_latency set to %dus (disabling sleep states)\n",
+		    latency_target_value);
 	}
 }


