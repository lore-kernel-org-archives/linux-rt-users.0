From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/2] selftests: ftrace: Fix trigger extended error testcase
Date: Thu,  5 Apr 2018 18:28:42 +0900
Message-ID: <152292052250.15769.12565292689264162435.stgit@devbox>
References: <152292049091.15769.13306554953968999494.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152292049091.15769.13306554953968999494.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Previous testcase redirects echo-out into /dev/null
using "&>" as below

echo "trigger-command" >> trigger &> /dev/null

But this means redirecting both stdout and stderr into
/dev/null because it is same as below

echo "trigger-command" >> trigger > /dev/null 2>&1

So ">> trigger" redirects stdout to trigger file, but
next "> /dev/null" redirects stdout to /dev/null again
and the last "2>/&1" redirects stderr to stdout (/dev/null)

This fixes it by "2> /dev/null". And also, since it
must fail, add "!" to echo command.

Fixes: f06eec4d0f2c ("selftests: ftrace: Add inter-event hist triggers testcases")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../inter-event/trigger-extended-error-support.tc  |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
index 786dce7e48be..2aabab363cfb 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
@@ -29,7 +29,7 @@ do_reset
 
 echo "Test extended error support"
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
-echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger &>/dev/null
+! echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger 2> /dev/null
 if ! grep -q "ERROR:" events/sched/sched_wakeup/hist; then
     fail "Failed to generate extended error in histogram"
 fi
