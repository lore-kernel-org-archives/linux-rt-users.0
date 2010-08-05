From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: 2.6.18-rt7 on HP Z800
Date: Thu, 05 Aug 2010 07:52:11 -0700
Message-ID: <4C5AD01B.8060108@us.ibm.com>
References: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B238@CARACALQ005.caracal01.greenstream.priv>  <3E7FA6409BDA204EA3CF733DE7E0B0E10326B23C@CARACALQ005.caracal01.greenstream.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Simpson, John (UK) (Contractor)" <john.simpson@mbda-systems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:37852 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759126Ab0HEOwP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Aug 2010 10:52:15 -0400
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o75EhaMJ016323
	for <linux-rt-users@vger.kernel.org>; Thu, 5 Aug 2010 08:43:36 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o75EptMl158652
	for <linux-rt-users@vger.kernel.org>; Thu, 5 Aug 2010 08:51:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o75EpjAg004039
	for <linux-rt-users@vger.kernel.org>; Thu, 5 Aug 2010 08:51:45 -0600
In-Reply-To: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B23C@CARACALQ005.caracal01.greenstream.priv>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/05/2010 01:09 AM, Simpson, John (UK) (Contractor) wrote:
>
> I've had no response to this question. Can anyone help? I'm also baffled
> as to why the smp_affinity stuff doesn't work.
>
> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org
> [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Simpson, John
> (UK) (Contractor)
> Sent: 04 August 2010 09:30
> To: linux-rt-users@vger.kernel.org
> Subject: 2.6.18-rt7 on HP Z800
>
>
>                 *** WARNING ***
>
> This mail has originated outside your organization, either from an
> external partner or the Global Internet.
>       Keep this in mind if you answer this message.
>
> As previously posted, I'm using 2.6.18 for compatibility with third
> party drivers for an FPGA card. This a scene-generation app using an
> Nvidia Quadro FX5800 requiring a high-frame rate with no dropped frames;
> hence the need for RT (we've had previous success using proprietary
> stuff but thought we'd give this a go).
>
> It's working fine (with very occasional crashes, most of which seem to
> have been referred to in later RT kernel fixes, but we can put up with
> it).
>
> Some notes for posterity:
>
>      Turn off irqbalance service
>      Deselect power management stuff in kernel
>      Select SATA IDE emulation in BIOS (otherwise no SCSI/CD stuff)
>      Rebuilt Broadcom tg3 and set pci=nomsi for network drivers to
> function
>      isolcpus used on boot
>      App run on isolated cpus using 'taskset'
>
> Like I said, it works fine, I haven't seen any dropped frames yet, but
> there's stuff I don't understand from using other RT OSs...
>
>      All interrupts run on CPU0, all the time, there's no requirement to
> use smp_affinity, in fact if you do the whole thing grinds to a halt.  I
> guess this is fine.
>      The isolcpus option seems to work fine except for the following
> running on all eight CPUs:
>          migration
>          posix_cpu_timer
>          softirq-high
>          softirq-timer
>          softirq-net-tx
>          softirq-net-rx
>          softirq-block
>          softirq-tasklet
>          softirq-hrtimer
>          softirq-rcu
>          watchdog
>          desched
>          aio
>          cqueue
>          kblockd
>          events
>
>      I guess this is preemptible stuff which must run per cpu, but
> there's a bit in a Red Hat page
> http://rt.et.redhat.com/wiki/index.php?title=RHEL-RT_AffinityHowto&print
> able=yes (starting "In MRG Realtime") which apparently refers to these
> elements in their RT kernel suggesting that these should be dealt with
> (but then doesn't seem to say how).  Do I need to do anything about
> these processes?

 From the above, everything is working and you are not actually having
an issue, but your only question is whether that latter list of tasks
is something you need to do something about? If that's teh case, my
answer would be no -- those are per-cpu activities which are monitoring
things on that cpu.

What the RH page is referring to is binding hard interrupts to certain
CPUs (by echoing a bitmask selecting that CPU/ or a set of CPUs into the
/proc/irq/#/smp_affinity field. Also pin your applications to appropriate
CPUs using the taskset utility as described on that page.

All the above really underlines is the need to architect your real-time
solution from the top-down, and take the entire system into account, to
help meet real-time guarantees.

Hope that helps...

thanks,
Nivedita

