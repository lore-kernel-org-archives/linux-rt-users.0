From: Alessio Igor Bogani <abogani@texware.it>
Subject: [PATCH] Avoid to remove too much files
Date: Sat,  9 Aug 2008 19:19:47 +0200
Message-ID: <1218302388-29918-1-git-send-email-abogani@texware.it>
Cc: Alessio Igor Bogani <abogani@texware.it>
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:36082 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYHIRUE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Aug 2008 13:20:04 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1517103ika.5
        for <linux-rt-users@vger.kernel.org>; Sat, 09 Aug 2008 10:20:03 -0700 (PDT)
In-Reply-To: <>
References: <>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b7ac587..1b1b02c 100644
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ pi_stress:  src/pi_tests/pi_stress.c
 CLEANUP = $(TARGETS) *.o .depend *.*~ ChangeLog *.orig *.rej rt-tests.spec
 
 clean:
-	for F in $(CLEANUP); do find -type f -iname $$F | xargs rm -f; done
+	for F in $(CLEANUP); do find -type f -name $$F | xargs rm -f; done
 
 distclean: clean
 	rm -rf BUILD RPMS SRPMS releases
-- 
1.5.4.3

