From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/5] rt-tests: Add a "make tags" option.
Date: Wed, 23 Dec 2009 17:03:00 +0100
Message-ID: <1261584180-13922-6-git-send-email-jkacur@redhat.com>
References: <1261584180-13922-1-git-send-email-jkacur@redhat.com>
 <1261584180-13922-2-git-send-email-jkacur@redhat.com>
 <1261584180-13922-3-git-send-email-jkacur@redhat.com>
 <1261584180-13922-4-git-send-email-jkacur@redhat.com>
 <1261584180-13922-5-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36219 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbZLWQDO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 11:03:14 -0500
Received: by fxm5 with SMTP id 5so7112564fxm.28
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2009 08:03:13 -0800 (PST)
In-Reply-To: <1261584180-13922-5-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add a "make tags" option to the Makefile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 3339556..c33a053 100644
--- a/Makefile
+++ b/Makefile
@@ -73,6 +73,7 @@ CLEANUP += $(if $(wildcard .git), ChangeLog)
 clean:
 	for F in $(CLEANUP); do find -type f -name $$F | xargs rm -f; done
 	rm -f hwlatdetect
+	rm -f tags
 
 .PHONY: distclean
 distclean: clean
@@ -144,3 +145,7 @@ help:
 	@echo "    clean     :  remove object files"
 	@echo "    distclean :  remove all generated files"
 	@echo "    help      :  print this message"
+
+.PHONY: tags
+tags:
+	ctags -R --extra=+f --c-kinds=+p *
-- 
1.6.5.2

