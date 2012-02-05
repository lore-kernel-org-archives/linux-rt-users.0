From: Raz <raziebe@gmail.com>
Subject: Re: preempt-rt: Real Time hogging task
Date: Sun, 5 Feb 2012 12:02:34 +0200
Message-ID: <CAPB=Z-qNCq9kuqsgrC5vdF9q4tpXnZuH+17c378GmaZD3P9FVQ@mail.gmail.com>
References: <CAPB=Z-r+3ht0Au3mvrUBQ7-g+r=QfLao19BF7n97662q52fxKg@mail.gmail.com>
 <1328191924.5882.86.camel@gandalf.stny.rr.com> <CAPB=Z-pbkg1mp+WFjQUAyWAU+c8CuM8WoAN4==h-FNVaZYJmzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51089 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab2BEKCz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Feb 2012 05:02:55 -0500
Received: by bkcjm19 with SMTP id jm19so4040672bkc.19
        for <linux-rt-users@vger.kernel.org>; Sun, 05 Feb 2012 02:02:54 -0800 (PST)
In-Reply-To: <CAPB=Z-pbkg1mp+WFjQUAyWAU+c8CuM8WoAN4==h-FNVaZYJmzQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

also, this is x86-32 machine with a single Celeron processor 1.5Ghz.

On Sun, Feb 5, 2012 at 11:57 AM, Raz <raziebe@gmail.com> wrote:
> Hey Steven
>
> This is the first time I try frace on this kernel. it turned out that
> when enabling
> ftrace kernel oops whenever one loads a module - see bellow.
> I debugged it a little and the null pointer is in =A0 trace_module_ad=
d_events
> in the loop , the call pointer is NULL.
>
> for_each_event(call, start, end) {
> =A0 call is null.
> }
>
> I will continue debugging it a bit more.
>
>
> =A0 =A04.137324] e100 0000:02:03.0: eth0: NIC Link is Up 100 Mbps Ful=
l Duplex
> [ =A0 =A05.180354] Disabling lock debugging due to kernel taint
> [ =A0 =A05.180792] BUG: unable to handle kernel NULL pointer derefere=
nce at =A0 (null)
> [ =A0 =A05.180799] IP: [<c1084f7c>] trace_module_notify+0x9c/0x160
> [ =A0 =A05.180810] *pde =3D 00000000
> [ =A0 =A05.180813] Oops: 0000 [#1] PREEMPT
> [ =A0 =A05.180818] Modules linked in: sercos_driver(O+)
> [ =A0 =A05.180822]
> [ =A0 =A05.180826] Pid: 1079, comm: modprobe Tainted: G =A0 =A0 =A0 =A0=
 =A0 O
> 3.2.0-rc5-rt8 #8 N/A =A0N/A /MODB
> [ =A0 =A05.180832] EIP: 0060:[<c1084f7c>] EFLAGS: 00010286 CPU: 0
> [ =A0 =A05.180836] EIP is at trace_module_notify+0x9c/0x160
> [ =A0 =A05.180839] EAX: de513f44 EBX: dfeecc60 ECX: de513e0c EDX: de5=
13e74
> [ =A0 =A05.180842] ESI: 00000000 EDI: de513edc EBP: de60df3c ESP: de6=
0df14
> [ =A0 =A05.180846] =A0DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
> [ =A0 =A05.180849] Process modprobe (pid: 1079, ti=3Dde60c000 task=3D=
de519030
> task.ti=3Dde60c000)
> [ =A0 =A05.180852] Stack:
> [ =A0 =A05.180854] =A0de513e74 de513f44 de513edc de513f44 de513e0c de=
513e74
> 7fbb1b30 c14578b0
> [ =A0 =A05.180859] =A000000000 c14563a0 de60df58 c1055ba5 dfeecc60 00=
000001
> c1455d50 00000001
> [ =A0 =A05.180865] =A0dfeecc60 de60df78 c1055ee3 fffffffd 00000000 00=
000000
> dfeecc60 0000223f
> [ =A0 =A05.180870] Call Trace:
> [ =A0 =A05.180878] =A0[<c1055ba5>] notifier_call_chain+0x45/0x60
> [ =A0 =A05.180883] =A0[<c1055ee3>] __blocking_notifier_call_chain+0x4=
3/0x70
> [ =A0 =A05.180888] =A0[<c1055f2f>] blocking_notifier_call_chain+0x1f/=
0x30
> [ =A0 =A05.180893] =A0[<c1069682>] sys_init_module+0x62/0x1c0
> [ =A0 =A05.180900] =A0[<c10c32c1>] ? sys_close+0x71/0xc0
> [ =A0 =A05.180906] =A0[<c13441e1>] syscall_call+0x7/0xb
> [ =A0 =A05.180909] Code: 00 8d 90 44 01 00 00 83 c0 74 89 55 e4 89 45=
 ec
> 8d b4 26 00 00 00 00 8b 45 e4 8b 55 ec 89 7c 24 08 8b 4d e8 89 44 24
> 04 89 14 24
>
>
> On Thu, Feb 2, 2012 at 4:12 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>> On Thu, 2012-02-02 at 12:52 +0200, Raz wrote:
>>> hey
>>>
>>> I am trying to understand why a user space MT process behaves in an
>>> unexpected manner.
>>> I have real time process, which executes most of its threads in RT =
priority,
>>> and from time to time a task ( medium priority ) is executing witho=
ut
>>> trying to stop.
>>>
>>> There are times, that this task is hogging the entire process and n=
o
>>> other **higher*** rt priority
>>> task is getting any cpu time.
>>>
>>> Linux is **not** getting hogged. when setting the serial console (
>>> irq/serial ) and its shell ( /bin/sh )
>>> to a higher priority linux is responsive.
>>>
>>> Observing the task list =A0through ps command i can see that this t=
ask's
>>> threads when
>>> to un-interruptible sleep.
>>>
>>> Any idea why is it happening ?
>>
>> Some ideas, but I need a lot more information.
>>
>>> kernel is 3.2.0-rc5-rt8.
>>
>> Is this a x86 box?
>>
>> Can you run a trace on the task that is going berserk?
>>
>> Enable CONFIG_FUNCTION_TRACER in your kernel and do the following:
>>
>> # mount -t debugfs nodev /sys/kernel/debug
>> # cd /sys/kernel/debug/tracing
>> # echo <pid-of-berserk-task> > set_ftrace_pid
>> # echo function > current_tracer
>> # cat trace
>>
>> Thanks!
>>
>> -- Steve
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
