From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests] drop compiling without NPTL support
Date: Tue,  6 Oct 2015 08:43:58 +0200
Message-ID: <1444113838-5123-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.LFD.2.20.1510052149190.14006@riemann>
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:55432 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342AbbJFGoB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 02:44:01 -0400
In-Reply-To: <alpine.LFD.2.20.1510052149190.14006@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

all programs apart from sendme use pthreads so NPTL=no is hardly useful
any more.
---
 Makefile | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 1e255a983574..6ce2ecc7fc30 100644
--- a/Makefile
+++ b/Makefile
@@ -4,14 +4,17 @@ AR=$(CROSS_COMPILE)ar
 
 OBJDIR = bld
 
-HAVE_NPTL ?= yes
-
-ifeq ($(HAVE_NPTL),yes)
-sources = cyclictest.c pi_stress.c pip_stress.c pmqtest.c rt-migrate-test.c
-endif
