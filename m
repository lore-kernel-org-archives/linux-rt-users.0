From: David Sommerseth <davids@redhat.com>
Subject: [PATCH 1/4] Fixed missing parsing of short arguments in classic_pi
Date: Tue, 22 Dec 2009 16:47:35 +0100
Message-ID: <1261496858-12744-2-git-send-email-davids@redhat.com>
References: <1261496858-12744-1-git-send-email-davids@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com,
	David Sommerseth <davids@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbZLVPrm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2009 10:47:42 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBMFlfA7008912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2009 10:47:41 -0500
In-Reply-To: <1261496858-12744-1-git-send-email-davids@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: David Sommerseth <davids@redhat.com>
---
 src/pi_tests/classic_pi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pi_tests/classic_pi.c b/src/pi_tests/classic_pi.c
index 59e907b..2b8ef3d 100644
--- a/src/pi_tests/classic_pi.c
+++ b/src/pi_tests/classic_pi.c
@@ -198,7 +198,7 @@ int main(int argc, char **argv)
 	setvbuf (stdout, NULL, _IONBF, 0);
 
 	/* process command line arguments */
-	while ((opt = getopt_long(argc, argv, "+", options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "vqni:", options, NULL)) != -1) {
 		switch (opt) {
 		case '?':
 			usage();
-- 
1.6.2.5

