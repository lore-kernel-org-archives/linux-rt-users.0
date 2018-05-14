From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 12/14] ftrace/selftest: Fix reset_trigger() to handle triggers with filters
Date: Mon, 14 May 2018 16:58:57 -0400
Message-ID: <20180514205959.080491350@goodmis.org>
References: <20180514205845.017925650@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0012-ftrace-selftest-Fix-reset_trigger-to-handle-triggers.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The reset_trigger() function breaks up the command by a space ' '. This is
useful to ignore the '[active]' word for triggers when removing them. But if
the trigger has a filter (ie. "if prio < 10") then the filter needs to be
attached to the line that is written into the trigger file to remove it. But
the truncation removes the filter and the triggers are not cleared properly.

Before, reset_trigger() did this:

 # echo 'hist:keys=common_pid if prev_prio < 10' > events/sched/sched_switch/trigger
 # echo 'hist:keys=common_pid if next_prio < 10' >> events/sched/sched_switch/trigger
 # cat events/sched/sched_switch/trigger
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if prev_prio < 10 [active]
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if next_prio < 10 [active]

 reset_trigger() {
   echo '!hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048' >> events/sched/sched_switch/trigger
 }

 # cat events/sched/sched_switch/trigger
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if prev_prio < 10 [active]
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if next_prio < 10 [active]

After, where it includes the filter:

 reset_trigger() {
   echo '!hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if prev_prio < 10' >> events/sched/sched_switch/trigger
 }

 # cat events/sched/sched_switch/trigger
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if next_prio < 10 [active]

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 8393b1c06027..e4645d5e3126 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -19,13 +19,13 @@ reset_trigger_file() {
     # remove action triggers first
     grep -H ':on[^:]*(' $@ |
     while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" >> $file
     done
     grep -Hv ^# $@ |
     while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" > $file
     done
-- 
2.17.0
