From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/6] Miscellaneous cyclictest patches
Date: Thu, 14 Aug 2014 18:18:04 +0200
Message-ID: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57037 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbaHNQSR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 12:18:17 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so1292915wgh.3
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Aug 2014 09:18:16 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Miscellany of cyclictest patches, most are just clean-ups

Slightly more important are fixes to set_latency_target to always print
a message if writing 0 to /dev/cpu_dma_latency fails and also an option
to allow you to not use this functionality if you wish.

Pushed to 

repo: https://www.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git/
branch: v0.89-devel

Cheers!

John Kacur (6):
  lib: Rework err_msg_n to output strerror after message
  rt_numa.h: Suppress discards 'const' qualifier warning
  cyclictest: Always print an err message if write of 0 to
    cpu-dma_latency fails
  cyclictest: Change the output from function sighand() to stderr
  cyclictest: Fix help for long options only
  cyclictest: Add long option --laptop to preserve battery power

 src/cyclictest/cyclictest.c | 69 ++++++++++++++++++++++++++++++---------------
 src/cyclictest/rt_numa.h    |  2 +-
 src/lib/error.c             |  4 +--
 3 files changed, 49 insertions(+), 26 deletions(-)

-- 
1.8.1.4

