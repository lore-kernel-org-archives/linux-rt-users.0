From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/6] Create a .gitattribute file to specify what files git-archive should ignore
Date: Fri, 10 Jul 2015 14:25:28 +0200
Message-ID: <1436531131-9186-4-git-send-email-jkacur@redhat.com>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38334 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbbGJMZq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 08:25:46 -0400
Received: by wicmv11 with SMTP id mv11so12709183wic.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2015 05:25:45 -0700 (PDT)
In-Reply-To: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitattributes | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 .gitattributes

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 000000000000..0867b8185bb2
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1,4 @@
+.gitattributes export-ignore
+.gitignore export-ignore
+rt-tests.spec-in export-ignore
+scripts export-ignore
-- 
1.8.3.1

