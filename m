From: Ciprian Barbu <ciprian.barbu@linaro.org>
Subject: [PATCH] rt-tests: hackbench: fix for uninitialized start time
Date: Thu, 12 Dec 2013 16:47:19 +0200
Message-ID: <52A9CC77.20904@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linaro Networking <linaro-networking@linaro.org>
To: Clark Williams <williams@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

While playing around with hackbench I discovered that I would sometimes 
get an enormous time reported, even if the run time would be less than a 
second or so. The problem was that the struct timeval start was not 
initialized until after all children have been created. But if the 
program receives a signal before this is done, the start time is left 
uninitialized.

I propose that in such situations an error message be displayed, like 
the following patch does.

Please let me know if this is acceptable.

Regards,
/Ciprian

---
diff -rupN rt-tests/src/hackbench/hackbench.c 
rt-tests2/src/hackbench/hackbench.c
--- rt-tests/src/hackbench/hackbench.c  2013-12-12 16:27:06.273731063 +0200
+++ rt-tests2/src/hackbench/hackbench.c 2013-12-12 16:24:01.945738814 +0200
@@ -442,6 +442,7 @@ int main(int argc, char *argv[])
     struct timeval start, stop, diff;
     int readyfds[2], wakefds[2];
     char dummy;
+   int timer_started = 0;
     struct sched_param sp;

     process_options (argc, argv);
@@ -490,6 +491,7 @@ int main(int argc, char *argv[])
             }

         gettimeofday(&start, NULL);
+       timer_started = 1;

         /* Kick them off */
         if (write(wakefds[1], &dummy, 1) != 1) {
@@ -509,8 +511,12 @@ int main(int argc, char *argv[])
     gettimeofday(&stop, NULL);

     /* Print time... */
-   timersub(&stop, &start, &diff);
-   printf("Time: %lu.%03lu\n", diff.tv_sec, diff.tv_usec/1000);
+   if (timer_started) {
+       timersub(&stop, &start, &diff);
+       printf("Time: %lu.%03lu\n", diff.tv_sec, diff.tv_usec/1000);
+   } else {
+       fprintf(stderr, "No measurements available\n");
+   }
     free(child_tab);
     exit(0);
  }
