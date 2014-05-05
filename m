From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [RFC PATCH RT] netconsole: enable netconsole on PREEMPT_RT
Date: Mon, 05 May 2014 16:10:51 -0300
Message-ID: <5367E23B.7060908@redhat.com>
References: <31fa5b74f8e6267f9b7f906c791d1ddf7d550771.1398788759.git.bristot@redhat.com> <536256EC.1060909@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <536256EC.1060909@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 05/01/2014 11:15 AM, Paul Gortmaker wrote:
> Chances are the two real targets above were using the
> same igb network driver.  I wonder if it matters what
> underlying nic is used for netconsole?

These three machines are using different drivers:

+----------+------------+
| Machine  | Nic Module |
+----------+------------+
| Xeon     | tg3        |
| core i5  | r8169      |
| KVM VM   | virtio_net |
+----------+------------+

Netconsole uses the function netpoll_send_udp to send a packet,
and netpool_send_udp calls the driver's ".ndo_start_xmit" function.
So it end up calling the NIC driver, but it's not "hardware 
dependent".
 
> It is probably worthwhile to do some data mining into why
> it was disabled in the 1st place.  I can't say I recall, and
> it is possible that the reason has long since become irrelevant,
> even though the patch has been carried forward over time.

Figure out why it was disabled is one objective of this RFC :-).
I did not found any message about some error of netconsole on RT 
kernel. I enabled the netconsole waiting for some obscure bug,
but surprisingly it always worked fine.

> Or it may be that your testing simply doesn't cover the use
> case where netconsole will spew sleeping while atomic...

In order to test netconsole, I developed a (very simple) module to call
the printk using the sysfs interface [1]. This module creates a sysfs
file that calls printk passing the wrote message as the printk message. 

This module runs in 4 execution modes:
[n]one:     call printk
[i]rq:      call printk inside an irq disabled section
[p]reempt:  call printk inside a preempt disabled section
[x]:        call printk alternating the above modes

I ran the tests injecting printk using this four modes, using
concurrent threads, for example one thread per core injecting printk.

The point is, when the printk is called, firstly it stores the
message in the log buffer, and then it try to grab the console lock to
print the messages to the registered consoles. To grab the console
lock, printk calls the function console_trylock_for_printk. This
function, on a kernel configured with PREEMPT_RT_FULL, will check
if the system is in atomic. If the system is in atomic, it will fail,
and printk will not call the console drivers (this test is
implemented on patch printk-rt-aware.patch). The message will be
be printed to the console after, by a kworker, calling the
netconsole on the preemptive context. This is another good thing
for the RT kernel, as it can't be called inside an atomic section,
and it didn't disables the preemption and IRQs, it does not add a
possible point of latency.

[1] http://bristot.eti.br/files/netconsole/printk_inject.tar.gz

-- Daniel Bristot
