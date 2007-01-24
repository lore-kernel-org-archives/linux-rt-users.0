From: David A Sperry <David_A_Sperry@raytheon.com>
Subject: Re: Out of order timings of gettimeofday_us() Part 1
Date: Wed, 24 Jan 2007 07:41:00 -0500
Message-ID: <OF3F07179B.7C6255FB-ON8525726D.0043F717-8525726D.0045AC7A@mck.us.ray.com>
References: <44506.128.165.0.81.1169591628.squirrel@webmail.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: systemtap@sourceware.org, linux-rt-users@vger.kernel.org
To: ndebard@lanl.gov
Return-path: <systemtap-return-5409-gls-systemtap=m.gmane.org@sourceware.org>
In-Reply-To: <44506.128.165.0.81.1169591628.squirrel@webmail.lanl.gov>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
List-Id: linux-rt-users.vger.kernel.org

I have seen similar behavior with some of my scripts. I thought
it was due to my lack of kernel systemTap knowledge.
The first example I have is a modification of top.stp that looks
at how long real-time threads are running sorted by priority
(We use this for doing rate monotonic scheduling analysis). I
get similar results on a different SMP boxes, one box is running
RHEL4U2 with a 2.6.16-rt22 kernel and the other one running fc6
with a 2.6.19.1-rt15 kernel. The script records the time
statistics between scheduler.cpu_on and scheduler.cpu_off

The output of the script looks like:

-----------------------------------------------------------------
Time = 36 seconds
                              | prio  |sched | Time on CPU (usec)|
Name                pid   tid |max min| Hz   | sum/s  ave   max  |
posix_cpu_timer      15    15  99  99    250    604     2     6
posix_cpu_timer       3     3  99  99    250    587     2     8
IRQ 16              389   389  95  95     61   2190    35    44
IRQ 15              323   323  95  95     42    767    18    40
IRQ 18             2941  2941  95  95      1      9     5     8
ktg3_timer         1381  1381  91  91      2      9     4     6
softirq-net-rx/       7     7  90  90      1     23    14    22
softirq-timer/0       5     5  53  50    250  -6369   -25     3
subscriber         3813  3813  53  53      1      6     6    12
publisher          3819  3819  53  53      0     23    69    69
subscriber         3813  3815  51  51      1     33    20    30
publisher          3819  3821  51  51      1     31    23    30
softirq-timer/1      17    17  50  50    250  -7229   -28   469
softirq-tasklet      21    21  50  50     66   2716    40    55
softirq-tasklet       9     9  50  50      1      3     3     5
-----------------------------------------------------------------

The softirq-timer/x typically has a negative execution time. Any thoughts?

Thanks
Dave


Script follows:

#!/usr/bin/env stap
#
# This script continuously lists the history of the top 30 real-time
priority
# threads on the system
#
global tids      /* long array of active thread IDs */
global pids      /* long array of active process IDs index by tid */
global rtPrios   /* statistical array of  RT Prios measured index by tid */
global names     /* string array of process names indexed by tid */
global compTimes /* statistical array of thread "on cpu" run times */
                 /* indexed by tid */
global compStrt  /* long array containing "on cpu" start time indexed by
tid */
global validStart /* long array indicating threads being timed indexed by
tid */

/* globals used for printing */
global prioSort    /* long array of maximum priorities each thread has seen
*/
global startTime   /* long when measurement started */
global lastPrint_s /* long time of last print */

/* print top rtPrios every 3 seconds */
probe timer.ms(3000) {
      print_top ()
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
     c = task_current();
     prio = 0-(1+task_prio(c));

     if (prio > 1) /* capture only RT priorities */
     {
       tid_ = tid();
       t=gettimeofday_us();

       /* store current priority in stat array */
       rtPrios[tid_] <<< prio

       /* store current time in long array */
       compStrt[tid_] = t;

       /* If thread is not in database, add it */
       if (tids[tid_]!=1)
       {
         tids[tid_]=1
         /* store off useful info about thread once */
         names[tid_] = execname();
         pids[tid_]=pid();
       }
       /* since there is priority inheritance it is possible
        * for a thread to start non-realtime and end real-time
        * right now only count threads that started real-time
       */
       validStart[tid_] = 1;

     }/* if (prio > 1) */

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
     tid_=tid();
     /* to reduce load, only look for threads we've seen before */
     if (tids[tid_]==1)
     {
        /* check we are timing the thread */
        if(validStart[tid_] == 1)
        {
           t=gettimeofday_us();
           deltaT = t - compStrt[tid_];
           compTimes[tid_] <<< deltaT; /* collect time on cpu */
           validStart[tid_] = 0; /* done timing this action */
        }
     }

}

/* function print_top()
 *
 *  Prints to standard out data collected since last print
 *
 * Arguments:
 *  none
 */
function print_top () {
      cnt=0;
    /* sort by maximum priority recorded for thread */
    foreach ([tid_] in tids+)
    {
       prioSort[tid_]=@max(rtPrios[tid_])
    }

    /* compute elapse time since last call */
    now_s=gettimeofday_s();
    timeSinceLastPrint = now_s - lastPrint_s;
    lastPrint_s = now_s;

    /* print the big table header */
    printf ("Time = %d seconds\n", now_s - startTime);
    printf ("                              | prio  |sched | Time on CPU
(usec)|\n");
    printf ("Name                pid   tid |max min| Hz   | sum/s  ave
max  |\n");

    /* print each row sorted by highest to lowest */
    foreach ([tid_] in prioSort-)
    {
        /* print a line if there is valid data */
        if (@count(compTimes[tid_]) > 0)
        {
          printf("%-16s  %5d %5d %3d %3d %6d %6d %5d %5d\n",
          names[tid_],
          pids[tid_],
          tid_,
          @max(rtPrios[tid_]),
          @min(rtPrios[tid_]),
          @count(compTimes[tid_])/timeSinceLastPrint,
          @sum(compTimes[tid_])/timeSinceLastPrint,
          @avg(compTimes[tid_]),
          @max(compTimes[tid_])
          );
          cnt++;
      }
        if (cnt == 60)
          break
    }/* foreach */


printf("-----------------------------------------------------------------\n")

      /* reset arrays */
      delete compTimes
    delete tids
    delete rtPrios
    delete prioSort
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
  printf ("starting rtPrio TOP\n")
  startTime=gettimeofday_s();
  lastPrint_s=startTime;
}

/* probe end
 * last probe to be fired upon normal script exit
*/
probe end
{
   printf ("done\n");
}




                                                                           
                                                                           
             "Nathan A.                                                    
             Debardeleben"                                                 
             <ndebard@lanl.gov                                          To 
             >                         systemtap@sourceware.org            
             Sent by:                                                   cc 
             systemtap-owner@s                                             
             ourceware.org                                         Subject 
                                       Out of order timings of             
                                       gettimeofday_us()                   
             01/23/2007 05:33                                              
             PM                                                            
                                                                           
                                                                           
             Please respond to                                             
             ndebard@lanl.gov                                              
                                                                           
                                                                           
                                                                           




I have a very simple script which seems to demonstrate time values coming
out of gettimeofday_us() being out of order.  I believe this function I am
probing is extremely fast - but, regardless, it shouldn't take negative
time to complete. :)

Here's the probe:

probe kernel.function("cbe_system_reset_exception") {
   printf(" IN: %d\n", gettimeofday_us());
}

probe kernel.function("cbe_system_reset_exception").return {
   printf("OUT: %d\n", gettimeofday_us());
}

Here's some output from it:

 IN: 1169591399721428
OUT: 1169591399721437
 IN: 1169591399721484
OUT: 1169591399721492
 IN: 1169591399722383
OUT: 1169591399722298 **** ERROR - NOTICE this is before the above "IN"
line
 IN: 1169591399723387
OUT: 1169591399723302 **** ALSO OUT OF ORDER!
 . . .

I annotated the above line where I see an error.  This happens very often
with this probe.

Is the us() timing just too fine grained?  If it's acting like this here I
question its values in other places.

Please advise.
