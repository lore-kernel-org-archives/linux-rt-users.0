From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/7] The version of check_privs that got added to the library must have come from signaltest - because it doesn't have the fix that check_privs in cyclictest has - to return the sched_priority to 0
Date: Mon, 14 Dec 2009 16:58:56 +0100
Message-ID: <1260806336-4691-8-git-send-email-jkacur@redhat.com>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
 <1260806336-4691-2-git-send-email-jkacur@redhat.com>
 <1260806336-4691-3-git-send-email-jkacur@redhat.com>
 <1260806336-4691-4-git-send-email-jkacur@redhat.com>
 <1260806336-4691-5-git-send-email-jkacur@redhat.com>
 <1260806336-4691-6-git-send-email-jkacur@redhat.com>
 <1260806336-4691-7-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:17516 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567AbZLNP7a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 10:59:30 -0500
Received: by gv-out-0910.google.com with SMTP id r4so33107gve.37
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 07:59:29 -0800 (PST)
In-Reply-To: <1260806336-4691-7-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a good example of why common functions should be put into libraries -
so all programs benefit from fixes.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-utils.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 4e7597c..417c38b 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -60,6 +60,7 @@ int check_privs(void)
 	}
 
 	/* we're good; change back and return success */
+	param.sched_priority = 0;
 	sched_setscheduler(0, policy, NULL);
 	return 0;
 }
-- 
1.6.5.2

