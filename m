From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests / gitignore: Exclude patches and .a libs too.
Date: Wed,  9 May 2012 17:37:36 +0200
Message-ID: <1336577856-8857-1-git-send-email-jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37177 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176Ab2EIPht (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 11:37:49 -0400
Received: by bkcji2 with SMTP id ji2so410600bkc.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 May 2012 08:37:48 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Minor fix to make working with git nicer.
Now that we're building a lib, we need to exclude it from git status output.
Do the same for patches we generate or apply.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 047925c..1924e73 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,8 @@
 *.o
 *.tar.gz
 *.d
+*.patch
+*.a
 tmp
 patches
 ChangeLog
-- 
1.7.7.6

