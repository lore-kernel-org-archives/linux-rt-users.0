From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] rt-tests: pi_stress fixes
Date: Thu, 19 Nov 2009 17:35:12 +0100
Message-ID: <1258648515-7566-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:42674 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275AbZKSQfM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Nov 2009 11:35:12 -0500
Received: by fxm21 with SMTP id 21so2597597fxm.21
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Nov 2009 08:35:17 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have tested these patches on a Nehalem machine with 4 cores and HT.
It would be good if folks with larger machines tested too.

I pushed the changes to
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch rt-tests-dev
In the order they should be applied starting with the first:
97dbb3cebd200a4d45d89d8e264e43b119b2cbcf 
9093a5de51964f3a9ab1454a77181fad2d3e7217
2712903a40560378cb61336994258780cfbb83d9

Thanks


John Kacur (3):
  rt-tests: pi_stress: Use a pthread_mutex_t for the global variable
    shutdown
  rt-tests: pi_stress: Check whether quiet is set, before taking
    shutdown_mtx
  rt-tests: pi_stress: Remove racy state variables that cause watchdog
    to trigger

 src/pi_tests/pi_stress.c |   58 +++++++++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 24 deletions(-)

