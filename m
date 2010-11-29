From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/2] minor patches for rt-tests
Date: Mon, 29 Nov 2010 16:38:53 +0100
Message-ID: <1291045135-15541-1-git-send-email-w.sang@pengutronix.de>
Cc: Clark Williams <williams@redhat.com>,
	Wolfram Sang <w.sang@pengutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52825 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0K2PjR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Nov 2010 10:39:17 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Here are two minor patches taken from ptxdist. Easy stuff :)

Wolfram Sang (2):
  cyclictest: fix wakeup_latency name for tracing
  rt-tests: Simplify makefile a bit

 Makefile                    |    6 ++----
 src/cyclictest/cyclictest.c |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
1.7.2.3

