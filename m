From: He Zhe <zhe.he@windriver.com>
Subject: Re: 4.8.6-rt5 ftrace function_graph hangs
Date: Mon, 21 Nov 2016 16:30:40 +0800
Message-ID: <67df43c6-ac39-dea0-025d-5fce434d2743@windriver.com>
References: <d275a464-c787-6e21-0d3f-bbb3d854176e@windriver.com>
 <20161118113524.43f6ff3c@gandalf.local.home>
 <1785742b-8094-56af-01b9-6bac5c67865f@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <tglx@linutronix.de>, <linux-rt-users@vger.kernel.org>,
        Yang Shi <yang.shi@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:52072 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbcKUIbe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Nov 2016 03:31:34 -0500
In-Reply-To: <1785742b-8094-56af-01b9-6bac5c67865f@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 11/21/2016 04:26 PM, He Zhe wrote:
>
> On 11/19/2016 12:35 AM, Steven Rostedt wrote:
>> On Fri, 18 Nov 2016 14:23:24 +0800
>> He Zhe <zhe.he@windriver.com> wrote:
>>
>>> Hi,
>>>
>>> I'm using 4.8.6-rt5 and find the following issue on nxp-t4xxx board/qemuppc/qemux86-64.
>>> When executing "echo function_graph > /sys/kernel/debug/tracing/current_tracer" the system hangs.
>>> I traced the kernel to where it dies but don't know how to fix. Please help. Thank you.
>>>
>>> (gdb) b ftrace_startup
>>>
>>> ...
>>>
>>> Run till exit from #0 ftrace_startup (ops=0xc0cf1704 <graph_ops>, command=8) at /PATH/TO/kernel/trace/ftrace.c:2653
>>> 0xc00eb768 in register_ftrace_graph (retfunc=0xc010186c <trace_graph_return>, entryfunc=0xc01014c4 <trace_graph_entry>)
>>>     at /PATH/TO/kernel-source/kernel/trace/ftrace.c:5908
>>> 5908 ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
>>> Value returned is $1 = 0
>>> (gdb) l
>>> 5903 */
>>> 5904 __ftrace_graph_entry = entryfunc;
>>> 5905 ftrace_graph_entry = ftrace_graph_entry_test;
>>> 5906 update_function_graph_func();
>>> 5907
>>> 5908 ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
>>> 5909 out:
>>> 5910 mutex_unlock(&ftrace_lock);
>>> 5911 return ret;
>>> 5912 }
>>> (gdb) n
>>> 5910 mutex_unlock(&ftrace_lock);
>>> (gdb) n
>>>
>>> hangs...
>>>
>> Can't you get a backtrace from this? It's running under qemu right? So
>> it should be able to break it and see where it is at.
>>
>> Note, my PowerPC box has just died, so I'm no longer able to work on
>> it, and don't have time to set up a qemu ppc image at the moment.
> Thanks you.
> So far we've found it happens on nxp-t4020(ppc) nxp-ls1021a(arma7) intel-x86 qemuppc qemux86-64.
> Here is my backtrace and the config is attached.
>
> (gdb) l
> 5905            ftrace_graph_entry = ftrace_graph_entry_test;
> 5906            update_function_graph_func();
> 5907
> 5908            ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
> 5909    out:
> 5910            mutex_unlock(&ftrace_lock);   <--- dies here
> 5911            return ret;
> 5912    }
> 5913
> 5914    void unregister_ftrace_graph(void)
> (gdb) bt
> #0  register_ftrace_graph (retfunc=0xc0101548 <trace_graph_return>, entryfunc=0xc01011a0 <trace_graph_entry>)
>     at /PATH/kernel/trace/ftrace.c:5910
> #1  0xc0100e3c in graph_trace_init (tr=<optimized out>) at /PATH/kernel/trace/trace_functions_graph.c:461
> #2  0xc00f46cc in tracer_init (tr=<optimized out>, t=<optimized out>) at /PATH/kernel/trace/trace.c:4588
> #3  tracing_set_tracer (tr=0xc0cdd970 <global_trace>, buf=0xca347e18 "function_graph")
>     at /PATH/kernel/trace/trace.c:4849
> #4  0xc00f4868 in tracing_set_trace_write (filp=<optimized out>, ubuf=<optimized out>, cnt=3392437791, ppos=0xca347f18)
>     at /PATH/kernel/trace/trace.c:4887
> #5  0xc01b77c0 in __vfs_write (file=<optimized out>, p=<optimized out>, count=<optimized out>, pos=<optimized out>)
>     at /PATH/fs/read_write.c:510
> #6  0xc01b88ec in vfs_write (file=0xcd9e2000, buf=0x1011ff80 "function_graph\n", count=15, pos=0xca347f18)
>     at /PATH/fs/read_write.c:560
> #7  0xc01b9968 in SYSC_write (count=<optimized out>, buf=<optimized out>, fd=<optimized out>)
>     at /PATH/fs/read_write.c:607
> #8  SyS_write (fd=<optimized out>, buf=269614976, count=15) at /PATH/fs/read_write.c:599
> #9  0xc00127e4 in syscall_dotrace_cont () at /PATH/arch/powerpc/kernel/entry_32.S:353

And I've tried on "a7fac75 Linux 4.8.1" and the latest linux-4.8.y-rt-rebase branch.They have the same issue.

Zhe

>
> Zhe
>
>> -- Steve
>>

