From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Re: idle task starvation with rt patch
Date: Thu, 7 May 2009 18:45:08 +0530
Message-ID: <921ca19c0905070615v59a36a17q71eb89e5cbe3da8f@mail.gmail.com>
References: <b79371120905061247o72198a1ak6b4527ebfb60098a@mail.gmail.com>
	 <4A01FB5E.1000006@us.ibm.com>
	 <b79371120905061519qd90401boedccfd39ff7f21eb@mail.gmail.com>
	 <4A021AB6.3090807@us.ibm.com>
	 <921ca19c0905062229l5302c6d0v69bb54b7cc92f35f@mail.gmail.com>
	 <b79371120905070601j60ad1801u65c4ed66a6ccc8f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: David L <idht4n@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:43669 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbZEGNPI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 May 2009 09:15:08 -0400
Received: by wf-out-1314.google.com with SMTP id 26so704100wfd.4
        for <linux-rt-users@vger.kernel.org>; Thu, 07 May 2009 06:15:08 -0700 (PDT)
In-Reply-To: <b79371120905070601j60ad1801u65c4ed66a6ccc8f7@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 7, 2009 at 6:31 PM, David L <idht4n@gmail.com> wrote:
> On Wed, May 6, 2009 at 10:29 PM, Sujit Karataparambil wrote:

> I'm not sure I understand this question, but I'll try to
> answer it anyway. =A0There is one process with a handful
> of SCHED_FIFO-scheduled threads. =A0The highest
> priority one blocks on a read from a driver that interfaces
> with an FPGA and wakes up every ~950 microseconds.
> It seems to consume about 250 microseconds per
> msec using the mainline kernel. =A0That thread can tolerate
> frequent delays of a few msec with a rare delay of up to
> about 7 msec... after that, we lose track of the RF
> signals we're tracking.

Why cannot you have mutiple threads for SCHED_FIFO?
Say you could have one process with the Highest Priority alone on an
low priority process. With the other matching process as per
their priority requirements? Using shared memory.

This requires a lot of R&D in terms of sleep issued on the application?

>
> There are a few lower priority threads that do some
> processing of the data demodulated by the highest
> priority thread. =A0Those have relatively soft real-time
> requirements. =A0Earlier I said they needed a second
> of CPU time every few seconds. =A0Really, it's probably
> more like a second every 5 seconds.

I think this might not be a problem? After the First Step is taken?

>
>> Whether it can be changed to get the current
>> application running?
> I don't think so, but I haven't exhaustively tried different
> priorities. =A0I've just tried a few that seem reasonable. =A0I know
> it doesn't work with the same priority levels for which it works
> almost perfectly without the real-time patches. =A0And I know it
> doesn't work after lowering all of the priorities such that only
> one is above 50. =A0The symptom is 2x higher CPU loading
> relative to the non-real-time-patched kernel.

Is the Processor supporting SMP? or Does it have SMP Capabilities?
>> Also What is the Specific part to PPC32 and PPC64?
> PPC32 (specifically, an MPC5200)

http://kerneltrap.org/Linux/Balancing_Real_Time_Threads


> Without the real-time patch applied, I used top to watch the CPU
> consumption per thread. =A0I also used the kernel sched_switch
> tracing tool and the application monitors its own CPU usage
> using clock_gettime with a clock initialized by pthread_getcpuclockid=
=2E
> With the real-time patch applied, top doesn't run the way I usually
> run it because the CPU is starved. =A0I guess I could run top at a
> high priority, but I haven't tried that. =A0But the kernel trace I sh=
owed
> with the original email shows what is running when, and it shows
> that the CPU is never idle.

http://kerneltrap.org/Linux/Balancing_Real_Time_Threads


> I guess it depends on the exact definition. =A0The thread that
> interacts with the FPGA needs to read the FGPA data typically
> within say 2-3 msec with a rare excursion to =A0~7 msec.
> The mainline kernel does this under most conditions but it seems
> like it just barely makes it and some small changes to the system can
> cause us to miss those deadlines.

Could the data be preread or part of it during boot/initialization.

--=20
-- Sujit K M
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
