From: trem <tremyfr@yahoo.fr>
Subject: [PATCH] fix argument -C on cyclictest
Date: Sun, 19 Apr 2009 17:09:25 +0200
Message-ID: <gsfer5$6sr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44901 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757979AbZDSPJk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Apr 2009 11:09:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LvYeH-0003Nv-NI
	for linux-rt-users@vger.kernel.org; Sun, 19 Apr 2009 15:09:37 +0000
Received: from atoulouse-256-1-41-67.w90-38.abo.wanadoo.fr ([90.38.232.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Apr 2009 15:09:37 +0000
Received: from tremyfr by atoulouse-256-1-41-67.w90-38.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Apr 2009 15:09:37 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The argument -C isn't used in cyclictest, only --context is recognized.

Signed-off-by: trem <trem@mandriva.org>
---
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f878217..e67d0d3 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -777,7 +777,7 @@ static void process_options (int argc, char *argv[])
                        {"help", no_argument, NULL, '?'},
                        {NULL, 0, NULL, 0}
                };
-               int c = getopt_long (argc, argv, "a::b:Bc:d:fh:i:Il:nNo:p:Pmqrst::vD:",
+               int c = getopt_long (argc, argv, "a::b:Bc:Cd:fh:i:Il:nNo:p:Pmqrst::vD:",
                        long_options, &option_index);
                if (c == -1)
                        break;

