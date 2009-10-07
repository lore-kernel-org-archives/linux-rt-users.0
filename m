From: John Kacur <jkacur@redhat.com>
Subject: [PATCH RFC] BKL not necessary in cpuid_open
Date: Wed, 7 Oct 2009 20:19:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910072016190.15183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29379 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbZJGSUf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2009 14:20:35 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


I've been staring at the BKL lock in cpuid_open, and I can't see what it 
is protecting. However, I may have missed something - even something 
obvious, so comments are welcome.

>From 25c0f07b3ec5533c0e690e06198baa4300ee4a8c Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 7 Oct 2009 20:06:12 +0200
Subject: [PATCH] The BKL is not necessary in cpuid_open
 Most of the variables are local to the function. It IS possible that for
 struct cpuinfo_x86 *c
 c could point to the same area. However, this is used read only.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 arch/x86/kernel/cpuid.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 6a52d4b..8bb8401 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -118,8 +118,6 @@ static int cpuid_open(struct inode *inode, struct file *file)
 	struct cpuinfo_x86 *c;
 	int ret = 0;
 
-	lock_kernel();
