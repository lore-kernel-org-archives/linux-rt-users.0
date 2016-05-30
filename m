From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] cyclictest: new CPUs with SMI counter support
Date: Mon, 30 May 2016 19:25:19 -0300
Message-ID: <8cbc61e6bb66eaca972e9697ae38c4d23e193e09.1464644578.git.bristot@redhat.com>
Cc: linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34391 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162524AbcE3WZa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 May 2016 18:25:30 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3AF690E6F
	for <linux-rt-users@vger.kernel.org>; Mon, 30 May 2016 22:25:28 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Cyclictest's SMI counter implementation is based on turbostat's
implementation. This patch syncs cyclictest's has_smi_counter()
with turbostat's check.

>From turbostat's commits:
cdc5727 tools/power turbostat: initial KBL support
ec53e59 tools/power turbostat: initial SKX support
e4085d5 tools/power turbostat: initial BXT support

[ John & Clark, I did it in the branch devel/v2.0, but we need  ]
[ this in the 0.x and 1.x series as well.                       ]

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 src/cyclictest/cyclictest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 00e5f3d..5e23fc5 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -927,10 +927,14 @@ static int has_smi_counter(void)
 	case 0x56:      /* BDX-DE */
 	case 0x4E:      /* SKL */
 	case 0x5E:      /* SKL */
+	case 0x8E:      /* KBL */
+	case 0x9E:      /* KBL */
+	case 0x55:      /* SKX */
 	case 0x37:      /* BYT */
 	case 0x4D:      /* AVN */
 	case 0x4C:      /* AMT */
 	case 0x57:      /* PHI */
+	case 0x5C:      /* BXT */
 		break;
 	default:
 		return 0;
-- 
2.5.5

