From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Subject: possible bug in cyclictest
Date: Mon, 12 Oct 2009 21:49:26 +0200
Message-ID: <200910122149.28487.bernhard@schiffner-limbach.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50855 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbZJPTQQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Oct 2009 15:16:16 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

on recent a recent kernel:
bs7:~# uname -r
2.6.31.3-rt13

cyclictest fails to set a variable because the path is slightly different now:

bs4:/usr/src/rt-tests# git diff
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 97461e5..b01b76e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -497,7 +497,7 @@ static void setup_tracer(void)
                                setkernvar(traceroptions, traceptr[i]);
                }
                setkernvar("tracing_max_latency", "0");
-               setkernvar("latency_hist/wakeup_latency/reset", "1");
+               setkernvar("latency_hist/wakeup/reset", "1");
        } else {
                setkernvar("trace_all_cpus", "1");
                setkernvar("trace_freerunning", "1");

helps me.

TIA!

Bernhard


