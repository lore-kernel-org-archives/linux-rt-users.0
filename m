From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/6] =?UTF-8?q?Fix=20warning:=20unused=20variable=20?= =?UTF-8?q?=E2=80=98c=E2=80=99?=
Date: Fri, 10 Jul 2015 14:25:26 +0200
Message-ID: <1436531131-9186-2-git-send-email-jkacur@redhat.com>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38276 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbbGJMZm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 08:25:42 -0400
Received: by wicmv11 with SMTP id mv11so12707685wic.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2015 05:25:41 -0700 (PDT)
In-Reply-To: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a legitimate compiler warning, so remove the unused variable.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pip_stress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 66b3dc1c9fea..812a7030aa9d 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -91,7 +91,6 @@ int main(void)
 	cpu_set_t set, *setp = &set;
 	int res;
 	int *minimum_priority = (int*)&prio_min;
-	int c;
 
 	*minimum_priority = sched_get_priority_min(policy);
 
-- 
1.8.3.1

