From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 18/34] pip_stress: fix missing argument in err_msg() call in process_shared_mutex_available()
Date: Mon, 22 May 2017 11:25:24 +0300
Message-ID: <20170522082540.15467-19-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:43936
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752804AbdEVI00 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:26 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/pi_tests/pip_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index e6cf0ce..1245705 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -244,7 +244,7 @@ long process_shared_mutex_available(void)
 	res = sysconf(_SC_THREAD_PROCESS_SHARED);
 	if (res == -1) {
 		int err = errno;	/* save the error number */
-		err_msg("%s: sysconf(_SC_THREAD_PROCESS_SHARED): ");
+		err_msg("%s: sysconf(_SC_THREAD_PROCESS_SHARED): ", __func__);
 		err_exit(err, NULL);
 	}
 #else
-- 
2.9.3

