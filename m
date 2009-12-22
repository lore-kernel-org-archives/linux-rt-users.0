From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Better explanation in the kernel module
Date: Tue, 22 Dec 2009 01:11:36 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0912220109520.9791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6401 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbZLVALz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 19:11:55 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark: I'm not sure how we missed Carsten's patch again.
you can pull the following and the last clean-up from
rt-tests-dev-new
and the usual git repo
(notice the branch has changed)

Thanks

>From 77c00420d06ec5010a251d4ecac1f74201cd20ca Mon Sep 17 00:00:00 2001
From: Carsten Emde <C.Emde@osadl.org>
Date: Tue, 22 Dec 2009 00:58:59 +0100
Subject: [PATCH] rt-tests: Better explanation in the kernel module

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/backfire/sendme.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index fdc1056..27ea077 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -209,7 +209,12 @@ int main(int argc, char *argv[])
 	path = open("/dev/backfire", O_RDWR);
 	if (path < 0) {
 		fprintf(stderr, "ERROR: Could not access backfire device, "
-				"try 'modprobe backfire'\n");
+				"try 'modprobe backfire'\n"
+				"If the module backfire can't be loaded, "
+				"it may need to be built first.\n"
+				"Execute 'cd src/backfire; make' in the "
+				"rt-tests directory (requires rt-tests\n"
+				"sources and kernel-devel package).\n");
 		return 1;
 	}
 	fl.l_type = F_WRLCK;
-- 
1.6.0.6

