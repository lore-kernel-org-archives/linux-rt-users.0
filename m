From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/7] Makefile: have distclean remove .asc file for tarball
Date: Wed, 14 Oct 2015 15:32:17 +0200
Message-ID: <1444829538-18465-7-git-send-email-jkacur@redhat.com>
References: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32956 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbJNNdH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 09:33:07 -0400
Received: by wicge5 with SMTP id ge5so101812012wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 06:33:06 -0700 (PDT)
In-Reply-To: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Clark Williams <williams@redhat.com>

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 37ab159e84f9..563911d5f6da 100644
--- a/Makefile
+++ b/Makefile
@@ -155,7 +155,7 @@ clean:
 RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
 .PHONY: distclean
 distclean: clean
-	rm -rf $(RPMDIRS) releases *.tar.gz rt-tests.spec tmp
+	rm -rf $(RPMDIRS) releases *.tar.gz *.tar.asc rt-tests.spec tmp
 
 .PHONY: rebuild
 rebuild:
-- 
2.4.3

