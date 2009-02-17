From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: [Announce] 2.6.29-rc4-rt2
Date: Tue, 17 Feb 2009 15:24:18 -0500
Message-ID: <1234902258.13010.97.camel@perihelion.bos.jonmasters.org>
References: alpine.LFD.2.00.0902122353050.16972@localhost.localdomain  <alpine.LSU.2.00.0902172104480.3930@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:58744 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZBQUYj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2009 15:24:39 -0500
In-Reply-To: <alpine.LSU.2.00.0902172104480.3930@fbirervta.pbzchgretzou.qr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2009-02-17 at 21:15 +0100, Jan Engelhardt wrote:

> It happens to spew a warning (see full dmesg below)
> and a call trace. Seems harmless otherwise, though.

> ------------[ cut here ]------------
> WARNING: at mm/highmem.c:225 kmap_flush_unused+0x1d/0x2c()
> Hardware name: VMware Virtual Platform
> Modules linked in:

You removed the linked in module list? Either way, I'd love to see if
this happens with vanilla. Do you actually have the VMWare modules
loaded?

Jon.


