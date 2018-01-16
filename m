From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 02/37] tracing: Add Documentation for log2 modifier
Date: Mon, 15 Jan 2018 20:51:36 -0600
Message-ID: <a419028bccab155749a4b8702d5b97af75f1578f.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1516069914.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Add a line for the log2 modifier, to keep it aligned with
tracing/README.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index b2145f4..a4143f04a 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -73,6 +73,7 @@
 	.sym-offset display an address as a symbol and offset
 	.syscall    display a syscall id as a system call name
 	.execname   display a common_pid as a program name
+	.log2       display log2 value rather than raw number
 
   Note that in general the semantics of a given field aren't
   interpreted when applying a modifier to it, but there are some
-- 
1.9.3
