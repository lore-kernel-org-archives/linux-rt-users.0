From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] Add a .gitignore file in the backfire directory for generated files.
Date: Mon, 14 Dec 2009 22:39:02 +0100
Message-ID: <1260826742-15296-4-git-send-email-jkacur@redhat.com>
References: <1260826742-15296-1-git-send-email-jkacur@redhat.com>
 <1260826742-15296-2-git-send-email-jkacur@redhat.com>
 <1260826742-15296-3-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:38764 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbZLNVjV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 16:39:21 -0500
Received: by fxm21 with SMTP id 21so3800734fxm.21
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 13:39:19 -0800 (PST)
In-Reply-To: <1260826742-15296-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add a .gitignore file in the backfire directory for generated files
that are created when making the kernel module.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/backfire/.gitignore |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 src/backfire/.gitignore

diff --git a/src/backfire/.gitignore b/src/backfire/.gitignore
new file mode 100644
index 0000000..9af500d
--- /dev/null
+++ b/src/backfire/.gitignore
@@ -0,0 +1,5 @@
+Module.symvers
+backfire.ko
+backfire.mod.c
+modules.order
+
-- 
1.6.5.2

