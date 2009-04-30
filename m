From: Stefan Agner <stefan.agner@yahoo.com>
Subject: Re: Ethernet communication from real time thread
Date: Thu, 30 Apr 2009 16:14:34 -0700 (PDT)
Message-ID: <971214.98609.qm@web59809.mail.ac4.yahoo.com>
References: <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from n7.bullet.mail.ac4.yahoo.com ([76.13.13.235]:45825 "HELO
	n7.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750981AbZD3XOf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 19:14:35 -0400
In-Reply-To: <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Mathias,


From: M. Koehrer <mathias_koehrer@arcor.de>>
> My questions are now:
> A call of send() in my user space application to transmit a UDP message 
> ends up in the network stack of Linux.
> Which real time priority will be used in the network stack?
When you make a system call (e.g. socket) then your system call is 
processed in the same thread as your application is running... Just in kernel
space
> Is it the priority of the user space thread that is calling send()?
Therefor, yes!
> Or is it the priority of the kernel thread [sirq-net-tx/3]?
Yes too, because your network packet will be put in a queue, which
is processed by sirq-net-tx. (Altough, on my system sending packet
are processed by sirq-net-rx, it might be a bug...)

> On the receive side (calling recv()):
> Which threads are relevant here?
> IRQ-XX for the NIC's irq thread, [sirq-net-rx/3] or also the user space 
> thread that is calling recv()?
Your IRQ-XX thread is relevant too. Interrupts can be shared, and they
are first dispatched by this IRQ-XX thread, which then calls
the sirq-net-rx. So you need to prioritize both threads... And you're 
final reciption thread too...

To be sure that you take the right IRQ-XX thread you can look up which
IRQ is used by your network card by invoking this: 
cat /proc/interrupts

To be sure you took every thread which is used by your application you 
can do a function trace, or a scheduling trace, which might be less verbose.
You need to enable that in your kernel (onder kernel hacking, Tracers...)

Mount you're debug fs:
sudo mount -t debugfs debugfs /debug

Get available tracers
cat /debug/tracing/available_tracers

Enable one and do a the trace, while you're app is running:
echo sched_switch > /debug/tracing/current_tracer
echo 1 > /debug/tracing/tracing_enabled
wait a short while
echo 0 > /debug/tracing/tracing_enabled
cat /debug/tracing/trace > /tmp/yourtrace

Thats how i understand the thing atm, Im pretty new to preempt rt and linux 
kernel hacking too, so some of my explanations might be wrong... :-)

I send network packets with preempt rt too, it might be interessting to
share some expirences... With which frequency do you send packets? 
Does it happen for you that you're top is somehow messed up? I use to have 
different cpu usages each time i start my application... It seems that the
scheduler has some problems with short period tasks, networking and 
accounting...


Bye
Stefan



      

