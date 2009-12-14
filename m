From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] The PHONY target for install is incorrectly specified as "all"
Date: Mon, 14 Dec 2009 22:39:00 +0100
Message-ID: <1260826742-15296-2-git-send-email-jkacur@redhat.com>
References: <1260826742-15296-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:32343 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZLNVjS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 16:39:18 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1680680fgg.1
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 13:39:17 -0800 (PST)
In-Reply-To: <1260826742-15296-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Change the PHONY target for install to install

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 3a85336..d19c992 100644
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,7 @@ distclean: clean
 changelog:
 	git log >ChangeLog
 
-.PHONY: all
+.PHONY: install
 install: all
 	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
 	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8"
-- 
1.6.5.2

