From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 09/34] cyclictest: use %p for printing void*, and print stack size separately
Date: Mon, 22 May 2017 11:25:15 +0300
Message-ID: <20170522082540.15467-10-tommi.t.rantala@nokia.com>
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
        id S1752743AbdEVI0N (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:13 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0a2cd9e..f2747e4 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2389,8 +2389,9 @@ int main(int argc, char **argv)
 
 			/* set the thread's stack */
 			if (pthread_attr_setstack(&attr, stack, stksize))
-				fatal("failed to set stack addr for thread %d to 0x%x\n",
-				      i, stack+stksize);
+				fatal("failed to set stack addr "
+				      "for thread %d to %p, size %zd\n",
+				      i, stack, stksize);
 		}
 
 		/* allocate the thread's parameter block  */
-- 
2.9.3

