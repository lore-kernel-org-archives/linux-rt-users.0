From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] cyclictest: Make the default scheduling policy SCHED_FIFO
Date: Mon,  8 Mar 2010 02:18:24 +0100
Message-ID: <1268011104-22451-5-git-send-email-jkacur@redhat.com>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:29235 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0CHBSe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 20:18:34 -0500
Received: by ey-out-2122.google.com with SMTP id 25so773332eya.19
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Mar 2010 17:18:33 -0800 (PST)
In-Reply-To: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The default scheduling policy if unspecified should be SCHED_FIFO.

Before the change for example.
 sudo ./cyclictest
 policy: other: loadavg: 0.05 0.04 0.05 1/331 22367

 T: 0 (22367) P: 0 I:1000 C:   1321 Min:     14 Act:   89 Avg:   77 Max:     942

After the change
 sudo ./cyclictest
 defaulting realtime priority to 2
 policy: fifo: loadavg: 0.03 0.04 0.05 2/331 22387

 T: 0 (22387) P: 2 I:1000 C:    713 Min:     17 Act:   41 Avg:   81 Max:     161

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 066ca79..e4febec 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -792,7 +792,7 @@ static int use_nanosleep;
 static int timermode = TIMER_ABSTIME;
 static int use_system;
 static int priority;
-static int policy = 0;
+static int policy = SCHED_FIFO;	/* default policy if not specified */
 static int num_threads = 1;
 static int max_cycles;
 static int clocksel = 0;
@@ -1037,7 +1037,6 @@ static void process_options (int argc, char *argv[])
 	if (num_threads < 1)
 		error = 1;
 
