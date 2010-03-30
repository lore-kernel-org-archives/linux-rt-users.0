From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: [PATCH v2] rt-tests: Add option to force timeout to pmqtest
Date: Tue, 30 Mar 2010 16:25:49 +0200
Message-ID: <4BB209ED.80602@osadl.org>
References: <4BB0C273.2040606@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030504050300010600060803"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT-Users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51341 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756202Ab0C3OaY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Mar 2010 10:30:24 -0400
In-Reply-To: <4BB0C273.2040606@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030504050300010600060803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 03/29/2010 05:08 PM, Carsten Emde wrote:
> This patch adds the program pmqtest to the rt-tests suite.
> The test mechanism is the same as in ptsematest, svsematest
> and friends, but it uses message queues to synchronize the
> test threads. To test the - now hopefully fixed - kernel
> problem that occurred when a timeout was specified, the
> -T option is available.
This patch adds the option -f to force a timeout condition of
mq_timedreceive() to pmqtest - only meaningful along with -T.

The call
# pmqtest -Sp99 -i100 -d0 -T1 -f2

will display

#0: ID17791, P99, CPU0, I100; #1: ID17792, P99, CPU0, Cycles 8
#2: ID17793, P99, CPU1, I100; #3: ID17794, P99, CPU1, Cycles 8
#4: ID17795, P99, CPU2, I100; #5: ID17796, P99, CPU2, Cycles 8
#6: ID17797, P99, CPU3, I100; #7: ID17798, P99, CPU3, Cycles 8
#8: ID17799, P99, CPU4, I100; #9: ID17800, P99, CPU4, Cycles 8
#10: ID17801, P99, CPU5, I100; #11: ID17802, P99, CPU5, Cycles 8
#12: ID17803, P99, CPU6, I100; #13: ID17804, P99, CPU6, Cycles 8
#14: ID17805, P99, CPU7, I100; #15: ID17806, P99, CPU7, Cycles 8
#1 -> #0, Min   16, Cur   22, Avg   18, Max   24
#3 -> #2, Min   13, Cur   14, Avg   14, Max   16
#5 -> #4, Min   14, Cur   20, Avg   16, Max   20
#7 -> #6, Min   13, Cur   14, Avg   14, Max   15
#9 -> #8, Min   14, Cur   14, Avg   15, Max   19
#11 -> #10, Min   13, Cur   13, Avg   16, Max   20
#13 -> #12, Min   13, Cur   14, Avg   15, Max   19
#15 -> #14, Min   13, Cur   14, Avg   15, Max   19
etc.

but the next cycle will only continue when the timeout of 2 seconds is
elapsed.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

--------------030504050300010600060803
Content-Type: text/x-patch;
 name="pmqtest-add-forcetimeout-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pmqtest-add-forcetimeout-option.patch"

diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
index 7c886c9..e2ffe77 100644
--- a/src/pmqtest/pmqtest.8
+++ b/src/pmqtest/pmqtest.8
@@ -21,6 +21,9 @@ It is useful to track down unexpected large latencies of a system.
 .B \-d, \-\-distance=DIST
 Set the distance of thread intervals in microseconds (default is 500 us). When  cylictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
 .TP
+.B \-f, \-\-forcetimeout=TO
+Set an artificial delay of the send function to force timeout of the receiver, requires the -T option
+.TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
 .TP
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index f464e20..4e20682 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -77,6 +77,7 @@ struct params {
 	struct timeval sent, received, diff;
 	pthread_t threadid;
 	int timeout;
+	int forcetimeout;
 	mqd_t syncmq, testmq;
 	char recvsyncmsg[MSG_SIZE];
 	char recvtestmsg[MSG_SIZE];
@@ -110,6 +111,16 @@ void *pmqthread(void *param)
 
 	while (!par->shutdown) {
 		if (par->sender) {
+
+			/* Optionally force receiver timeout */
+			if (par->forcetimeout) {
+				struct timespec senddelay;
+				
+				senddelay.tv_sec = par->forcetimeout;
+				senddelay.tv_nsec = 0;
+				nanosleep(&senddelay, NULL);
+			}
+
 			/* Send message: Start of latency measurement ... */
 			gettimeofday(&par->sent, NULL);
 			if (mq_send(par->testmq, testmsg, strlen(testmsg), 1) != 0) {
@@ -148,11 +159,17 @@ void *pmqthread(void *param)
 			if (par->timeout) {
 				clock_gettime(CLOCK_REALTIME, &ts);
 				ts.tv_sec += par->timeout;
-				if (mq_timedreceive(par->testmq, par->recvtestmsg, MSG_SIZE, NULL, &ts) !=
-				    strlen(testmsg)) {
-					perror("could not receive test message");
-					par->shutdown = 1;
+				do {
+					if (mq_timedreceive(par->testmq, par->recvtestmsg,
+					    MSG_SIZE, NULL, &ts) != strlen(testmsg)) {
+						if (!par->forcetimeout || errno != ETIMEDOUT) {
+							perror("could not receive test message");
+							par->shutdown = 1;
+						}
+					} else
+						break;
 				}
+				while (1);
 			} else {
 				if (mq_receive(par->testmq, par->recvtestmsg, MSG_SIZE, NULL) !=
 				    strlen(testmsg)) {
@@ -224,6 +241,7 @@ static void display_help(void)
 	"                           with NUM pin all threads to the processor NUM\n"
 	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	"-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
 	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	"-p PRIO  --prio=PRIO       priority\n"
@@ -250,6 +268,7 @@ static int distance = 500;
 static int smp;
 static int sameprio;
 static int timeout;
+static int forcetimeout;
 
 static void process_options (int argc, char *argv[])
 {
@@ -263,6 +282,7 @@ static void process_options (int argc, char *argv[])
 			{"affinity", optional_argument, NULL, 'a'},
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"distance", required_argument, NULL, 'd'},
+			{"forcetimeout", required_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
 			{"priority", required_argument, NULL, 'p'},
@@ -272,7 +292,7 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:i:l:p:St::T:",
+		int c = getopt_long (argc, argv, "a::b:d:f:i:l:p:St::T:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -294,6 +314,7 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'b': tracelimit = atoi(optarg); break;
 		case 'd': distance = atoi(optarg); break;
+		case 'f': forcetimeout = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'l': max_cycles = atoi(optarg); break;
 		case 'p': priority = atoi(optarg); break;
@@ -338,6 +359,9 @@ static void process_options (int argc, char *argv[])
 	if (num_threads < 1)
 		error = 1;
 
+	if (forcetimeout && !timeout)
+		error = 1;
+ 
 	if (priority && smp)
 		sameprio = 1;
 
@@ -426,6 +450,7 @@ int main(int argc, char *argv[])
 		receiver[i].sender = 0;
 		receiver[i].neighbor = &sender[i];
 		receiver[i].timeout = timeout;
+		receiver[i].forcetimeout = forcetimeout;
 		pthread_create(&receiver[i].threadid, NULL, pmqthread, &receiver[i]);
 		memcpy(&sender[i], &receiver[i], sizeof(receiver[0]));
 		sender[i].sender = 1;

--------------030504050300010600060803--
