From: Yang Shi <yang.shi@windriver.com>
Subject: Re: 4.8.6-rt5 ftrace function_graph hangs
Date: Fri, 18 Nov 2016 10:36:49 -0800
Message-ID: <4315c9ac-47cb-7218-027c-039a0cbfa548@windriver.com>
References: <d275a464-c787-6e21-0d3f-bbb3d854176e@windriver.com>
 <20161118113524.43f6ff3c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <tglx@linutronix.de>, <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, He Zhe <zhe.he@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64536 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbcKRShF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Nov 2016 13:37:05 -0500
In-Reply-To: <20161118113524.43f6ff3c@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/18/2016 8:35 AM, Steven Rostedt wrote:
> On Fri, 18 Nov 2016 14:23:24 +0800
> He Zhe <zhe.he@windriver.com> wrote:
>
>> Hi,
>>
>> I'm using 4.8.6-rt5 and find the following issue on nxp-t4xxx board/qemuppc/qemux86-64.
>> When executing "echo function_graph > /sys/kernel/debug/tracing/current_tracer" the system hangs.
>> I traced the kernel to where it dies but don't know how to fix. Please help. Thank you.
>>
>> (gdb) b ftrace_startup
>>
>> ...
>>
>> Run till exit from #0 ftrace_startup (ops=0xc0cf1704 <graph_ops>, command=8) at /PATH/TO/kernel/trace/ftrace.c:2653
>> 0xc00eb768 in register_ftrace_graph (retfunc=0xc010186c <trace_graph_return>, entryfunc=0xc01014c4 <trace_graph_entry>)
>>      at /PATH/TO/kernel-source/kernel/trace/ftrace.c:5908
>> 5908 ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
>> Value returned is $1 = 0
>> (gdb) l
>> 5903 */
>> 5904 __ftrace_graph_entry = entryfunc;
>> 5905 ftrace_graph_entry = ftrace_graph_entry_test;
>> 5906 update_function_graph_func();
>> 5907
>> 5908 ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
>> 5909 out:
>> 5910 mutex_unlock(&ftrace_lock);
>> 5911 return ret;
>> 5912 }
>> (gdb) n
>> 5910 mutex_unlock(&ftrace_lock);
>> (gdb) n
>>
>> hangs...
>>

Hi Steve,

> Can't you get a backtrace from this? It's running under qemu right? So
> it should be able to break it and see where it is at.
>
> Note, my PowerPC box has just died, so I'm no longer able to work on
> it, and don't have time to set up a qemu ppc image at the moment.

We found this issue on x86 too. It is not PPC specific problem.

Thanks,
Yang

>
> -- Steve


