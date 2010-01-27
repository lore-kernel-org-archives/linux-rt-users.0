From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/5] rt-tests: rt_numa.h clean-ups, and dependency files
Date: Wed, 27 Jan 2010 21:24:23 +0100
Message-ID: <1264623868-23595-1-git-send-email-jkacur@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Carsten Emde <C.Emde@osadl.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:32839 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab0A0UYh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jan 2010 15:24:37 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This set of patches are mostly clean-up to our new rt_numa.h file.
We need to add a copyright notice in every file for some distributions.
This also creates some changes to simplify and clean-up
the differences between the code for the older LIBNUMA_API_VERSION and the
newer ones. (or at least I hope you will think so).
Finally there is a change to automatically generate dependencies for the
Makefile.

John Kacur (5):
  rt-tests: Add header including copyright notice to rt_numa.h
  rt-tests: Separate the #ifdef LIBNUMA_API_VERSION functions.
  rt-tests: Remove the ret variable, the end label and the goto.
  rt-tests: Fix some style problems, such as spaces instead of tabs.
  rt-tests: Automatically generate dependencies.

 Makefile                 |   20 ++++++++++++---
 src/cyclictest/rt_numa.h |   58 ++++++++++++++++++++++++++++-----------------
 2 files changed, 52 insertions(+), 26 deletions(-)

