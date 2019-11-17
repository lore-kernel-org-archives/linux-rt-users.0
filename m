Return-Path: <SRS0=g5oN=ZJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD67BC432C0
	for <linux-rt-users@archiver.kernel.org>; Sun, 17 Nov 2019 21:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96842206CC
	for <linux-rt-users@archiver.kernel.org>; Sun, 17 Nov 2019 21:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfKQVoL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 17 Nov 2019 16:44:11 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:55998 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQVoL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 17 Nov 2019 16:44:11 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 8C9E083D6FC; Sun, 17 Nov 2019 22:44:09 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH rt-tests] Makefile: don't create empty directories in install target
Date:   Sun, 17 Nov 2019 22:44:05 +0100
Message-Id: <20191117214405.28271-1-ukleinek@debian.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Both $(prefix)/src and $(prefix)/share/man/man4 are unused since commit
2829763fdd79 ("rt-tests: Remove install and build of backfire and
sendme")
---
 Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index b57340874213..6eee3d8f7845 100644
--- a/Makefile
+++ b/Makefile
@@ -27,7 +27,6 @@ DESTDIR	?=
 prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
-srcdir	?= $(prefix)/src
 
 CFLAGS ?= -Wall -Wno-nonnull
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
@@ -177,8 +176,7 @@ rebuild:
 
 .PHONY: install
 install: all install_hwlatdetect
-	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
-	mkdir -p "$(DESTDIR)$(srcdir)" "$(DESTDIR)$(mandir)/man8"
+	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
 	install src/queuelat/get_cpuinfo_mhz.sh "$(DESTDIR)$(bindir)"
 	install src/queuelat/determine_maximum_mpps.sh "${DESTDIR}${bindir}"
-- 
2.24.0

