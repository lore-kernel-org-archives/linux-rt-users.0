From: "Simpson, John (UK) (Contractor)" <john.simpson@mbda-systems.com>
Subject: 2.6.18-rt7 on HP Z800
Date: Wed, 4 Aug 2010 09:29:53 +0100
Message-ID: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B238@CARACALQ005.caracal01.greenstream.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail189.messagelabs.com ([85.158.139.179]:12296 "EHLO
	mail189.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab0HDI30 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Aug 2010 04:29:26 -0400
Received: from partner1.mbda.co.uk (partner1.mbda.co.uk [10.15.19.7])
	by smtp2.mbda.co.uk (Switch-3.4.3/Switch-3.4.3) with ESMTP id o748OkYY004279
	for <linux-rt-users@vger.kernel.org>; Wed, 4 Aug 2010 09:24:46 +0100
Received: from caracals314.caracal01.greenstream.priv ([10.180.6.51])
	by partner1.mbda.co.uk (Switch-3.4.3/Switch-3.4.3) with ESMTP id o748TPFj021970
	for <linux-rt-users@vger.kernel.org>; Wed, 4 Aug 2010 09:29:25 +0100
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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
This email and any attachments are confidential to the intended recipient and may also be privileged. If you are not the intended recipient please delete it from your system and notify the sender. You should not copy it or use it for any purpose nor disclose or distribute its contents to any other person. 

MBDA UK Limited, a company registered in England and Wales, registration number 3144919 whose registered office is at Six Hills Way, Stevenage, Hertfordshire, SG1 2DA, England.
********************************************************************

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
