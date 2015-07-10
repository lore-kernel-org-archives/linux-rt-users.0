From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/6] Add .tar files to .gitignore
Date: Fri, 10 Jul 2015 14:25:29 +0200
Message-ID: <1436531131-9186-5-git-send-email-jkacur@redhat.com>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33278 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbbGJMZs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 08:25:48 -0400
Received: by wgck11 with SMTP id k11so248246712wgc.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2015 05:25:46 -0700 (PDT)
In-Reply-To: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ignore .tar files too

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 1924e73bef67..ceee8bfb6e9a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 .*
 *.o
 *.tar.gz
+*.tar
 *.d
 *.patch
 *.a
-- 
1.8.3.1

