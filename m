From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH] rt-tests: Add timeout count to pmqtest's output
Date: Thu, 01 Apr 2010 02:22:10 +0200
Message-ID: <4BB3E732.60508@osadl.org>
References: <4BB0C273.2040606@osadl.org> <4BB209ED.80602@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010200050209050905010908"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT-Users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:45713 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193Ab0DAAa1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Mar 2010 20:30:27 -0400
In-Reply-To: <4BB209ED.80602@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010200050209050905010908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/30/2010 04:25 PM, Carsten Emde wrote:
> On 03/29/2010 05:08 PM, Carsten Emde wrote:
>> This patch adds the program pmqtest to the rt-tests suite.
>> The test mechanism is the same as in ptsematest, svsematest
>> and friends, but it uses message queues to synchronize the
>> test threads. To test the - now hopefully fixed - kernel
>> problem that occurred when a timeout was specified, the
>> -T option is available.
> This patch adds the option -f to force a timeout condition of
> mq_timedreceive() to pmqtest - only meaningful along with -T.
This patch adds the timeout count (TO) to the output to prove
that the timeout of the mq_timedreceive() call, in fact, works
as expected.

The additional options -T1 -f2 will cause, for example, the display
to be updated once per second with the lines:

#0: ID24739, P99, CPU0, I100; #1: ID24740, P99, CPU0, TO 0, Cycles 2
#0: ID24739, P99, CPU0, I100; #1: ID24740, P99, CPU0, TO 1, Cycles 2
#0: ID24739, P99, CPU0, I100; #1: ID24740, P99, CPU0, TO 0, Cycles 3
#0: ID24739, P99, CPU0, I100; #1: ID24740, P99, CPU0, TO 1, Cycles 3
#0: ID24739, P99, CPU0, I100; #1: ID24740, P99, CPU0, TO 1, Cycles 4
#0: ID24739, P99, CPU0, I100; #1: ID24740, P99, CPU0, TO 0, Cycles 5
#0: ID24739, P99, CPU0, I100; #1: ID24740, P99, CPU0, TO 1, Cycles 5

The related kernel patches to make the mq_* functions RT compliant
are on their way.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>


--------------010200050209050905010908
Content-Type: text/x-patch;
 name="pmqtest-add-timeout-display.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pmqtest-add-timeout-display.patch"

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 5c7a8da..42715b6 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -78,6 +78,7 @@ struct params {
 	pthread_t threadid;
 	int timeout;
 	int forcetimeout;
+	int timeoutcount;
 	mqd_t syncmq, testmq;
 	char recvsyncmsg[MSG_SIZE];
 	char recvtestmsg[MSG_SIZE];
@@ -133,21 +134,10 @@ void *pmqthread(void *param)
 			if (mustgetcpu)
 				par->cpu = get_cpu();
 			/* Wait until receiver ready */
-			if (par->timeout) {
-				clock_gettime(CLOCK_REALTIME, &ts);
-				ts.tv_sec += par->timeout;
-
-				if (mq_timedreceive(par->syncmq, par->recvsyncmsg, MSG_SIZE, NULL, &ts)
-				    != strlen(syncmsg)) {
-					fprintf(stderr, "could not receive sync message\n");
-					par->shutdown = 1;
-				}
-			} else {
-				if (mq_receive(par->syncmq, par->recvsyncmsg, MSG_SIZE, NULL) !=
-				    strlen(syncmsg)) {
-					perror("could not receive sync message");
-					par->shutdown = 1;
-				}
+			if (mq_receive(par->syncmq, par->recvsyncmsg, MSG_SIZE, NULL) !=
+			    strlen(syncmsg)) {
+				perror("could not receive sync message");
+				par->shutdown = 1;
 			}
 			if (!par->shutdown && strcmp(syncmsg, par->recvsyncmsg)) {
 				fprintf(stderr, "ERROR: Sync message mismatch detected\n");
@@ -158,6 +148,7 @@ void *pmqthread(void *param)
 			/* Receiver */
 			if (par->timeout) {
 				clock_gettime(CLOCK_REALTIME, &ts);
+				par->timeoutcount = 0;
 				ts.tv_sec += par->timeout;
 				do {
 					if (mq_timedreceive(par->testmq, par->recvtestmsg,
@@ -165,6 +156,12 @@ void *pmqthread(void *param)
 						if (!par->forcetimeout || errno != ETIMEDOUT) {
 							perror("could not receive test message");
 							par->shutdown = 1;
+							break;
+						}
+						if (errno == ETIMEDOUT) {
+							par->timeoutcount++;
+							clock_gettime(CLOCK_REALTIME, &ts);
+							ts.tv_sec += par->timeout;
 						}
 					} else
 						break;
@@ -381,10 +378,13 @@ int main(int argc, char *argv[])
 {
 	int i;
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
-	int oldsamples = 1;
 	struct params *receiver = NULL;
 	struct params *sender = NULL;
 	sigset_t sigset;
+	int oldsamples = INT_MAX;
+	int oldtimeoutcount = INT_MAX;
+	int first = 1;
+	int errorlines = 0;
 	struct timespec maindelay;
 	int oflag = O_CREAT|O_RDWR;
 	struct mq_attr mqstat;
@@ -404,6 +404,11 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	sigemptyset(&sigset);
+	sigaddset(&sigset, SIGTERM);
+	sigaddset(&sigset, SIGINT);
+	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
 
@@ -461,20 +466,33 @@ int main(int argc, char *argv[])
 	maindelay.tv_sec = 0;
 	maindelay.tv_nsec = 50000000; /* 50 ms */
 
-	while (!shutdown) {
-		int printed;
-		int errorlines = 0;
+	sigemptyset(&sigset);
+	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
-		for (i = 0; i < num_threads; i++)
-			shutdown |= receiver[i].shutdown | sender[i].shutdown;
+	do {
+		int newsamples = 0, newtimeoutcount = 0;
+		int minsamples = INT_MAX;
+
+		for (i = 0; i < num_threads; i++) {
+			newsamples += receiver[i].samples;
+			newtimeoutcount += receiver[i].timeoutcount;
+			if (receiver[i].samples < minsamples)
+				minsamples = receiver[i].samples;
+		}
+
+		if (minsamples > 1 && (shutdown || newsamples > oldsamples ||
+			newtimeoutcount > oldtimeoutcount)) {
+
+			if (!first)
+				printf("\033[%dA", num_threads*2 + errorlines);
+			first = 0;
 
-		if (receiver[0].samples > oldsamples || shutdown) {
 			for (i = 0; i < num_threads; i++) {
-				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
+				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, TO %d, Cycles %d   \n",
 				    i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
 				    receiver[i].delay.tv_nsec / 1000,
 				    i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
-				    sender[i].samples);
+				    receiver[i].timeoutcount, sender[i].samples);
 			}
 			for (i = 0; i < num_threads; i++) {
 				printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
@@ -493,23 +511,26 @@ int main(int argc, char *argv[])
 					receiver[i].error[0] = '\0';
 				}
 			}
-			printed = 1;
-		} else
-			printed = 0;
-
-		sigemptyset(&sigset);
-		sigaddset(&sigset, SIGTERM);
-		sigaddset(&sigset, SIGINT);
-		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+		} else {
+			if (minsamples < 1)
+				printf("Collecting ...\n\033[1A");
+		}
+		
+		fflush(NULL);
+
+		oldsamples = 0;
+		oldtimeoutcount = 0;
+		for (i = 0; i < num_threads; i++) {
+			oldsamples += receiver[i].samples;
+			oldtimeoutcount += receiver[i].timeoutcount;
+		}
 
 		nanosleep(&maindelay, NULL);
 
-		sigemptyset(&sigset);
-		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+		for (i = 0; i < num_threads; i++)
+			shutdown |= receiver[i].shutdown | sender[i].shutdown;
 
-		if (printed && !shutdown)
-			printf("\033[%dA", num_threads*2 + errorlines);
-	}
+	} while (!shutdown);
 
 	for (i = 0; i < num_threads; i++) {
 		receiver[i].shutdown = 1;
@@ -524,12 +545,18 @@ int main(int argc, char *argv[])
 	}
 	nanosleep(&maindelay, NULL);
 	for (i = 0; i < num_threads; i++) {
+		char mqname[16];
+
 		mq_close(receiver[i].syncmq);
+		sprintf(mqname, SYNCMQ_NAME, i);
+		mq_unlink(mqname);
+
 		mq_close(receiver[i].testmq);
+		sprintf(mqname, TESTMQ_NAME, i);
+		mq_unlink(mqname);
 	}
 
 	nomem:
 
 	return 0;
 }
--------------010200050209050905010908--
