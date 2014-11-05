From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 3/9] pi_stress: Remove unused TIMER_SIGNAL definition
Date: Wed,  5 Nov 2014 10:09:39 +0100
Message-ID: <1415178585-3192-4-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52815 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753281AbaKEJJt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:49 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 src/pi_tests/pi_stress.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index e273d62..39e6a37 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -157,8 +157,6 @@ int prio_min;
 #define NUM_TEST_THREADS 3
 #define NUM_ADMIN_THREADS 1
 
-#define TIMER_SIGNAL	(SIGRTMIN+1)
