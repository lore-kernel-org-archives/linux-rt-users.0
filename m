From: Raz <raziebe@gmail.com>
Subject: Re: preempt-rt: Real Time hogging task
Date: Sun, 5 Feb 2012 11:57:16 +0200
Message-ID: <CAPB=Z-pbkg1mp+WFjQUAyWAU+c8CuM8WoAN4==h-FNVaZYJmzQ@mail.gmail.com>
References: <CAPB=Z-r+3ht0Au3mvrUBQ7-g+r=QfLao19BF7n97662q52fxKg@mail.gmail.com>
 <1328191924.5882.86.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46600 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab2BEJ5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Feb 2012 04:57:37 -0500
Received: by bkcjm19 with SMTP id jm19so4039411bkc.19
        for <linux-rt-users@vger.kernel.org>; Sun, 05 Feb 2012 01:57:36 -0800 (PST)
In-Reply-To: <1328191924.5882.86.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Steven

This is the first time I try frace on this kernel. it turned out that
when enabling
ftrace kernel oops whenever one loads a module - see bellow.
I debugged it a little and the null pointer is in   trace_module_add_ev=
ents
in the loop , the call pointer is NULL.

for_each_event(call, start, end) {
   call is null.
}

I will continue debugging it a bit more.


    4.137324] e100 0000:02:03.0: eth0: NIC Link is Up 100 Mbps Full Dup=
lex
[    5.180354] Disabling lock debugging due to kernel taint
[    5.180792] BUG: unable to handle kernel NULL pointer dereference at=
   (null)
[    5.180799] IP: [<c1084f7c>] trace_module_notify+0x9c/0x160
[    5.180810] *pde =3D 00000000
[    5.180813] Oops: 0000 [#1] PREEMPT
[    5.180818] Modules linked in: sercos_driver(O+)
[    5.180822]
[    5.180826] Pid: 1079, comm: modprobe Tainted: G           O
3.2.0-rc5-rt8 #8 N/A  N/A /MODB
[    5.180832] EIP: 0060:[<c1084f7c>] EFLAGS: 00010286 CPU: 0
[    5.180836] EIP is at trace_module_notify+0x9c/0x160
[    5.180839] EAX: de513f44 EBX: dfeecc60 ECX: de513e0c EDX: de513e74
[    5.180842] ESI: 00000000 EDI: de513edc EBP: de60df3c ESP: de60df14
[    5.180846]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[    5.180849] Process modprobe (pid: 1079, ti=3Dde60c000 task=3Dde5190=
30
task.ti=3Dde60c000)
[    5.180852] Stack:
[    5.180854]  de513e74 de513f44 de513edc de513f44 de513e0c de513e74
7fbb1b30 c14578b0
[    5.180859]  00000000 c14563a0 de60df58 c1055ba5 dfeecc60 00000001
c1455d50 00000001
[    5.180865]  dfeecc60 de60df78 c1055ee3 fffffffd 00000000 00000000
dfeecc60 0000223f
[    5.180870] Call Trace:
[    5.180878]  [<c1055ba5>] notifier_call_chain+0x45/0x60
[    5.180883]  [<c1055ee3>] __blocking_notifier_call_chain+0x43/0x70
[    5.180888]  [<c1055f2f>] blocking_notifier_call_chain+0x1f/0x30
[    5.180893]  [<c1069682>] sys_init_module+0x62/0x1c0
[    5.180900]  [<c10c32c1>] ? sys_close+0x71/0xc0
[    5.180906]  [<c13441e1>] syscall_call+0x7/0xb
[    5.180909] Code: 00 8d 90 44 01 00 00 83 c0 74 89 55 e4 89 45 ec
8d b4 26 00 00 00 00 8b 45 e4 8b 55 ec 89 7c 24 08 8b 4d e8 89 44 24
04 89 14 24


On Thu, Feb 2, 2012 at 4:12 PM, Steven Rostedt <rostedt@goodmis.org> wr=
ote:
> On Thu, 2012-02-02 at 12:52 +0200, Raz wrote:
>> hey
>>
>> I am trying to understand why a user space MT process behaves in an
>> unexpected manner.
>> I have real time process, which executes most of its threads in RT p=
riority,
>> and from time to time a task ( medium priority ) is executing withou=
t
>> trying to stop.
>>
>> There are times, that this task is hogging the entire process and no
>> other **higher*** rt priority
>> task is getting any cpu time.
>>
>> Linux is **not** getting hogged. when setting the serial console (
>> irq/serial ) and its shell ( /bin/sh )
>> to a higher priority linux is responsive.
>>
>> Observing the task list =A0through ps command i can see that this ta=
sk's
>> threads when
>> to un-interruptible sleep.
>>
>> Any idea why is it happening ?
>
> Some ideas, but I need a lot more information.
>
>> kernel is 3.2.0-rc5-rt8.
>
> Is this a x86 box?
>
> Can you run a trace on the task that is going berserk?
>
> Enable CONFIG_FUNCTION_TRACER in your kernel and do the following:
>
> # mount -t debugfs nodev /sys/kernel/debug
> # cd /sys/kernel/debug/tracing
> # echo <pid-of-berserk-task> > set_ftrace_pid
> # echo function > current_tracer
> # cat trace
>
> Thanks!
>
> -- Steve
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
