From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: 2.6.18-rt7 on HP Z800
Date: Thu, 05 Aug 2010 01:50:03 -0700
Message-ID: <4C5A7B3B.5030506@gmail.com>
References: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B238@CARACALQ005.caracal01.greenstream.priv> <3E7FA6409BDA204EA3CF733DE7E0B0E10326B23C@CARACALQ005.caracal01.greenstream.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Simpson, John (UK) (Contractor)" <john.simpson@mbda-systems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53984 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab0HEIuI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Aug 2010 04:50:08 -0400
Received: by gxk23 with SMTP id 23so2418794gxk.19
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Aug 2010 01:50:07 -0700 (PDT)
In-Reply-To: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B23C@CARACALQ005.caracal01.greenstream.priv>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/05/2010 01:09 AM, Simpson, John (UK) (Contractor) wrote:
>  
> I've had no response to this question. Can anyone help? I'm also baffled
> as to why the smp_affinity stuff doesn't work.
>
>   

2.6.18. So that was as Pi was being merged, but HRT wasn't merged yet?


And NVIDIA didn't care about RT, that really didn't happen till MRG.

And there was also work being done on cpusets at the time.

To say the least, you have a lifetime's worth of back-porting to do.

I would suggest referencing a MontaVista 2.6.18 Kernel for your bug fixes.
Deepak was still there and did a good job keeping up with the patches.

Next option, move to 2.6.24, that was VERY well tested, and by then the cpu
shielding business was getting mainstream, and all the things you
mention should work pretty well.

I for one spent 3 years of my life bogged on a 2.6.22RT Kernel, and am
sure glad to be done with that.

Cheers.

Sven

> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org
> [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Simpson, John
> (UK) (Contractor)
> Sent: 04 August 2010 09:30
> To: linux-rt-users@vger.kernel.org
> Subject: 2.6.18-rt7 on HP Z800
>
>
>                *** WARNING ***
>
> This mail has originated outside your organization, either from an
> external partner or the Global Internet. 
>      Keep this in mind if you answer this message. 
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
>     Turn off irqbalance service
>     Deselect power management stuff in kernel
>     Select SATA IDE emulation in BIOS (otherwise no SCSI/CD stuff)
>     Rebuilt Broadcom tg3 and set pci=nomsi for network drivers to
> function
>     isolcpus used on boot
>     App run on isolated cpus using 'taskset'
>         
> Like I said, it works fine, I haven't seen any dropped frames yet, but
> there's stuff I don't understand from using other RT OSs...
>  
>     All interrupts run on CPU0, all the time, there's no requirement to
> use smp_affinity, in fact if you do the whole thing grinds to a halt.  I
> guess this is fine.
>     The isolcpus option seems to work fine except for the following
> running on all eight CPUs:
>         migration
>         posix_cpu_timer
>         softirq-high
>         softirq-timer
>         softirq-net-tx
>         softirq-net-rx
>         softirq-block
>         softirq-tasklet
>         softirq-hrtimer
>         softirq-rcu
>         watchdog
>         desched
>         aio
>         cqueue
>         kblockd
>         events
>  
>     I guess this is preemptible stuff which must run per cpu, but
> there's a bit in a Red Hat page
> http://rt.et.redhat.com/wiki/index.php?title=RHEL-RT_AffinityHowto&print
> able=yes (starting "In MRG Realtime") which apparently refers to these
> elements in their RT kernel suggesting that these should be dealt with
> (but then doesn't seem to say how).  Do I need to do anything about
> these processes?
>  
> Thanks
>  
> John
>  
>
> ********************************************************************
> This email and any attachments are confidential to the intended
> recipient and may also be privileged. If you are not the intended
> recipient please delete it from your system and notify the sender. You
> should not copy it or use it for any purpose nor disclose or distribute
> its contents to any other person. 
>
> MBDA UK Limited, a company registered in England and Wales, registration
> number 3144919 whose registered office is at Six Hills Way, Stevenage,
> Hertfordshire, SG1 2DA, England.
> ********************************************************************
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email 
> ______________________________________________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

