From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: cyclictest - minor change request for histogram
Date: Fri, 10 Feb 2012 13:45:56 +0100
Message-ID: <20120210124556.GA7487@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, carsten.emde@osadl.org,
	linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:52896 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759213Ab2BJMp6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Feb 2012 07:45:58 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


HI !

 minor change request to the histogram in cyclictest to record the
 comandline - needed for confused people like me ...

 I would prefere if the commandline with the parameters used during the
 test-run would be recorded in the histogram output - thats what the 
 below patch does. i.e. runing:

hofrat@debian:~/rt-tests$ ./cyclictest -q -p 10 -n -h 50 -l 1000

would result in the histogram begin displayed as

# cmdline: ./cyclictest -q -p 10 -n -h 50 -l 1000
# Histogram
000000 000000
000001 000000
000002 000000
...

thx!
hofrat 


diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 731b4bd..66a68ed 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -942,6 +942,7 @@ static char *policyname(int policy)
 static void process_options (int argc, char *argv[])
 {
 	int error = 0;
+	int i = 0;
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	for (;;) {
@@ -1136,6 +1137,13 @@ static void process_options (int argc, char *argv[])
 		warn("distance is ignored and set to 0, if histogram enabled\n");
 	if (distance == -1)
 		distance = DEFAULT_DISTANCE;
+	if (histogram) {
+		printf("# cmdline:");
+		for (i = 0; i < argc; i++) {
+			printf(" %s", argv[i]);
+		}
+		printf("\n");
+	}
 
 	if (priority < 0 || priority > 99)
 		error = 1;
