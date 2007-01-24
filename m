From: David A Sperry <David_A_Sperry@raytheon.com>
Subject: Re: Out of order timings of gettimeofday_us() Part 2
Date: Wed, 24 Jan 2007 09:01:40 -0500
Message-ID: <OF7779C460.3A29EA68-ON8525726D.004A0578-8525726D.004D0F34@mck.us.ray.com>
References: <44506.128.165.0.81.1169591628.squirrel@webmail.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ndebard@lanl.gov
To: systemtap@sourceware.org, linux-rt-users@vger.kernel.org
Return-path: <systemtap-return-5410-gls-systemtap=m.gmane.org@sourceware.org>
In-Reply-To: <44506.128.165.0.81.1169591628.squirrel@webmail.lanl.gov>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
List-Id: linux-rt-users.vger.kernel.org

Hi

I also have a second script that shows time going backwards.
This script is used to find priority inversions and unexpected
priority inheritance coupling in commercial middleware we are
using. The program under test loops though a test that
should take less than 600 usec. Roughly 1 out of 1,000,000
iterations the execution time takes longer than 600uS.
The script traces the scheduler and syscalls between the two
timing points and prints the trace out if the time exceeds
600 usec. During some of the dumps, negative time steps are
recorded and the timestamps are also shown to be tied to a CPU.
In the example below the softirq-timer/x seems to adjust time
stamps on a particular CPU (line 10,13 and 46,49) this makes
understanding the time sequence difficult. The output of
the script looks as follows:
(sorry about the csv formatting)

Any thoughts?

Dave

event,time, tid,  prio, CPU,  event,      name, Trip=982288
0,    0,    7,    90,   0,    cpu_off,    softirq-net-rx/
1,    4,    10902,53,   1,    sys_sigreturn,    publisher
2,    7,    10899,52,   0,    cpu_on,     subscriber
3,    12,   10902,53,   1,    sys_gettimeofday, publisher
4,    19,   10902,53,   1,    sys_gettimeofday, publisher
5,    22,   10899,52,   0,    sys_socketcall,   subscriber
6,    26,   10899,52,   0,    sys_recvfrom,     subscriber
7,    31,   10902,53,   1,    sys_socketcall,   publisher
8,    34,   10899,52,   0,    cpu_off,    subscriber
9,    39,   10902,53,   1,    sys_sendmsg,      publisher
10,   42,   5,    50,   0,    cpu_on,     softirq-timer/0 <---
11,   201,  10902,53,   1,    cpu_off,    publisher
12,   210,  19,   90,   1,    cpu_on,     softirq-net-rx/
13,   183,  5,    50,   0,    cpu_off,    softirq-timer/0 <--- Backwards
time  Adj
14,   191,  10902,53,   0,    cpu_on,     publisher
15,   233,  19,   90,   1,    cpu_off,    softirq-net-rx/
16,   241,  10906,52,   1,    cpu_on,     publisher
17,   212,  10902,53,   0,    sys_gettimeofday, publisher
18,   249,  10906,52,   1,    sys_gettimeofday, publisher
19,   220,  10902,53,   0,    sys_clock_gettime,      publisher
20,   258,  10906,52,   1,    sys_socketcall,   publisher
21,   229,  10902,53,   0,    sys_futex,  publisher
22,   266,  10906,52,   1,    sys_recvfrom,     publisher
23,   239,  10902,53,   0,    cpu_off,    publisher
24,   276,  10906,52,   1,    cpu_off,    publisher
25,   247,  10899,52,   0,    cpu_on,     subscriber
26,   284,  0,    -41,  1,    cpu_on,     swapper
27,   256,  10899,52,   0,    sys_gettimeofday, subscriber
28,   270,  10899,52,   0,    sys_gettimeofday, subscriber
29,   275,  10899,52,   0,    sys_gettimeofday, subscriber
30,   282,  10899,52,   0,    cpu_off,    subscriber
31,   286,  2933, 95,   0,    cpu_on,     IRQ 18
32,   327,  0,    -41,  1,    cpu->idle,  swapper
33,   298,  2933, 95,   0,    cpu_off,    IRQ 18
34,   336,  10899,52,   1,    cpu_on,     subscriber
35,   307,  7,    90,   0,    cpu_on,     softirq-net-rx/
36,   314,  7,    90,   0,    cpu_off,    softirq-net-rx/
37,   350,  10899,52,   1,    sys_socketcall,   subscriber
38,   321,  5180, -16,  0,    cpu_on,     firefox-bin
39,   358,  10899,52,   1,    sys_sendmsg,      subscriber
40,   333,  5180, -16,  0,    sys_gettimeofday, firefox-bin
41,   369,  10899,52,   1,    cpu_off,    subscriber
42,   377,  15,   99,   1,    cpu_on,     posix_cpu_timer
43,   350,  5180, -16,  0,    cpu_off,    firefox-bin
44,   387,  15,   99,   1,    cpu_off,    posix_cpu_timer
45,   358,  10899,52,   0,    cpu_on,     subscriber
46,   395,  17,   50,   1,    cpu_on,     softirq-timer/1 <--
47,   371,  10899,52,   0,    cpu_off,    subscriber
48,   376,  7,    90,   0,    cpu_on,     softirq-net-rx/
49,   381,  17,   50,   1,    cpu_off,    softirq-timer/1 <-- backwards
50,   388,  10899,52,   1,    cpu_on,     subscriber
51,   398,  7,    90,   0,    cpu_off,    softirq-net-rx/
52,   405,  10906,52,   0,    cpu_on,     publisher
53,   411,  10906,52,   0,    sys_gettimeofday, publisher
54,   413,  10899,52,   1,    sys_socketcall,   subscriber
55,   418,  10899,52,   1,    sys_recvfrom,     subscriber
56,   423,  10899,52,   1,    sys_gettimeofday, subscriber
57,   430,  10906,52,   0,    sys_gettimeofday, publisher
58,   433,  10899,52,   1,    sys_socketcall,   subscriber
59,   439,  10906,52,   0,    sys_futex,  publisher
60,   442,  10899,52,   1,    sys_recvfrom,     subscriber
61,   447,  10906,52,   0,    cpu_off,    publisher
62,   453,  10902,53,   0,    cpu_on,     publisher
63,   459,  10899,52,   1,    cpu_off,    subscriber
64,   466,  10906,52,   1,    cpu_on,     publisher
65,   474,  10902,53,   0,    cpu_off,    publisher
66,   480,  5180, -16,  0,    cpu_on,     firefox-bin
67,   487,  10906,52,   1,    cpu_off,    publisher
68,   494,  10902,53,   1,    cpu_on,     publisher
69,   500,  5180, -16,  0,    cpu_off,    firefox-bin
70,   503,  10902,53,   1,    sys_futex,  publisher
71,   508,  2933, 95,   0,    cpu_on,     IRQ 18
72,   511,  10902,53,   1,    cpu_off,    publisher
73,   518,  2933, 95,   0,    cpu_off,    IRQ 18
74,   520,  10906,53,   1,    cpu_on,     publisher
75,   526,  7,    90,   0,    cpu_on,     softirq-net-rx/
76,   529,  10906,52,   1,    cpu_off,    publisher
77,   535,  10902,53,   1,    cpu_on,     publisher
78,   540,  10902,53,   1,    cpu_off,    publisher
79,   544,  10906,52,   1,    cpu_on,     publisher
80,   548,  10906,52,   1,    sys_futex,  publisher
81,   553,  7,    90,   0,    cpu_off,    softirq-net-rx/
82,   556,  10906,52,   1,    cpu_off,    publisher
83,   561,  5180, -16,  0,    cpu_on,     firefox-bin
84,   564,  10902,53,   1,    cpu_on,     publisher
85,   573,  5180, -16,  0,    cpu_off,    firefox-bin
86,   579,  10906,52,   0,    cpu_on,     publisher
87,   585,  10902,53,   1,    cpu_off,    publisher
88,   590,  10916,-11,  1,    cpu_on,     systemtap/1
89,   596,  10916,-11,  1,    cpu_off,    systemtap/1
90,   600,  10902,53,   1,    cpu_on,     publisher
91,   605,  10906,52,   0,    sys_socketcall,   publisher
92,   608,  10902,53,   1,    sys_gettimeofday, publisher
93,   613,  10906,52,   0,    sys_recvfrom,     publisher
94,   616,  10902,53,   1,    sys_futex,  publisher
95,   621,  10906,52,   0,    cpu_off,    publisher
96,   624,  10902,53,   1,    sys_tgkill, publisher
97,   630,  5180, -16,  0,    cpu_on,     firefox-bin


The script:

#!/usr/bin/env stap
#
# A script to detect why some real-time action took too long
# This script records all thread schedulings in a buffer AND monitors
# the time between signal 36 and 37. If the time between 36 and 37 is less
# than 1 millisec the buffer is cleared. If the time is >1 millisecond the
# buffer is printed out and then cleared.
#
global todHist
global tidHist
global eventHist
global names
global cpuIdHist
global prioHist

global eventCnt, isCollecting, collectionStart
global completedTrips



/* capture signals to mark the start and end of an event */
probe signal.send
{
      /*
       * available variables on this probe:
       * pid_name, sig, sig_name, sig_pid
       */
       t=gettimeofday_us();

         /* start of timed event */
       if (sig == 36 && isCollecting == 0)
       {
         collectionStart=t;
         isCollecting = 1;
       }

       /* end of timed event */
       if (sig == 37 && isCollecting == 1)
       {
         isCollecting = 0;
         if (t - collectionStart > 600 || completedTrips == 1001)
         {
            printTrace();
         }
         clearHistory();
         completedTrips++;
       }

}

probe kernel.function("sys_*") {

       logEvent (probefunc());
}



/* probe scheduler.cpu_on
 *
 *  Fires when a process is beginning execution on a cpu.
 *
 * Context:
 *  The resuming process.
 *
 * Arguments:
 *  task_prev - the process that was previously running on this cpu.
 *  idle - boolean indicating whether current is the idle process
 */


 probe scheduler.cpu_on
{
     /*
      * available variables on this probe:
      * idle, task_prev
      */
     /* capture context to find priority */
      logEvent ("cpu_on");


}/* probe scheduler.cpu_on */



/* probe scheduler.cpu_off
 *
 *  Fires when a process is about to stop running on a cpu.
 *
 * Context:
 *  The process leaving the cpu.
 *
 * Arguments:
 *  task_prev - the process leaving the cpu (same as current)
 *  task_next - the process replacing current
 *  idle - boolean indicating whether current is the idle process
 */
probe scheduler.cpu_off
{
     /*
     * available variables on this probe:
     * idle, task_next, task_prev
     */
      if (idle)
      {
          logEvent ("cpu->idle")
      }
      else
      {
         logEvent ("cpu_off");
      }

}


function logEvent (eventName)
{
       if( isCollecting == 1 )
       {
       tod=gettimeofday_us();
       tid_ = tid();

       /* record items of interest */
       todHist[eventCnt]=tod;
       tidHist[eventCnt]=tid_;
       eventHist[eventCnt]=eventName;
       names[eventCnt]=execname();
       cpuIdHist[eventCnt]=cpu();
       c = task_current();
       prioHist[eventCnt] = 0-(1+task_prio(c));
       eventCnt++;
       }
}

function clearHistory ()
{
       delete todHist;
       delete tidHist;
       delete eventHist;
       delete cpuIdHist;
       delete names;
       delete prioHist;
       eventCnt=0;
}

function printTrace()
{


      printf("event,time,tid,prio,CPU,event,name,Trip=%d\n",completedTrips)
      foreach ([event] in eventHist)
      {
         printf ("%d,%d,%d,%d,%d,%s,%s\n",
                event,
              todHist[event]-todHist[0],
              tidHist[event],
              prioHist[event],
                    cpuIdHist[event],
              eventHist[event],
              names[event]
            );
       }

}

/* probe begin
 *
 *  Fires when script starts
 *
 * Context:
 *  The process leaving the cpu.
 *
 * Arguments:
 * command line ints and strings available here
 */
probe begin
{
printf ("starting\n");
eventCnt=0
isCollecting=0
}

/* probe end
 * last probe to be fired upon normal script exit
*/
probe end
{
   printTrace()
   printf ("done\n");
}


systemtap-owner@sourceware.org wrote on 01/23/2007 05:33:48 PM:

> I have a very simple script which seems to demonstrate time values coming
> out of gettimeofday_us() being out of order.  I believe this function I
am
> probing is extremely fast - but, regardless, it shouldn't take negative
> time to complete. :)
>
> Here's the probe:
>
> probe kernel.function("cbe_system_reset_exception") {
>    printf(" IN: %d\n", gettimeofday_us());
> }
>
> probe kernel.function("cbe_system_reset_exception").return {
>    printf("OUT: %d\n", gettimeofday_us());
> }
>
> Here's some output from it:
>
>  IN: 1169591399721428
> OUT: 1169591399721437
>  IN: 1169591399721484
> OUT: 1169591399721492
>  IN: 1169591399722383
> OUT: 1169591399722298 **** ERROR - NOTICE this is before the above "IN"
line
>  IN: 1169591399723387
> OUT: 1169591399723302 **** ALSO OUT OF ORDER!
>  . . .
>
> I annotated the above line where I see an error.  This happens very often
> with this probe.
>
> Is the us() timing just too fine grained?  If it's acting like this here
I
> question its values in other places.
>
> Please advise.
