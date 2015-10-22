From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] gitattributes: add doc, remove rt.spec-in
Date: Thu, 22 Oct 2015 17:50:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510221749500.5660@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38308 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875AbbJVPuf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 11:50:35 -0400
Received: by wicll6 with SMTP id ll6so125595790wic.1
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2015 08:50:34 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From cc85b39dd7a5930a6abb2847bbb40e2fdc6d3e92 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 22 Oct 2015 17:13:07 +0200
Subject: [PATCH 2/3] gitattributes: add doc, remove rt.spec-in

The doc dir only contains one file which is a list of things for the
maintainers to do at release time, no need to package this in the
tarball.

Since the file rt.spec-in has now been removed, we no-longer need to
mention it in the .gitattributes file

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 0867b8185bb2..0116a6cff8ed 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,4 +1,4 @@
 .gitattributes export-ignore
 .gitignore export-ignore
-rt-tests.spec-in export-ignore
+doc export-ignore
 scripts export-ignore
-- 
2.4.3

