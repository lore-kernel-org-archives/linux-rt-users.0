From: Alessio Igor Bogani <abogani@texware.it>
Subject: [PATCH] Avoid ChangeLog erasing in tarball release
Date: Tue, 17 Mar 2009 21:50:42 +0100
Message-ID: <1237323042-5959-1-git-send-email-abogani@texware.it>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Alessio Igor Bogani <abogani@texware.it>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:45217 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbZCQU6Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Mar 2009 16:58:24 -0400
Received: by bwz17 with SMTP id 17so253595bwz.37
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Mar 2009 13:58:21 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Execute a make clean into a rt-tests directory, exploded from a tarball,
cause erroneous erasing of the ChangeLog file. Let make do it only if it
executes under git tree.

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 1d9da78..fb8f917 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,8 @@ classic_pi: src/pi_tests/classic_pi.c
 pi_stress:  src/pi_tests/pi_stress.c
 	$(CC) $(FLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
 
-CLEANUP = $(TARGETS) *.o .depend *.*~ ChangeLog *.orig *.rej rt-tests.spec
+CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
+CLEANUP += $(if $(wildcard .git), ChangeLog)
 
 clean:
 	for F in $(CLEANUP); do find -type f -name $$F | xargs rm -f; done
-- 
1.6.0.4

