From: Alessio Igor Bogani <abogani@texware.it>
Subject: [PATCH] Fix typo in pi_stress manpage
Date: Thu, 17 Jul 2008 11:57:07 +0200
Message-ID: <1216288627-25373-1-git-send-email-abogani@texware.it>
Cc: Alessio Igor Bogani <abogani@texware.it>
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:11648 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbYGQJ5R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jul 2008 05:57:17 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3714758fkq.5
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Jul 2008 02:57:16 -0700 (PDT)
In-Reply-To: <>
References: <>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 src/pi_tests/pi_stress.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index 16f0074..fd4574e 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -71,7 +71,7 @@ Prompt before actually starting the stress test
 Run all threads on one processor. The default is to run all inversion
 group threads on one processor and the admin threads (reporting
 thread, keyboard reader, etc.) on a different processor.
-.IP \m|\-\-mlockall
+.IP \-m|\-\-mlockall
 Call mlockall to lock currnet and future memory allocations and
 prevent being paged out
 .IP \-h|\-\-help
-- 
1.5.4.3

