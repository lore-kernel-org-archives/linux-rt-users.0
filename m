From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cyclictest: process option before checking for permissions
Date: Mon, 13 Jul 2009 14:34:48 +0200
Message-ID: <20090713123448.GB2515@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:53209 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461AbZGMMfF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 08:35:05 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

so a normal user is able to take a look on the available options

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index e1c9e0e..2b4dc50 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1185,11 +1185,11 @@ int main(int argc, char **argv)
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	int i, ret = -1;
 
+	process_options(argc, argv);
+
 	if (check_privs())
 		exit(-1);
 
-	process_options(argc, argv);
