From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 23/34] svsematest: test .mindiff against UINT_MAX
Date: Mon, 22 May 2017 11:25:29 +0300
Message-ID: <20170522082540.15467-24-tommi.t.rantala@nokia.com>
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
        id S1752826AbdEVI0d (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:33 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/svsematest/svsematest.c:637:29: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (receiver[i].mindiff == -1)
                             ^~

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/svsematest/svsematest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index eeb8285..9adbb52 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -634,7 +634,7 @@ int main(int argc, char *argv[])
 				    sender[i].cpu, sender[i].samples);
 			}
 			for (i = 0; i < num_threads; i++) {
-				if (receiver[i].mindiff == -1)
+				if (receiver[i].mindiff == UINT_MAX)
 					printf("#%d -> #%d (not yet ready)\n",
 					    i*2+1, i*2);
 				else
-- 
2.9.3

