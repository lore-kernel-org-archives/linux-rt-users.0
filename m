From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH] cyclictest: change-output-format-to-allow-6-digits.patch
Date: Wed, 01 Jul 2009 19:02:12 -0700
Message-ID: <1246500132.32598.12.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:52728 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbZGBCCM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jul 2009 22:02:12 -0400
Received: by pxi28 with SMTP id 28so1202844pxi.33
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jul 2009 19:02:15 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Sven-Thorsten Dietrich <sdietrich@suse.de>
Date: Sat, 21 Mar 2009 16:41:40 -0700
Subject: [PATCH] Change output format to allow 6 digits.

This is useful when testing PREEMPT_NONE Kernels with cyclictest,
where latencies approaching 1 second can be observed.


Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
---
 src/cyclictest/cyclictest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dad68aa..e7485d1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -891,7 +891,7 @@ static void print_hist(struct thread_param *par, int nthreads)
 	printf("# Histogram\n");
 	for (i = 0; i < histogram; i++) {
 
-		printf("%05d ", i);
+		printf("%06d ", i);
 
 		for (j = 0; j < nthreads; j++) {
 			unsigned long curr_latency=par[j].stats->hist_array[i];

