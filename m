From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 20/34] pi_stress: use cpus_online() helper
Date: Mon, 22 May 2017 11:25:26 +0300
Message-ID: <20170522082540.15467-21-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50126.outbound.protection.outlook.com ([40.107.5.126]:6656
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752859AbdEVI0e (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:34 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/pi_tests/pi_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 36b64ca..116869a 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -270,7 +270,7 @@ int main(int argc, char **argv)
 	setvbuf(stdout, NULL, _IONBF, 0);
 
 	/* get the number of processors */
-	num_processors = sysconf(_SC_NPROCESSORS_ONLN);
+	num_processors = cpus_online();
 
 	/* calculate the number of inversion groups to run */
 	ngroups = num_processors == 1 ? 1 : num_processors - 1;
-- 
2.9.3

