From: Alessio Igor Bogani <abogani@texware.it>
Subject: [PATCH] Fix typo in pi_stress manpage
Date: Sat,  9 Aug 2008 19:19:48 +0200
Message-ID: <1218302388-29918-2-git-send-email-abogani@texware.it>
References: <>
 <1218302388-29918-1-git-send-email-abogani@texware.it>
Cc: Alessio Igor Bogani <abogani@texware.it>
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:36082 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYHIRUM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Aug 2008 13:20:12 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1517103ika.5
        for <linux-rt-users@vger.kernel.org>; Sat, 09 Aug 2008 10:20:12 -0700 (PDT)
In-Reply-To: <1218302388-29918-1-git-send-email-abogani@texware.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 src/pi_tests/pi_stress.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index fd4574e..0d21c80 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -72,7 +72,7 @@ Run all threads on one processor. The default is to run all inversion
 group threads on one processor and the admin threads (reporting
 thread, keyboard reader, etc.) on a different processor.
 .IP \-m|\-\-mlockall
-Call mlockall to lock currnet and future memory allocations and
+Call mlockall to lock current and future memory allocations and
 prevent being paged out
 .IP \-h|\-\-help
 Display a short help message and options.
-- 
1.5.4.3

