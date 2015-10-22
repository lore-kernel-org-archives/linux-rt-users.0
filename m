From: Clark Williams <williams@redhat.com>
Subject: [PATCH] rt-tests: Makefile: fixed dropped quote in help target
Date: Thu, 22 Oct 2015 14:41:55 -0500
Message-ID: <20151022144155.719760c4@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38686 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243AbbJVTl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 15:41:57 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id B09BB74
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2015 19:41:56 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 2b16becaef4e70cd7630785850d5fefe4949533b Mon Sep 17 00:00:00 2001
From: Clark Williams <williams@redhat.com>
Date: Thu, 22 Oct 2015 14:38:49 -0500
Subject: [PATCH] Makefile: fixed dropped quote in help target text

Signed-off-by: Clark Williams <williams@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 908187202ba3..2e6ad8a1107f 100644
--- a/Makefile
+++ b/Makefile
@@ -201,7 +201,7 @@ install_hwlatdetect: hwlatdetect
 	@echo "    install   :  install tests to local filesystem"
 	@echo "    clean     :  remove object files"
 	@echo "    distclean :  remove all generated files"
-	@echo "	   tarball   :  make a rt-tests tarball suitable for release
+	@echo "    tarball   :  make a rt-tests tarball suitable for release"
 	@echo "    help      :  print this message"
 
 .PHONY: tags
-- 
2.4.3

