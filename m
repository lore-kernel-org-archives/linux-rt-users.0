From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH 4/4] rt-tests: cyclictest warn of interaction between '-a',
 '--smp', and '--numa'
Date: Tue, 1 May 2012 19:45:44 -0700
Message-ID: <4FA09FD8.2040204@am.sony.com>
References: <4FA09D6A.2050101@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "jkacur@redhat.com" <jkacur@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:8793 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758532Ab2EBCqG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 May 2012 22:46:06 -0400
In-Reply-To: <4FA09D6A.2050101@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The '-a' option is always ignored if --smp or --numa is specified.  Fix the
warning message to not depend on --smp or --numa occuring first.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |   14 	11 +	3 -	0 !
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -949,6 +949,7 @@ static char *policyname(int policy)
 static void process_options (int argc, char *argv[])
 {
 	int error = 0;
+	int option_affinity = 0;
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct rlimit rlim;
 
@@ -1000,10 +1001,9 @@ static void process_options (int argc, c
 			break;
 		switch (c) {
 		case 'a':
-			if (smp) {
-				warn("-a ignored due to --smp\n");
+			option_affinity = 1;
+			if (smp || numa)
 				break;
-			}
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
 				setaffinity = AFFINITY_SPECIFIED;
@@ -1112,6 +1112,14 @@ static void process_options (int argc, c
 		}
 	}
 
+	if (option_affinity) {
+		if (smp) {
+			warn("-a ignored due to --smp\n");
+		} else if (numa) {
+			warn("-a ignored due to --numa\n");
+		}
+	}
+
 	if (setaffinity == AFFINITY_SPECIFIED) {
 		if (affinity < 0)
 			error = 1;

