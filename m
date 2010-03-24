From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/2] [rt-kernel]
Date: Wed, 24 Mar 2010 18:35:05 +0100
Message-ID: <1269452107-28655-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:46770 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab0CXRfO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 13:35:14 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These are two trivial rt-kernel patches to fix up an unnecessary warning.

John Kacur (2):
  Revert "rt: trivial fix to REMINDER block in init/main.c"
  rt: Remove CONFIG_STACK_TRACER from DEBUG_COUNT

 init/main.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

