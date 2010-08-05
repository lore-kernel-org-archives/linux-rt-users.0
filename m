From: "Simpson, John (UK) (Contractor)" <john.simpson@mbda-systems.com>
Subject: RE: 2.6.18-rt7 on HP Z800
Date: Thu, 5 Aug 2010 09:09:00 +0100
Message-ID: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B23C@CARACALQ005.caracal01.greenstream.priv>
References: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B238@CARACALQ005.caracal01.greenstream.priv>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail178.messagelabs.com ([85.158.139.19]:53196 "EHLO
	mail178.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296Ab0HEIIf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Aug 2010 04:08:35 -0400
Received: from partner2.mbda.co.uk (partner2.mbda.co.uk [10.15.19.9])
	by smtp1.mbda.co.uk (Switch-3.4.3/Switch-3.4.3) with ESMTP id o75803wY001238
	for <linux-rt-users@vger.kernel.org>; Thu, 5 Aug 2010 09:00:04 +0100
Received: from mbdexstv005.caracal01.greenstream.priv ([10.15.19.4])
	by partner2.mbda.co.uk (Switch-3.4.3/Switch-3.4.3) with ESMTP id o75877uS015595
	for <linux-rt-users@vger.kernel.org>; Thu, 5 Aug 2010 09:07:07 +0100
Content-class: urn:content-classes:message
In-Reply-To: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B238@CARACALQ005.caracal01.greenstream.priv>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 
I've had no response to this question. Can anyone help? I'm also baffled
as to why the smp_affinity stuff doesn't work.

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org
[mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Simpson, John
(UK) (Contractor)
Sent: 04 August 2010 09:30
To: linux-rt-users@vger.kernel.org
Subject: 2.6.18-rt7 on HP Z800


               *** WARNING ***

This mail has originated outside your organization, either from an
external partner or the Global Internet. 
     Keep this in mind if you answer this message. 

As previously posted, I'm using 2.6.18 for compatibility with third
party drivers for an FPGA card. This a scene-generation app using an
Nvidia Quadro FX5800 requiring a high-frame rate with no dropped frames;
hence the need for RT (we've had previous success using proprietary
stuff but thought we'd give this a go).
 
It's working fine (with very occasional crashes, most of which seem to
have been referred to in later RT kernel fixes, but we can put up with
it).
 
Some notes for posterity:
 
    Turn off irqbalance service
    Deselect power management stuff in kernel
    Select SATA IDE emulation in BIOS (otherwise no SCSI/CD stuff)
    Rebuilt Broadcom tg3 and set pci=nomsi for network drivers to
function
    isolcpus used on boot
    App run on isolated cpus using 'taskset'
        
Like I said, it works fine, I haven't seen any dropped frames yet, but
there's stuff I don't understand from using other RT OSs...
 
    All interrupts run on CPU0, all the time, there's no requirement to
use smp_affinity, in fact if you do the whole thing grinds to a halt.  I
guess this is fine.
    The isolcpus option seems to work fine except for the following
running on all eight CPUs:
        migration
        posix_cpu_timer
        softirq-high
        softirq-timer
        softirq-net-tx
        softirq-net-rx
        softirq-block
        softirq-tasklet
        softirq-hrtimer
        softirq-rcu
        watchdog
        desched
        aio
        cqueue
        kblockd
        events
 
    I guess this is preemptible stuff which must run per cpu, but
there's a bit in a Red Hat page
http://rt.et.redhat.com/wiki/index.php?title=RHEL-RT_AffinityHowto&print
able=yes (starting "In MRG Realtime") which apparently refers to these
elements in their RT kernel suggesting that these should be dealt with
(but then doesn't seem to say how).  Do I need to do anything about
these processes?
 
Thanks
 
John
 

********************************************************************
This email and any attachments are confidential to the intended
recipient and may also be privileged. If you are not the intended
recipient please delete it from your system and notify the sender. You
should not copy it or use it for any purpose nor disclose or distribute
its contents to any other person. 

MBDA UK Limited, a company registered in England and Wales, registration
number 3144919 whose registered office is at Six Hills Way, Stevenage,
Hertfordshire, SG1 2DA, England.
********************************************************************

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe
linux-rt-users" in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
