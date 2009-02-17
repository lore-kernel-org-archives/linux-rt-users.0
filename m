From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [Announce] 2.6.29-rc4-rt2
Date: Tue, 17 Feb 2009 22:02:20 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0902172200520.5620@fbirervta.pbzchgretzou.qr>
References: alpine.LFD.2.00.0902122353050.16972@localhost.localdomain  <alpine.LSU.2.00.0902172104480.3930@fbirervta.pbzchgretzou.qr> <1234902258.13010.97.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Jon Masters <jonathan@jonmasters.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:36954 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649AbZBQVCW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2009 16:02:22 -0500
In-Reply-To: <1234902258.13010.97.camel@perihelion.bos.jonmasters.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tuesday 2009-02-17 21:24, Jon Masters wrote:

>On Tue, 2009-02-17 at 21:15 +0100, Jan Engelhardt wrote:
>
>> It happens to spew a warning (see full dmesg below)
>> and a call trace. Seems harmless otherwise, though.
>
>> ------------[ cut here ]------------
>> WARNING: at mm/highmem.c:225 kmap_flush_unused+0x1d/0x2c()
>> Hardware name: VMware Virtual Platform
>> Modules linked in:
>
>You removed the linked in module list? Either way, I'd love to see if
>this happens with vanilla. Do you actually have the VMWare modules
>loaded?

I removed nothing actually. At this point in time, there just _was_
no module loaded. This happened before initramfs even started.
(You see the "unpacking initramfs... done", do you? ;-)


Jan
