From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/6] pi_stress clean-ups, fix hang.
Date: Mon, 14 Sep 2009 16:33:31 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909141629130.4675@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbZINOdd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 10:33:33 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8EEXaFw003324
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2009 10:33:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From f17765e52e248b3a738f5206cb4b97bdcc1a0204 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Tue, 1 Sep 2009 15:24:23 +0200
Subject: [PATCH] Add tags and TAGS to .gitignore

Add tags and TAGS to .gitignore, to prepare for a make tags option
---
 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0a930a0..41d1a1e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,3 +15,6 @@ cyclictest
 signaltest
 rt-tests.spec
 hwlatdetect
+tags
+TAGS
+
-- 
1.6.0.6

