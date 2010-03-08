From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] cyclictest: Fix spelling mistake in the man page.
Date: Mon,  8 Mar 2010 02:18:23 +0100
Message-ID: <1268011104-22451-4-git-send-email-jkacur@redhat.com>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:61105 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab0CHBSc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 20:18:32 -0500
Received: by ey-out-2122.google.com with SMTP id 25so773328eya.19
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Mar 2010 17:18:32 -0800 (PST)
In-Reply-To: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

	- In the -mlockall section, change "an" to "and"

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 91e1102..a6ddb92 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -134,7 +134,7 @@ Set the number of test threads (default is 1). Create NUM test threads. If NUM i
 the number of available CPUs. See \-d, \-i and \-p for further information.
 .TP
 .B \-m, \-\-mlockall
-Lock current an future memory allocations to prevent being paged out
+Lock current and future memory allocations to prevent being paged out
 .TP
 .B \-v, \-\-verbose
 Output values on stdout for statistics. This option is used to gather statistical information about the latency distribution. The output is sent to stdout. The output format is:
-- 
1.6.0.6

