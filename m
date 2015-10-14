From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/7] Makefile: OBJDIR should be an order-only-prerequisite
Date: Wed, 14 Oct 2015 15:32:15 +0200
Message-ID: <1444829538-18465-5-git-send-email-jkacur@redhat.com>
References: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35952 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbbJNNdL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 09:33:11 -0400
Received: by wicgb1 with SMTP id gb1so231216932wic.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 06:33:10 -0700 (PDT)
In-Reply-To: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

OBJDIR should be an order only prerequisite.
- create the OBJDIR if necessary before .d, .o and before all TARGETS
  including hwlatdetect
- Don't rebuild if the timestamp on the OBJDIR changes

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1c3ae50030d6..37ab159e84f9 100644
--- a/Makefile
+++ b/Makefile
@@ -85,15 +85,15 @@ VPATH	+= src/backfire:
 VPATH	+= src/lib:
 VPATH	+= src/hackbench:
 
-$(OBJDIR)/%.o: %.c
+$(OBJDIR)/%.o: %.c | $(OBJDIR)
 	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
 
 # Pattern rule to generate dependency files from .c files
-$(OBJDIR)/%.d: %.c
+$(OBJDIR)/%.d: %.c | $(OBJDIR)
 	@$(CC) -MM $(CFLAGS) $(CPPFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ || rm -f $@
 
 .PHONY: all
-all: $(OBJDIR) $(TARGETS) hwlatdetect
+all: $(TARGETS) hwlatdetect | $(OBJDIR)
 
 $(OBJDIR):
 	mkdir $(OBJDIR)
-- 
2.4.3

