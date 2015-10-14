From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/7] specfile: add signaltest manpage to files section and remove trailing whitespace in changelog
Date: Wed, 14 Oct 2015 15:32:16 +0200
Message-ID: <1444829538-18465-6-git-send-email-jkacur@redhat.com>
References: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34520 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbbJNNdN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 09:33:13 -0400
Received: by wicgb1 with SMTP id gb1so130450468wic.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 06:33:12 -0700 (PDT)
In-Reply-To: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Clark Williams <williams@redhat.com>

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rt-tests.spec-in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rt-tests.spec-in b/rt-tests.spec-in
index 4ce2d41b978e..25791939ba16 100644
--- a/rt-tests.spec-in
+++ b/rt-tests.spec-in
@@ -66,6 +66,7 @@ rm -rf $RPM_BUILD_ROOT
 /usr/share/man/man8/svsematest.8.gz
 /usr/share/man/man8/pmqtest.8.gz
 /usr/share/man/man8/hackbench.8.gz
+/usr/share/man/man8/signaltest.8.gz
 
 %changelog
  * Wed Oct 07 2015 John Kacur <jkacur@redhat.com> - 0.95-1
@@ -132,7 +133,7 @@ rm -rf $RPM_BUILD_ROOT
   - Change VERSION_STRING to VERSION
   - Create an rt-tests.tar file using git-archive
 
- * Tue Jun 09 2015 John Kacur <jkacur@redhat.com> - 0.92-1 
+ * Tue Jun 09 2015 John Kacur <jkacur@redhat.com> - 0.92-1
 - Anna-Maria Gleixner (2):
   - cyclictest: Convert the offset of the alignment option to microseconds
   - cyclictest: Align measurement threads to the next full second
-- 
2.4.3

