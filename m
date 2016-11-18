From: He Zhe <zhe.he@windriver.com>
Subject: 4.8.6-rt5 ftrace function_graph hangs
Date: Fri, 18 Nov 2016 14:23:24 +0800
Message-ID: <d275a464-c787-6e21-0d3f-bbb3d854176e@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Yang Shi <yang.shi@windriver.com>
To: <rostedt@goodmis.org>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:39563 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbcKRGYT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Nov 2016 01:24:19 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm using 4.8.6-rt5 and find the following issue on nxp-t4xxx board/qemuppc/qemux86-64.
When executing "echo function_graph > /sys/kernel/debug/tracing/current_tracer" the system hangs.
I traced the kernel to where it dies but don't know how to fix. Please help. Thank you.

(gdb) b ftrace_startup

...

Run till exit from #0 ftrace_startup (ops=0xc0cf1704 <graph_ops>, command=8) at /PATH/TO/kernel/trace/ftrace.c:2653
0xc00eb768 in register_ftrace_graph (retfunc=0xc010186c <trace_graph_return>, entryfunc=0xc01014c4 <trace_graph_entry>)
    at /PATH/TO/kernel-source/kernel/trace/ftrace.c:5908
5908 ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
Value returned is $1 = 0
(gdb) l
5903 */
5904 __ftrace_graph_entry = entryfunc;
5905 ftrace_graph_entry = ftrace_graph_entry_test;
5906 update_function_graph_func();
5907
5908 ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
5909 out:
5910 mutex_unlock(&ftrace_lock);
5911 return ret;
5912 }
(gdb) n
5910 mutex_unlock(&ftrace_lock);
(gdb) n

hangs...



Thanks,
Zhe
