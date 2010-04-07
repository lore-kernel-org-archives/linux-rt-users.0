From: John Kacur <jkacur@redhat.com>
Subject: [rt: PATCH - resend] Fix-up boot-up warnings surrounding CONFIG_STACK_TRACER
Date: Wed,  7 Apr 2010 20:40:39 +0200
Message-ID: <1270665640-8520-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:52883 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004Ab0DGSks (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Apr 2010 14:40:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas

I respun this against 2.6.33.2-rt13 and combined the two original patches
into one as suggested by Steven Rostedt, and added his Acked-by.

Please consider this patch for the next -rt release.

Thanks

John Kacur (1):
  rt: This fixes the boot-up messages related to CONFIG_STACK_TRACER

 init/main.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

