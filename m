From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/7] Makefile: add target to create OBJDIR before use
Date: Wed, 14 Oct 2015 15:32:14 +0200
Message-ID: <1444829538-18465-4-git-send-email-jkacur@redhat.com>
References: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34444 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbbJNNdJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 09:33:09 -0400
Received: by wicgb1 with SMTP id gb1so130448520wic.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 06:33:08 -0700 (PDT)
In-Reply-To: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Clark Williams <williams@redhat.com>

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5d7a23e6bbfd..1c3ae50030d6 100644
--- a/Makefile
+++ b/Makefile
@@ -93,7 +93,10 @@ $(OBJDIR)/%.d: %.c
 	@$(CC) -MM $(CFLAGS) $(CPPFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ || rm -f $@
 
 .PHONY: all
-all: $(TARGETS) hwlatdetect
+all: $(OBJDIR) $(TARGETS) hwlatdetect
+
+$(OBJDIR):
+	mkdir $(OBJDIR)
 
 # Include dependency files, automatically generate them if needed.
 -include $(addprefix $(OBJDIR)/,$(sources:.c=.d))
-- 
2.4.3

