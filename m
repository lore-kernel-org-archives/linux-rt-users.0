From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 2/2] add-smp-option-to-svsematest.patch
Date: Sun, 07 Mar 2010 21:48:02 +0100
Message-ID: <20100307204909.626988443@osadl.org>
References: <20100307204800.456744470@osadl.org>
Cc: RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60222 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab0CGV3t (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 16:29:49 -0500
Content-Disposition: inline; filename=add-smp-option-to-svsematest.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add SMP testing option (-S, --smp) to svsematest, same as in
cyclictest.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: rt-tests/src/svsematest/svsematest.c
===================================================================
--- rt-tests.orig/src/svsematest/svsematest.c
+++ rt-tests/src/svsematest/svsematest.c
@@ -248,6 +248,8 @@ static void display_help(void)
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	"-p PRIO  --prio=PRIO       priority\n"
+	"-S       --smp             SMP testing: options -a -t and same priority\n"
+        "                           of all threads\n"
 	"-t       --threads         one thread per available processor\n"
 	"-t [NUM] --threads=NUM     number of threads:\n"
 	"                           without NUM, threads = max_cpus\n"
@@ -263,6 +265,8 @@ static int num_threads = 1;
 static int max_cycles;
 static int interval = 1000;
 static int distance = 500;
+static int smp;
+static int sameprio;
 
 static void process_options (int argc, char *argv[])
 {
@@ -281,16 +285,21 @@ static void process_options (int argc, c
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
 			{"priority", required_argument, NULL, 'p'},
+			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f::i:l:p:t::",
+		int c = getopt_long (argc, argv, "a::b:d:f::i:l:p:St::",
 			long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
 		case 'a':
+			if (smp) {
+				warn("-a ignored due to --smp\n");
+				break;
+			}
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
 				setaffinity = AFFINITY_SPECIFIED;
@@ -317,7 +326,16 @@ static void process_options (int argc, c
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
 		case 'p': priority = atoi(optarg); break;
+		case 'S':
+			smp = 1;
+			num_threads = max_cpus;
+			setaffinity = AFFINITY_USEALL;
+			break;
 		case 't':
+			if (smp) {
+				warn("-t ignored due to --smp\n");
+				break;
+			}
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
 			else if (optind<argc && atoi(argv[optind]))
@@ -347,6 +365,9 @@ static void process_options (int argc, c
 		if (priority < 0 || priority > 99)
 			error = 1;
 
+		if (priority && smp)
+			sameprio = 1;
+
 		tracelimit = thistracelimit;
 	}
 	if (error)
@@ -525,7 +546,7 @@ int main(int argc, char *argv[])
 		}
 		receiver[i].priority = priority;
 		receiver[i].tracelimit = tracelimit;
-		if (priority > 0)
+		if (priority > 1 && !sameprio)
 			priority--;
 		receiver[i].delay.tv_sec = interval / USEC_PER_SEC;
 		receiver[i].delay.tv_nsec = (interval % USEC_PER_SEC) * 1000;

