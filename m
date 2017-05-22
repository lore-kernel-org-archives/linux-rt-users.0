From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 19/34] pip_stress: getopt.h and long_options[] are unused
Date: Mon, 22 May 2017 11:25:25 +0300
Message-ID: <20170522082540.15467-20-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50134.outbound.protection.outlook.com ([40.107.5.134]:2496
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752743AbdEVI02 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:28 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/pi_tests/pip_stress.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 1245705..15adf54 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -57,7 +57,6 @@
 #include "pip_stress.h"
 
 #include <unistd.h>
-#include <getopt.h>
 
 /* default time for low priority thread usleep */
 useconds_t usleep_val = 500;
@@ -79,11 +78,6 @@ struct State *statep;
 const int policy = SCHED_FIFO;
 const int prio_min;	/* Initialized for the minimum priority of policy */
 
-struct option long_options[] = {
-    { "usleep", required_argument, 0, 0 },
-    { 0,        0,                 0, 0 },
-};
-
 int main(void)
 {
 	void *mptr;	/* memory pointer */
-- 
2.9.3

