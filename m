From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: RE: [PATCH 1/2][RFC] Add README_cyclicload
Date: Mon, 13 Aug 2012 08:52:10 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F1907A9E244@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1343797643-10208-1-git-send-email-Priyanka.Jain@freescale.com>
	<AC83832D6324604BB08FAE5A33553F1907A926BA@039-SN2MPN1-012.039d.mgd.msft.net>
 <20120806085929.6c5f8cd7@redhat.com>
 <AC83832D6324604BB08FAE5A33553F1907A94309@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Srivastava Rajan-B34330 <B34330@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Jain Priyanka-B32167 <B32167@freescale.com>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:11342
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752655Ab2HMIwP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Aug 2012 04:52:15 -0400
In-Reply-To: <AC83832D6324604BB08FAE5A33553F1907A94309@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Clark,

Did you have the chance to test the patch.

Thanks
Priyanka

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Jain Priyanka-B32167
Sent: Tuesday, August 07, 2012 9:32 AM
To: Clark Williams
Cc: linux-rt-users@vger.kernel.org; dvhart@linux.intel.com; rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330; Aggrwal Poonam-B10812
Subject: RE: [PATCH 1/2][RFC] Add README_cyclicload

Thanks Clark

Waiting for the results at your end.


Regards
Priyanka

-----Original Message-----
From: Clark Williams [mailto:williams@redhat.com] 
Sent: Monday, August 06, 2012 7:29 PM
To: Jain Priyanka-B32167
Cc: linux-rt-users@vger.kernel.org; dvhart@linux.intel.com; rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330; Aggrwal Poonam-B10812
Subject: Re: [PATCH 1/2][RFC] Add README_cyclicload

Priyanka,

For some reason all of us that work on rt-tests were busy last week.
I'll apply these patches and try out cyclicload this week.

Clark

On Mon, 6 Aug 2012 04:00:15 +0000
Jain Priyanka-B32167 <B32167@freescale.com> wrote:

> Hi,
> 
> Waiting for the comments on this tool.
> 
> Thanks
> Priyanka
> 
> -----Original Message-----
> From: Jain Priyanka-B32167
> Sent: Wednesday, August 01, 2012 10:37 AM
> To: linux-rt-users@vger.kernel.org; williams@redhat.com; 
> dvhart@linux.intel.com
> Cc: rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330; 
> Aggrwal Poonam-B10812; Jain Priyanka-B32167
> Subject: [PATCH 1/2][RFC] Add README_cyclicload
> 
> Cyclicload program is designed to simulate load at regular intervals in form of one or two threads.
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> ---
>  src/cyclictest/README_cyclicload |  147 
> ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 147 insertions(+), 0 deletions(-)  create mode 
> 100644 src/cyclictest/README_cyclicload
> 
> diff --git a/src/cyclictest/README_cyclicload 
> b/src/cyclictest/README_cyclicload
> new file mode 100644
> index 0000000..f1e99bf
> --- /dev/null
> +++ b/src/cyclictest/README_cyclicload
> @@ -0,0 +1,147 @@
> +DESCRIPTION
> +-------------
> +
> +The cyclicload program is developed above existing cyclictest application.
> +It is basically designed to simulate specified load at regular 
> +intervals in addition to cyclictest functionality.
> +It can simulate one or two load threads.
> +
> +
> +Why it is required?
> +---------------------
> +It is required to test system performance under a specified load 
> +along with tracking latency of simulated load thread.
> +
> +
> +Example use case
> +--------------------
> +For products like LTE, L2 layer runs in form of two threads.
> +-MAC layer thread runs at highest RT priority producing a fixed load 
> +at regular intervals and -second thread run at lower RT priority or 
> +in non-rt priority  producing some load in each interval depending 
> +upon availability of CPU.
> +Requirement is to test system under this load as well as to track 
> +latency of highest priority RT thread which is MAC thread in example 
> +usecase.
> +
> +
> +What does it do?
> +------------------
> +It creates one or two load generating thread/s.
> +1)load1 thread (timer thread)
> +2)load2 thread
> +priority, nice value, load % as input via command line
> +
> +-cyclictest funcationality like latency measurement
> +
> +
> +How does it work
> +-----------------
> +It uses generate_load loop function to simualte load.
> +First it caliberate required loop_count per unit time per CPU.
> +It stores this data in some file.
> +For subsequent runs, it uses this caliberated data to generate load 
> +if form of one or two threads .
> +It keeps on tracking the latency of RT thread.
> +More in Design Overview section.
> +
> +
> +Recommended Settings
> +----------------------
> +-First run is recommended to be run with no or least load for accuracy.
> +-should be run with sudo or root permission.
> +-caliberation routine produces calinerate_ount file in runnign directory.
> +	If one don't have permission in that dir, path should be changed in
> +	FILENAME or one can exploit shared memory method.
> +-Atleast one thread should be of RT priority. This thread takes priority of
> +	cyclictest as its priority.
> +-cyclictest applcication should be run with SCHED_OTHER policy.
> +-recommended to run in quiet mode (-q) in background.
> +TODO: add option to take filepath from cmd line
> +
> +
> +Cmd line usage/examples
> +------------------------
> +New command line arguments:
> + "-x       --load_t1         load in percentage for t1 thread\n"
> + "-X       --load_t2         load in percentage for t2 thread\n"
> + "-z       --priority_t2     priority of t2 thread\n"
> + "-Z       --nice_t2         nice value of t2 thread\n"
> +
> +If both load_t1 and load_t2 are zero, it behaves as default 
> +cyclictest application
> +
> +For uniprocessor:
> +	#sudo ./cyclictest -p 99 -c 1 -d 0 -x 40 -X 30 -q -D 600&
> +
> +For multiprocessor:
> +	#sudo ./cyclcitest -p 99 -c 1 -d 0 -x 40 -X 30 -q -D 600 -S&
> +
> +
> +
> +Future Enhancements
> +-------------------
> +Maintain statistics of average load produces.
> +invalidate cache in each interval to make it close to actual scenario.
> +can be scalable to produce n number of load threads.
> +
> +
> +Design Overview
> +--------------
> +---------------
> +
> +The logic to simulate load has been added above existing cyclictest application.
> +
> +Threads
> +--------
> +cyclicload : main process
> +--------------------------
> +-parse input arguments.
> +
> +-for first run : create caliberate thread.
> +	store caliberated count in caliberate_count file -for subsequent runs:
> +	read caliberated count from file and use that count to simulate defined load.
> +
> +-create t load1threads (t depending on cmdlime args, for smp system = 
> +num of cores, one thread per core)
> +
> +-update stats periodically while !shutdown -print stats periodically 
> +depending on cmdline args while !shutdown
> +
> +
> +caliberate thread
> +------------------
> +-is created only once for the first run of cyclicload -run at highest 
> +RT priority.
> +-affine itself turn by turn to each cpu. (for all cpus for multicore
> +system) -caliberate count per unit (ms by default) per cpu -store per 
> +cpu data in caliberate_count_array -recommended to be run with no or 
> +least load.
> +
> +
> +load1 thread(timer thread)
> +---------------------------
> +-run at priority parsed in main routine -recommended to run at 
> +highest RT priority -creates load2_thread (optional only if on load2 
> +is
> +nonzero) -calculate number of loops to execute to generate defined 
> +load by
> +	using caliberate_count_array and load percentage parsed in main 
> +routine -reduced interval = interval(window) - duration for load_t1 
> +-while loop until !shutdown
> +	-generate load_t1 load
> +	-sleep for reduced interval
> +	-calculate latency (cosumes around 1%-2% cpu)
> +	-discard off remaining load if window expires
> +	-set next_window_started flag to 1
> +	-signal load2_thread about next window
> +-overhead: consumes 1-2% cpu for latency maintainenance, etc 
> +-variation in produced load : 0%-2% of full cpu utilization
> +
> +
> +load2_thread
> +------------
> +generate load_t2 load
> +wait for next window to start
> +if window expires before generate load_t2 finishes,
> +	discard off remaining load
> +	restart generate load_t2 load
> +variation in produced load : 0%-1% of full cpu utilization
> --
> 1.7.4.1
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


