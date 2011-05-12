From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests - minor clean-ups
Date: Thu, 12 May 2011 12:55:17 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1105121251220.21611@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52866 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab1ELKz2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 May 2011 06:55:28 -0400
Received: by qyg14 with SMTP id 14so806116qyg.19
        for <linux-rt-users@vger.kernel.org>; Thu, 12 May 2011 03:55:27 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Clark

Please pull from
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch: rt-tests-dev

I have a few clean-ups in my repo that aren't in yours.
1. Spelling clean-ups - makes it look more professional
2. A function header style clean-up, and spacing.

The diff between our trees is shown below.

Thanks

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 29d0fe5..d13669b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -313,9 +313,7 @@ void traceopt(char *option)
 	traceptr[traceopt_count++] = ptr;
 }
 
