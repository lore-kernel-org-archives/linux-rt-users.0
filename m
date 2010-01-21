From: John Kacur <jkacur@redhat.com>
Subject: GeunSik's patch.
Date: Thu, 21 Jan 2010 13:03:38 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1001211257390.3873@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231Ab0AUMXB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jan 2010 07:23:01 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Clark.

I tested GeunSik's patch, and it is indeed required for developers who
wish to use the -static link flag.

I rewrote his changelog though, as it was a bit confusing.

You can pull the change from.
kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git patches

(Against the master branch of course)

Thanks

>From b33df8bf61c413f649d57b58804f3a726fa8fde3 Mon Sep 17 00:00:00 2001
From: GeunSik Lim <leemgs1@gmail.com>
Date: Thu, 21 Jan 2010 01:09:30 +0100
Subject: [PATCH] rt-tests: Support static linking by reordering the link flags in LIBS

Some embedded developers cross-compile the tests with the -static link flag.
Reordering the link flags in LIBS to put -lrt before -lpthread is necessary,
else you get undefined references to pthread calls.

Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e14d957..65f506a 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,7 @@ VERSION_STRING = 0.61
 TARGETS	= cyclictest signaltest pi_stress \
 	  hwlatdetect rt-migrate-test ptsematest sigwaittest svsematest \
 	  sendme pip
-LIBS 	= -lpthread -lrt
+LIBS 	= -lrt -lpthread
 EXTRA_LIBS ?= -ldl	# for get_cpu
 DESTDIR	?=
 prefix  ?= /usr/local
-- 
1.6.0.6

