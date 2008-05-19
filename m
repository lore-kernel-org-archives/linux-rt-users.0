From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: [Fwd: [PATCH 1/1] [REALTIME] Profiled tests.]
Date: Mon, 19 May 2008 21:49:01 +0530
Message-ID: <1211213941.4871.2.camel@subratamodak.linux.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: ltp-list <ltp-list@lists.sourceforge.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Chirag Jog <chirag@linux.vnet.ibm.com>,
	Ankita Garg <ankita@in.ibm.com>,
	dino <dino@linux.vnet.ibm.com>,
	Sripathi Kodi <sripathik@in.ibm.com>,
	Michael Olbrich <m.olbrich@pengutronix.
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60194 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbYESQTU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 12:19:20 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4JGJEOc002841
	for <linux-rt-users@vger.kernel.org>; Mon, 19 May 2008 12:19:14 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m4JGJEAY125074
	for <linux-rt-users@vger.kernel.org>; Mon, 19 May 2008 12:19:14 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m4JGJDWZ018331
	for <linux-rt-users@vger.kernel.org>; Mon, 19 May 2008 12:19:14 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Looping in others as well.

Regards--
Subrata

-------- Forwarded Message --------
From: Gilles Carry <gilles.carry@bull.net>
To: ltp-list@lists.sourceforge.net
Cc: subrata@linux.vnet.ibm.com, dvhltc@us.ibm.com, tinytim@us.ibm.com,
jean-pierre.dion@bull.net, sebastien.dugue@bull.net,
gilles.carry@bull.net
Subject: [PATCH 1/1] [REALTIME] Profiled tests.
Date: Mon, 19 May 2008 15:54:47 +0200

This patch is intentionnally global as splitting changes would not make sense.
This includes:
- changes of scripts for automated tests to feature profiles
- individual changes for tests using automation
- a default profile (to be used as an example)
- documentation writing/modifying

---
 testcases/realtime/doc/AUTOMATED_RUN               |   46 +++++
 testcases/realtime/doc/HOWTO_ADD_TESTS             |   10 +-
 testcases/realtime/doc/run_auto.sh.tpl             |   17 ++
 testcases/realtime/func/gtod_latency/run_auto.sh   |    8 +-
 testcases/realtime/func/matrix_mult/run_auto.sh    |    8 +-
 .../realtime/func/periodic_cpu_load/run_auto.sh    |    6 +-
 testcases/realtime/func/pi-tests/run_auto.sh       |   18 ++-
 testcases/realtime/func/pi_perf/run_auto.sh        |    6 +-
 testcases/realtime/func/prio-preempt/run_auto.sh   |    6 +-
 testcases/realtime/func/prio-wake/run_auto.sh      |    6 +-
 .../realtime/func/pthread_kill_latency/run_auto.sh |    6 +-
 testcases/realtime/func/sched_football/run_auto.sh |    6 +-
 testcases/realtime/func/sched_jitter/run_auto.sh   |    6 +-
 testcases/realtime/func/sched_latency/run_auto.sh  |    6 +-
 testcases/realtime/func/thread_clock/run_auto.sh   |    6 +-
 testcases/realtime/profiles/default                |   60 +++++++
 testcases/realtime/run.sh                          |  179 +++++++++++---------
 testcases/realtime/scripts/run_c_files.sh          |   68 +++++---
 testcases/realtime/scripts/setenv.sh               |    4 +
 .../realtime/testcases/realtime/doc/AUTOMATED_RUN  |   46 +++++
 20 files changed, 390 insertions(+), 128 deletions(-)
 create mode 100644 testcases/realtime/doc/AUTOMATED_RUN
 create mode 100644 testcases/realtime/doc/run_auto.sh.tpl
 create mode 100644 testcases/realtime/profiles/default
 create mode 100644 testcases/realtime/testcases/realtime/doc/AUTOMATED_RUN

diff --git a/testcases/realtime/doc/AUTOMATED_RUN b/testcases/realtime/doc/AUTOMATED_RUN
new file mode 100644
index 0000000..7cf7a56
--- /dev/null
+++ b/testcases/realtime/doc/AUTOMATED_RUN
@@ -0,0 +1,46 @@
+This explains how the automatic testing works with profile support.
+
+Profiles help users maintaining sets of tests for specific requirements.
+Each profile is defined in a file.
+All profiles are stored in the <RT_TESTS_ROOT>/profile/ directory.
+
+
+I. Automated tests in specific test-diretory.
+
+Tests can be run for one directory by running ./run_auto.sh in the wanted dir.
+run_auto.sh is customizable and contains a command line for each test to be run.
+(see template run_auto.sh.tpl in this dir)
+run_auto.sh can be invoked with an argument which is the profile to use.
+profile/ dir holds a file for each defined profile.
+A profile has a number of lines for which each test executable can be run
+with different arguments.
+Invoking run_auto.sh with no arg uses the default profile.
+Currently, the default profile does not alter the default values defined
+individually in each test.
+
+Example:
+In dir func/prio-preempt, user runs ./run_auto.sh prf1
+Since run_auto.sh contains this line:
+	$SCRIPTS_DIR/run_c_files.sh $profile prio-preempt
+
+run_c_files.sh will look into profile/prf1 for lines like this:
+	func/prio-preempt prio-preempt -c 2 -j
+	func/prio-preempt prio-preempt -c 1
+
+and run the following commands from the func/prio-preempt dir:
+	prio-preempt -c 2 -j
+	prio-preempt -c 1
+
+
+
+II. All automated tests
+
+Tests can also be run with <RT_TESTS_ROOT>/run.sh. User may choose whatever
+test range he wants. (all, func, perf... see README)
+run.sh searches for run_auto.sh files in the wanted area and runs them one
+by one.
+To use a profile other than default, use argument '-p <myprofile>'.
+
+Examples:
+	./run.sh -p prf1 -t func	# Uses prf1 profile
+	./run.sh -t func		# Uses default profile
diff --git a/testcases/realtime/doc/HOWTO_ADD_TESTS b/testcases/realtime/doc/HOWTO_ADD_TESTS
index 8bd5c4d..2f51df2 100644
--- a/testcases/realtime/doc/HOWTO_ADD_TESTS
+++ b/testcases/realtime/doc/HOWTO_ADD_TESTS
@@ -10,13 +10,17 @@ rt-test - HOWTO_ADD_TESTS
 	  individually as an available test.
 	- run "run.sh list" to see available tests

-3. If you are creating a new subdirectory:
+2. If you are creating a new subdirectory:
    Provide:
 	- your test files
 	- your GNUMakefile.am
-	- your run_auto.sh script
+	- your run_auto.sh script (use template: doc/run_auto.sh.tpl)

-   Test the following:
+3. Modify tests profiles if to be run automatically
+	- profile/default
+	- other profiles if needed
+
+4. Test the following:
 	sh autogen.sh; ./configure, make, naturally
 	run.sh list
 	run.sh clean
diff --git a/testcases/realtime/doc/run_auto.sh.tpl b/testcases/realtime/doc/run_auto.sh.tpl
new file mode 100644
index 0000000..2238916
--- /dev/null
+++ b/testcases/realtime/doc/run_auto.sh.tpl
@@ -0,0 +1,17 @@
+#! /bin/bash
+
+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
+if [ ! $SCRIPTS_DIR ]; then
+        # assume we're running standalone
+        export SCRIPTS_DIR=../../scripts/
+fi
+
+source $SCRIPTS_DIR/setenv.sh
+
+# Warning: tests args are now set in profiles
+
+# Customize below. One line per test.
+$SCRIPTS_DIR/run_c_files.sh $profile testexecutable1
+# $SCRIPTS_DIR/run_c_files.sh $profile testexecutable2
diff --git a/testcases/realtime/func/gtod_latency/run_auto.sh b/testcases/realtime/func/gtod_latency/run_auto.sh
index 130675c..1e181e4 100755
--- a/testcases/realtime/func/gtod_latency/run_auto.sh
+++ b/testcases/realtime/func/gtod_latency/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,8 +10,9 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "gtod_latency"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile gtod_latency

 # This is only for hostility testing
-#$SCRIPTS_DIR/run_c_files.sh "gtod_infinite"
+#$SCRIPTS_DIR/run_c_files.sh $profile gtod_infinite

diff --git a/testcases/realtime/func/matrix_mult/run_auto.sh b/testcases/realtime/func/matrix_mult/run_auto.sh
index 5403089..8713ca3 100755
--- a/testcases/realtime/func/matrix_mult/run_auto.sh
+++ b/testcases/realtime/func/matrix_mult/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,6 +10,5 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "matrix_mult"
-
-
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile matrix_mult
diff --git a/testcases/realtime/func/periodic_cpu_load/run_auto.sh b/testcases/realtime/func/periodic_cpu_load/run_auto.sh
index 05e3131..334174e 100755
--- a/testcases/realtime/func/periodic_cpu_load/run_auto.sh
+++ b/testcases/realtime/func/periodic_cpu_load/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,4 +10,5 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "periodic_cpu_load:periodic_cpu_load_single"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile periodic_cpu_load periodic_cpu_load_single
diff --git a/testcases/realtime/func/pi-tests/run_auto.sh b/testcases/realtime/func/pi-tests/run_auto.sh
index 82fec4c..8365943 100755
--- a/testcases/realtime/func/pi-tests/run_auto.sh
+++ b/testcases/realtime/func/pi-tests/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,22 +10,23 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "testpi-0"
-$SCRIPTS_DIR/run_c_files.sh "testpi-1"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile testpi-0
+$SCRIPTS_DIR/run_c_files.sh $profile testpi-1

 LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-1.log"
 PYTHONPATH=../../  python parse-testpi1.py $LOG_FILE 2>&1 | tee -a $LOG_FILE

-$SCRIPTS_DIR/run_c_files.sh "testpi-2"
+$SCRIPTS_DIR/run_c_files.sh $profile testpi-2
 LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-2.log"
 PYTHONPATH=../../  python parse-testpi2.py $LOG_FILE 2>&1 | tee -a $LOG_FILE

-$SCRIPTS_DIR/run_c_files.sh "testpi-4"
+$SCRIPTS_DIR/run_c_files.sh $profile testpi-4
 LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-4.log"
 PYTHONPATH=../../  python parse-testpi1.py $LOG_FILE 2>&1 | tee -a $LOG_FILE 



-$SCRIPTS_DIR/run_c_files.sh "testpi-5"
-$SCRIPTS_DIR/run_c_files.sh "testpi-6"
-$SCRIPTS_DIR/run_c_files.sh "sbrk_mutex"
+$SCRIPTS_DIR/run_c_files.sh $profile testpi-5
+$SCRIPTS_DIR/run_c_files.sh $profile testpi-6
+$SCRIPTS_DIR/run_c_files.sh $profile sbrk_mutex
diff --git a/testcases/realtime/func/pi_perf/run_auto.sh b/testcases/realtime/func/pi_perf/run_auto.sh
index 29b16a9..ee590d3 100755
--- a/testcases/realtime/func/pi_perf/run_auto.sh
+++ b/testcases/realtime/func/pi_perf/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,4 +10,5 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "pi_perf"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile pi_perf
diff --git a/testcases/realtime/func/prio-preempt/run_auto.sh b/testcases/realtime/func/prio-preempt/run_auto.sh
index 728f106..5dea246 100755
--- a/testcases/realtime/func/prio-preempt/run_auto.sh
+++ b/testcases/realtime/func/prio-preempt/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,6 +10,7 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "prio-preempt"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile prio-preempt


diff --git a/testcases/realtime/func/prio-wake/run_auto.sh b/testcases/realtime/func/prio-wake/run_auto.sh
index eb38b26..31433bf 100755
--- a/testcases/realtime/func/prio-wake/run_auto.sh
+++ b/testcases/realtime/func/prio-wake/run_auto.sh
@@ -1,8 +1,12 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
 fi
 source $SCRIPTS_DIR/setenv.sh
-$SCRIPTS_DIR/run_c_files.sh "prio-wake"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile prio-wake
diff --git a/testcases/realtime/func/pthread_kill_latency/run_auto.sh b/testcases/realtime/func/pthread_kill_latency/run_auto.sh
index b2fcbad..d2c543b 100755
--- a/testcases/realtime/func/pthread_kill_latency/run_auto.sh
+++ b/testcases/realtime/func/pthread_kill_latency/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,6 +10,7 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "pthread_kill_latency"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile pthread_kill_latency


diff --git a/testcases/realtime/func/sched_football/run_auto.sh b/testcases/realtime/func/sched_football/run_auto.sh
index e161e66..3694fce 100755
--- a/testcases/realtime/func/sched_football/run_auto.sh
+++ b/testcases/realtime/func/sched_football/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,7 +10,8 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "sched_football"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile sched_football

 LOG_FILE="$LOG_DIR/$LOG_FORMAT-sched_football.log"
 PYTHONPATH=../../  python parse-football.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
diff --git a/testcases/realtime/func/sched_jitter/run_auto.sh b/testcases/realtime/func/sched_jitter/run_auto.sh
index 547b844..c2d1be9 100755
--- a/testcases/realtime/func/sched_jitter/run_auto.sh
+++ b/testcases/realtime/func/sched_jitter/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,4 +10,5 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "sched_jitter"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile sched_jitter
diff --git a/testcases/realtime/func/sched_latency/run_auto.sh b/testcases/realtime/func/sched_latency/run_auto.sh
index 601e3fb..a67a8f0 100755
--- a/testcases/realtime/func/sched_latency/run_auto.sh
+++ b/testcases/realtime/func/sched_latency/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,4 +10,5 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "sched_latency -d 1 -t 5"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile sched_latency -d 1 -t 5
diff --git a/testcases/realtime/func/thread_clock/run_auto.sh b/testcases/realtime/func/thread_clock/run_auto.sh
index cf0ce3d..529ff16 100755
--- a/testcases/realtime/func/thread_clock/run_auto.sh
+++ b/testcases/realtime/func/thread_clock/run_auto.sh
@@ -1,5 +1,8 @@
 #! /bin/bash

+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,4 +10,5 @@ fi

 source $SCRIPTS_DIR/setenv.sh

-$SCRIPTS_DIR/run_c_files.sh "tc-2"
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile tc-2
diff --git a/testcases/realtime/profiles/default b/testcases/realtime/profiles/default
new file mode 100644
index 0000000..9fb7085
--- /dev/null
+++ b/testcases/realtime/profiles/default
@@ -0,0 +1,60 @@
+# Test run commands for default profile
+#
+# format:
+#	reldir testexec [ args ... ]
+#
+# First field is the relative directory of the test.
+# Second field is the executable itself.
+# Others field are arguments of the command.
+# In the above example, the following would be done:
+# cd reldir ; ./testexec args ...
+# as a usual shell command.
+#
+# Comments are shell-like.
+#
+# This is to be read by scripts/run_c_files.sh and is useful
+# for local or global runs (<RT_TESTS_ROOT>/run.sh or <TESTDIR>/run_auto.sh)
+#
+
+
+# Pass if maximum lock time is less than threshold (us).
+# Default threshold=200 us
+func/pi_perf			pi_perf -c 200
+
+# Pass if maximum latency is less than criterium (us).
+# Default=20 us
+func/pthread_kill_latency	pthread_kill_latency -c 20
+
+# Pass if all treads get preempted within max loops.
+# Default max=1
+func/prio-preempt		prio-preempt -c 1
+
+# Pass if all delay are less than maxduration (us).
+# Default maxduration=100 us
+func/sched_latency		sched_latency	-d 1 -t 5 -c 100
+
+# Pass if ratio * average concurrent time < average sequential time
+# Default ratio=0.75
+func/matrix_mult		matrix_mult -c 0.75
+
+# Pass if difference between the sum of thread times and process time
+# is less than maxduration (s).
+# Default maxduration=0.5 s
+func/thread_clock		tc-2 -c 0.5
+
+
+# The below tests have no pass/fail criterium.
+func/gtod_latency		gtod_latency
+func/sched_jitter		sched_jitter
+func/periodic_cpu_load		periodic_cpu_load
+func/periodic_cpu_load		periodic_cpu_load_single
+func/prio-wake			prio-wake
+func/sched_football		sched_football
+func/pi-tests			testpi-0
+func/pi-tests			testpi-1
+func/pi-tests			testpi-2
+func/pi-tests			testpi-4
+func/pi-tests			testpi-5
+func/pi-tests			testpi-6
+func/pi-tests			sbrk_mutex
+
diff --git a/testcases/realtime/run.sh b/testcases/realtime/run.sh
index ced310d..ce0070d 100755
--- a/testcases/realtime/run.sh
+++ b/testcases/realtime/run.sh
@@ -32,7 +32,7 @@

 function usage()
 {
-	echo -e "\nUsage: run.sh  -t test-argument [-l loop num_of_iterations] [-t test-argument1 [-l loop ...]] ..."
+	echo -e "\nUsage: run.sh [-p profile] -t test-argument [-l loop num_of_iterations] [-t test-argument1 [-l loop ...]] ..."
 	echo -e "\nWhere test-argument = func | stress | perf | all | list | clean | test_name "
 	echo -e "\n and: \n"
 	echo -e " func = 	all functional tests will be run "
@@ -41,6 +41,7 @@ function usage()
 	echo -e " all =		all tests will be run "
 	echo -e " clean = 	all logs deleted, make clean performed "
 	echo -e " test_name = 	only test_name subdir will be run (e.g: func/pi-tests) "
+	echo -e " -p profile = 	use profile instead of default "
 	echo -e " -h	    =	help"
 	echo -e "\n"
 	exit 1;
@@ -66,29 +67,34 @@ list_tests()

 function run_test()
 {
+	local profile
+
+	profile=$1
+	shift
+
 	iter=0
 	if [ -z "$2" ]; then
-	    LOOPS=1
+		LOOPS=1
 	else
-	 LOOPS=$2	
+		LOOPS=$2	
 	fi
 	#Test if $LOOPS is a integer
 	if [[ ! $LOOPS =~ ^[0-9]+$ ]]; then
-	    echo "\"$LOOPS\" doesn't appear to be a number"
-	    usage
-	    exit
+		echo "\"$LOOPS\" doesn't appear to be a number"
+		usage
+		exit
 	fi 
 	if [ -d "$test" ]; then
-	    pushd $test >/dev/null
-	    if [ -f "run_auto.sh" ]; then
+		pushd $test >/dev/null
+		if [ -f "run_auto.sh" ]; then
 		echo " Running $LOOPS runs of $subdir "
 		for((iter=0; $iter < $LOOPS; iter++)); do
-		./run_auto.sh 
+			./run_auto.sh $profile
 		done
 	    else
 		echo -e "\n Failed to find run script in $test \n"
-	    fi
-	    pushd $TESTS_DIR >/dev/null
+		fi
+		pushd $TESTS_DIR >/dev/null
 	else
 		echo -e "\n $test is not a valid test subdirectory "
 		usage
@@ -102,58 +108,64 @@ function make_clean()
 	rm -rf logs/*
 	for mfile in `find -name "Makefile"`;
 	do
-	    target_dir=`dirname $mfile`
-	    pushd $target_dir >/dev/null
-	    make clean
-	    pushd $TESTS_DIR >/dev/null
+		target_dir=`dirname $mfile`
+		pushd $target_dir >/dev/null
+		make clean
+		pushd $TESTS_DIR >/dev/null
 	done
 }

 find_test()
 {
-    case $1 in
+	local profile
+
+	profile=$1
+	shift
+
+	case $1 in
 	func)
-	    TESTLIST="func"
-            ;;
-      	stress)
-            TESTLIST="stress"
-	    ;;
-        perf)
-	    TESTLIST="perf"
-	    ;;
-        all)
-	# Run all tests which have run_auto.sh
-	    TESTLIST="func stress java perf"
-            ;;
+		TESTLIST="func"
+		;;
+	stress)
+		TESTLIST="stress"
+		;;
+	perf)
+		TESTLIST="perf"
+		;;
+	all)
+		# Run all tests which have run_auto.sh
+		TESTLIST="func stress java perf"
+		;;
 	list)
-	# This will only display subdirs which have run_auto.sh
-            list_tests
-	    exit
-	    ;;
-        clean)
-	# This will clobber logs, out files, .o's etc
-	    make_clean
-            exit
-	    ;;
-
-        *)
-	# run the tests in the individual subdirectory if it exists
-	    TESTLIST="$1"
-	    ;;
-    esac
-    for subdir in $TESTLIST; do
-	if [ -d $subdir ]; then
-	    pushd $subdir >/dev/null
-            for name in `find -name "run_auto.sh"`; do
-		test="`dirname $name`"
-		run_test "$test" "$2"
-		pushd $subdir > /dev/null
-	    done
-		pushd $TESTS_DIR >/dev/null
-        else
-	    echo -e "\n $subdir not found; check name/path with run.sh list "
-        fi
-    done
+		# This will only display subdirs which have run_auto.sh
+		list_tests
+		exit
+		;;
+	clean)
+		# This will clobber logs, out files, .o's etc
+		make_clean
+		exit
+		;;
+
+	*)
+		# run the tests in the individual subdirectory if it exists
+		TESTLIST="$1"
+		;;
+	esac
+
+	for subdir in $TESTLIST; do
+		if [ -d $subdir ]; then
+			pushd $subdir >/dev/null
+			for name in `find -name "run_auto.sh"`; do
+				test="`dirname $name`"
+				run_test "$profile" "$test" "$2"
+				pushd $subdir > /dev/null
+			done
+			pushd $TESTS_DIR >/dev/null
+		else
+			echo -e "\n $subdir not found; check name/path with run.sh list "
+		fi
+	done

 }

@@ -161,7 +173,7 @@ SCRIPTS_DIR="$(readlink -f ${0%/*})/scripts"
 source $SCRIPTS_DIR/setenv.sh

 if [ $# -lt 1 ]; then
-	usage	
+	usage
 fi
 pushd $TESTS_DIR >/dev/null

@@ -174,37 +186,40 @@ popd

 ISLOOP=0
 index=0
-while getopts ":t:l:h" option
+while getopts ":t:l:hp:" option
 do
-    case "$option" in
-	
+	case "$option" in
+
 	t )
-	    if [ $ISLOOP -eq 1 ]; then
-	    	LOOP=1
-		tests[$index]=$LOOP
+		if [ $ISLOOP -eq 1 ]; then
+			LOOP=1
+			tests[$index]=$LOOP
+			index=$((index+1))
+		fi
+
+		tests[$index]="$OPTARG"
 		index=$((index+1))
-	    fi
-	
-	    tests[$index]="$OPTARG"
-	    index=$((index+1))
-	    TESTCASE="$OPTARG"
-	    ISLOOP=1		
-	    ;;
-	
+		TESTCASE="$OPTARG"
+		ISLOOP=1		
+		;;
+
 	l ) 
-	    ISLOOP=0
-	    tests[$index]="$OPTARG"
-	    LOOP="$OPTARG"
-	    index=$((index+1))
-	    ;;
+		ISLOOP=0
+		tests[$index]="$OPTARG"
+		LOOP="$OPTARG"
+		index=$((index+1))
+		;;
+	p )
+		profile=$OPTARG
+		;;
 	h )
-	    usage	
-	    ;;
+		usage	
+		;;
 	* ) echo "Unrecognized option specified"
-	    usage
-	    ;;
-    esac
+		usage
+		;;
+	esac
 done
 for(( i=0; $i < $index ; $((i+=2)) )); do
-    find_test ${tests[$i]} ${tests[$((i+1))]}
+	find_test "$profile" ${tests[$i]} ${tests[$((i+1))]}
 done
diff --git a/testcases/realtime/scripts/run_c_files.sh b/testcases/realtime/scripts/run_c_files.sh
index 0a80f9c..6ba4499 100755
--- a/testcases/realtime/scripts/run_c_files.sh
+++ b/testcases/realtime/scripts/run_c_files.sh
@@ -4,35 +4,59 @@
 # This script is called from the directory where the test cases are.
 # Not all the test cases use this.
 #
-# Usage: $0 test-name
-#
-# For the moment, this does not take multiple arguments.
-# Call this script separately for each test.
+# Usage: $0 profile testname1 [ testname2 ... ]
 #
+# This script looks for *each* line in profile matching the
+# pattern "testid testname" and runs the corresponding test with the
+# args defined in the line.
+
+
+[ $# -lt 2 ] && { echo >&2 "$0: too few arguments (at least two)" ; exit 1 ; }
+profile=$1
+shift

-echo -e "SCRIPTS_DIR = $SCRIPTS_DIR"
-source $SCRIPTS_DIR/setenv.sh
+#source $SCRIPTS_DIR/setenv.sh
+
+profile_path=$PROFILES_DIR/$profile
+# Does profile exist?
+[ ! -f "$profile_path" ] && { echo >&2 "$0: Could not find profile ($profile_path)" ; exit 1 ; }

 # Compile the test cases to support stand alone runs.
 make

-IFS=:

 # Run the test case
-for file in $*
+for testname in $*
 do
-	cmd=`echo $file | cut -d ' ' -f 1`
-	if [ `echo $file | wc -w` -gt 1 ]; then
-		param=`echo $file | cut -d ' ' -f 2-`
-	fi
-	LOG_FILE="$LOG_DIR/$LOG_FORMAT-${cmd}${param// /}.log"
-	echo -e "--- Running testcase $cmd $param --- \n" | tee -a $LOG_FILE
-	date | tee -a $LOG_FILE
-	echo "Logging to $LOG_FILE" | tee -a $LOG_FILE
-        eval ./$cmd $param | tee -a $LOG_FILE
-	echo "" | tee -a $LOG_FILE
-	date | tee -a $LOG_FILE
-	echo -e "The $cmd test appears to have completed. \n" | tee -a $LOG_FILE
-	cmd=""
-	param=""
+	# Strip off comments and feed it to trivial parser.
+	sed 's/#.*//' < $profile_path | while read line ; do
+		set $line ""
+		# Check if the line is elligible
+		if [ "$1" = "$TEST_REL_DIR" -a "$2" = "$testname" ] ; then
+			cmd=$2
+			shift 2
+			params="$*"
+
+			LOG_FILE="$LOG_DIR/$LOG_FORMAT-${cmd}${params// /}.log"
+			[ ! -d $LOG_DIR ] && mkdir -p $LOG_DIR
+
+			( 
+				echo "--- Running testcase $cmd $params ---"
+				date
+				echo "Logging to $LOG_FILE"
+				eval ./$cmd 2>&1 $params
+				echo
+				date
+				echo "The $cmd test appears to have completed."
+			) | tee -a $LOG_FILE
+		fi
+	done
 done
+exit
+			echo -e "--- Running testcase $cmd $params --- \n" | tee -a $LOG_FILE
+			date | tee -a $LOG_FILE
+			echo "Logging to $LOG_FILE" | tee -a $LOG_FILE
+			eval ./$cmd 2>&1 $params| tee -a $LOG_FILE
+			echo "" | tee -a $LOG_FILE
+			date | tee -a $LOG_FILE
+			echo -e "The $cmd test appears to have completed. \n" | tee -a $LOG_FILE
diff --git a/testcases/realtime/scripts/setenv.sh b/testcases/realtime/scripts/setenv.sh
index 235ff9e..7532353 100755
--- a/testcases/realtime/scripts/setenv.sh
+++ b/testcases/realtime/scripts/setenv.sh
@@ -12,7 +12,11 @@ if [ -z "$PARENT" ]; then
 fi

 export TESTS_DIR=$PARENT/$TESTSUITE_NAME
+# TEST_REL_DIR is used as a unique id for a test dir
+export TEST_REL_DIR=${PWD#$TESTS_DIR/}
 export SCRIPTS_DIR=$TESTS_DIR/scripts
+export PROFILES_DIR=$TESTS_DIR/profiles
 export LOG_DIR=$TESTS_DIR/logs
 export ARGUMENTS_INPUT_ERROR=25
 export LOG_FORMAT="`hostname --short`-`uname -m`-`uname -r`-`date +%Y-%d-%m`"
+
diff --git a/testcases/realtime/testcases/realtime/doc/AUTOMATED_RUN b/testcases/realtime/testcases/realtime/doc/AUTOMATED_RUN
new file mode 100644
index 0000000..7cf7a56
--- /dev/null
+++ b/testcases/realtime/testcases/realtime/doc/AUTOMATED_RUN
@@ -0,0 +1,46 @@
+This explains how the automatic testing works with profile support.
+
+Profiles help users maintaining sets of tests for specific requirements.
+Each profile is defined in a file.
+All profiles are stored in the <RT_TESTS_ROOT>/profile/ directory.
+
+
+I. Automated tests in specific test-diretory.
+
+Tests can be run for one directory by running ./run_auto.sh in the wanted dir.
+run_auto.sh is customizable and contains a command line for each test to be run.
+(see template run_auto.sh.tpl in this dir)
+run_auto.sh can be invoked with an argument which is the profile to use.
+profile/ dir holds a file for each defined profile.
+A profile has a number of lines for which each test executable can be run
+with different arguments.
+Invoking run_auto.sh with no arg uses the default profile.
+Currently, the default profile does not alter the default values defined
+individually in each test.
+
+Example:
+In dir func/prio-preempt, user runs ./run_auto.sh prf1
+Since run_auto.sh contains this line:
+	$SCRIPTS_DIR/run_c_files.sh $profile prio-preempt
+
+run_c_files.sh will look into profile/prf1 for lines like this:
+	func/prio-preempt prio-preempt -c 2 -j
+	func/prio-preempt prio-preempt -c 1
+
+and run the following commands from the func/prio-preempt dir:
+	prio-preempt -c 2 -j
+	prio-preempt -c 1
+
+
+
+II. All automated tests
+
+Tests can also be run with <RT_TESTS_ROOT>/run.sh. User may choose whatever
+test range he wants. (all, func, perf... see README)
+run.sh searches for run_auto.sh files in the wanted area and runs them one
+by one.
+To use a profile other than default, use argument '-p <myprofile>'.
+
+Examples:
+	./run.sh -p prf1 -t func	# Uses prf1 profile
+	./run.sh -t func		# Uses default profile

