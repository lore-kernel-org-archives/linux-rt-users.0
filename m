From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Shared interrupts and RT question
Date: Mon, 10 Dec 2012 03:22:26 -0800
Message-ID: <73621A3E-9310-43ED-92EB-4759BF977AA5@thebigcorporation.com>
References: <50C5C0BD.9010600@meduna.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:37395 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2LJLWk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Dec 2012 06:22:40 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1197775dak.19
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Dec 2012 03:22:39 -0800 (PST)
In-Reply-To: <50C5C0BD.9010600@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Dec 10, 2012, at 3:00 AM, Stanislav Meduna <stano@meduna.org> wrote:

> Hi,
> 
> I have a machine that puts several interrupts on one interrupt
> line. As these are generally headless embedded machines bought
> and installed by the customer, it is a bit problematic to tweak
> the BIOS to assign them in an optimal way.
> 
> Now I am seeing latencies such as
> 
> Wakeup shared prio
> 385 50 638 (0) irq/15-eth1 <- 28 50 irq/15-ata_piix 5147.373113
> #Minimum latency: 1 microseconds
> #Average latency: 4 microseconds
> #Maximum latency: 638 microseconds
> 
> I don't care about the ATA, but eth1 is important. Is it
> enough to adjust the priorities of the kernel threads
> or are shared interrupts generally a recipe for problems
> in the RT_FULL world?
> 

I think that the worst-case would occur when the eth1 irq is asserted right after the system has vectored to the ATA handler.

I am not sure about the current state of things, but in the past, a shared IRQ line would not process another iRQ until the first one completes.

To work around it, the ATA code must be modified to turn off the IRQ assert at the chip (this may have already been done)

Sven

