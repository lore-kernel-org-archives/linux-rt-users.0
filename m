From: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: =?UTF-8?q?=5BPATCH=201/4=5D=20Add=20README=20for=20cyclicload=20test=20tool?=
Date: Thu, 30 Aug 2012 15:26:44 +0530
Message-ID: <1346320607-6691-2-git-send-email-Priyanka.Jain@freescale.com>
References: <1346320607-6691-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <Poonam.Aggrwal@freescale.com>,
	Priyanka Jain <Priyanka.Jain@freescale.com>
To: <jkacur@redhat.com>, <williams@redhat.com>,
	<frank.rowand@am.sony.com>, <linux-rt-users@vger.kernel.org>,
	<dvhart@linux.intel.com>, <Rajan.Srivastava@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:34550
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307Ab2H3J6K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Aug 2012 05:58:10 -0400
In-Reply-To: <1346320607-6691-1-git-send-email-Priyanka.Jain@freescale.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Cyclicload test-tool is designed to simulate
load in form of one or two load threads.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 src/cyclicload/README |  273 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 273 insertions(+), 0 deletions(-)
 create mode 100644 src/cyclicload/README

diff --git a/src/cyclicload/README b/src/cyclicload/README
new file mode 100644
index 0000000..b95b517
--- /dev/null
+++ b/src/cyclicload/README
@@ -0,0 +1,273 @@
+ABSTRACT
+---------
+While developing an embedded product at the level of unit testing or
+component testing, it is often a requirement to test it under a
+specified load so that test setup is close to the real product.
+E.g while working on Linux Network stack targeted for LTE product,
+requirement is to simulate L2 stack load for unit testing of Linux
+network stack. Also as the load can be of Real-time (RT) type or
+Non Real-Time (NRT) type, requirement is to simulate load of both
+types.
+Cyclicload has been developed to meet these requirements.
+It can simulate RT and/or NRT type of load in form of load threads.
+
+
+
+INTRODUCTION
+-------------
+Cyclicload is a test tool, designed to simulate system load
+for unit/component testing.
+It can simulate user-defined load at user-defined interval
+of user-defined priority/nice values.
+It is also capable or producing simultaneous Real-Time critical
+(RT) as well as Non Real-Time (NRT) critical type of load.
+It can work for both uniprocessor as well as multiprocessor.
+
+
+
+WHAT DOES IT DO
+---------------
+It creates one or two load generating thread/s.
+1) Simulated load1_thread
+	-of RT type
+	-can run for load of 0% to 99%
+2) Simulated load2_thread
+	-can be of RT or NRT type
+	-can run for load of 0% to 99%
+
+Priority, nice value, load%, etc as input via command line.
+Also sum of 'load1' and 'load2' should not be greater than 99%
+as 1% has been reserved for control framework.
+
+
+HOW DOES IT WORK
+-----------------
+Cyclicload workflow can be broadly divided into following stages
+1) Initialization stage
+	a) Calibration
+	b) Other initialization
+2) Load producing stage
+3) Exit stage
+
+1) Initialization stage
+Calibration is the most important part of this stage from
+functional point of view as calibration data can vary from
+system to system or for various configurations on same system.
+But as generally for given set of configuration on a particular
+system, calibration output is same, it is kept as optional part
+depending on presence of 'calibrate_count' file.
+
+First it calibrates required loop_count per unit time per CPU to
+simulate load for a unit time. It stores this data in
+'calibrate_count' file.
+For the same run or subsequent runs on the same system,
+it uses this calibrated data to generate load.
+It is recommended to run cyclicload with no other load
+present on the system for proper calibration to generate
+'calibrate_count' file and then use this file for the next run.
+
+2) Load producing stage
+This is the actual testing stage.
+In this stage, cyclicload calls a loop after every regular interval.
+In this interval, it generates 'load1', 'load2' and then waits for the
+next interval.
+It might be possible that interval expires before the 'load2' completi=
on.
+In that case it discards off the remaining load.
+
+3)Exit stage
+In this stage, it displays how much desired load it was able to simula=
te
+in form of percentage of actual load run verses the desired load.
+
+For design details, see the DESIGN OVERVIEW SECTION.
+
+
+EXAMPLE USE CASE
+-----------------
+For better understanding of why this tool is required, what does it
+do and how does it works, let's consider an example use-case of LTE
+products.
+
+LTE system has many software components running on it:
+LTE layer2 stack having some Real time critical tasks
+like MAC thread and non-real time critical tasks like PDCP,
+Linux network stack, etc.
+While doing unit testing of Linux Network stack driver,
+one generally has a requirement to build the test setup which
+is close to the target LTE product. But making the complete
+LTE setup with EPC, eNodeB, etc is not always feasible.
+Cyclicload comes very handy here in simulating the LTE type
+of load.
+
+Let's assume LTE layer2 stack has 30% of real-time critical load
+and 20% on non-real time type.
+
+Cyclicload can first calibrate how much loop_count is required to
+generate a particular load. It can then use this output to simulate
+load in form of two threads:
+1) load1_thread
+	-running at RT priority
+	-producing 30% load
+	-simulating RT load on LTE layer2 stack
+
+2) load2_thread
+	-running at NRT priority
+	-producing 20% load
+	-simulating NRT load on LTE layer2 stack.
+
+This setup with simulated load can now be used to test the behavior
+of Linux network stack under the presence of simulated LTE layer2 load=
=2E
+
+Also, on completion, it displays how much =E2=80=98load1=E2=80=99 and =
=E2=80=98load2=E2=80=99
+it was able to simulate giving the user an idea of how much
+CPU bandwidth is available for the actual load in the system.
+
+Above example clearly showcase that one can do
+system optimization at unit level.
+
+
+COMMAND LINE ARGUMENTS/EXAMPLES
+-------------------------------
+
+Some of command line arguments:
+ "-x       --load_t1         load in percentage for t1 thread"
+ "-X       --load_t2         load in percentage for t2 thread"
+ "-z       --priority_t2     priority of t2 thread"
+ "-Z       --nice_t2         nice value of t2 thread"
+
+For more details on arguments, see cyclicload.8 file
+
+If both load_t1 and load_t2 are zero, it behaves as default cyclictest=
 application
+
+	#sudo ./cyclicload -p 99 -S -c 1 -d 0 -x 20 -X 30 -q -D 600&
+
+For help,
+	#sudo ./cyclicload -help
+
+
+
+THINGS TO NOTE
+---------------
+Cyclicload has overhead of 0%-3% for 'load1' thread and
+'load2' thread. So this should be taken into account
+while running load.
+If someone has a requirement of more pr=C3=A9cised load,
+he can run 2-3 cycles of Cyclicload and check CPU load
+of load threads using applications like =E2=80=98top =E2=80=93H =E2=80=
=93d 60=E2=80=99
+to get an idea of extra load of threads on the
+particular system.
+This extra load is generally constant for the particular system.
+
+
+RECOMMENDED SETTINGS
+----------------------
+-First run is recommended to be run with no or least load for accuracy=
=2E
+-Should be run with sudo or root permission.
+-Calibration routine produces 'calibrate_count' file in 'pwd' director=
y.
+	If one don't have permission in that directory,
+	file path should be changed in FILENAME in source
+	code or one can exploit shared memory method.
+-As load1_thread in addition to load generation, also controls
+ intervals start and end, it is recommended to be run with
+ highest RT priority.
+-Recommended to run in quiet mode (-q) in background for more accurate
+ load generation.
+
+
+TESTED ON
+----------
+Tested on uni-processor and multi-processor PowerPC
+and i686 platforms having PREEMPT_RT Linux running on it.
+
+
+FUTURE ENHANCEMENTS
+-------------------
+-Add option to take filepath from command line.
+-Add option to flush caches in each interval to make it
+	close to actual possible scenario.
+-can be scalable to produce n number of load threads.
+-Test on other architectures.
+
+
+DESIGN OVERVIEW
+-----------------
+Cyclicload uses exiting cyclictest application present
+in rt-tests test suite as its base code. It adds logic
+for calibration and to simulate load above it.
+
+Cyclicload code can be functionally divided into following
+threads
+1) cyclicload process thread
+2) calibrate_thread
+3) timerthread ('load1' thread)
+4) load2_thread
+
+Details below
+
+1) cyclicload process thread
+--------------------------
+-Parse input arguments.
+
+-For first run (!'calibrate_count' file present):
+	-Creates 'calibrate_count' file.
+	-Create 'calibrate_thread'.
+	-Store calibrated count in 'calibrate_count' file
+
+-For subsequent runs ('calibrate_count' file present):
+	-Read calibrated count from file in
+	'calibrate_count_array' and use that count
+	to simulate desired load.
+
+-Create t 'timerthread'
+	-Simulate CPU interval windows.
+	-'timerthread' also act as 'load1_thread'
+	-'t' depends on command-line argument
+		By default for SMP system
+		t =3D num of cores, one thread per core
+
+-Update stats periodically while !shutdown
+-Print stats periodically depending on command-line
+ argument while !shutdown
+
+
+2) calibrate_thread
+------------------
+-Is created only once for the first run of cyclicload
+ if 'calibrate_count' file is not present.
+-Runs at highest RT priority.
+-Affine itself turn by turn to each CPU.
+	(for all CPUs for Multicore system)
+-Calibrates loop-count per unit (ms by default) per CPU.
+-Stores per CPU data in calibrate_count_array (global array).
+
+
+3)timerthread ('load1' thread)
+---------------------------
+-Run at priority parsed in main routine
+-Creates 'load2_thread' if load2 is of nonzero value
+-Calculate number of loops to generate 'load1' and 'load2' by
+	using calibrate_count_array (global array) and
+	required load percentage parsed in main routine.
+-Calculates interval(window) and reduced interval for which
+ it should sleep.
+	reduced interval =3D interval(window) - duration for 'load1'
+-While loop until !shutdown
+	-Generates 'load1' load
+	-Sleep for reduced interval
+	-Calculates latency.
+	-Set next_window_started flag.
+	-Signal load2_thread about next window start.
+-Overhead: 0%-3% of full CPU utilization.
+	-Varies from system to system but generally constant
+	 for a system.
+
+
+load2_thread
+------------
+-While loop until !shutdown
+	-Generates 'load2' load
+		if window expires before generate 'load2' finishes,
+		discards-off remaining load
+	-Waits for signal for next window to start.
+-Overhead: 0%-2% of full CPU utilization.
+	-Varies from system to system but generally constant
+	 for a system.
--=20
1.7.4.1



--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
