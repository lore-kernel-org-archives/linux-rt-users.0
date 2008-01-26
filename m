From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rt1
Date: Sat, 26 Jan 2008 00:08:27 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801260008090.22141@gandalf.stny.rr.com>
References: <1201299433.318.21.camel@localhost.localdomain> <479A77E4.2070800@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:59127 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYAZFJu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 26 Jan 2008 00:09:50 -0500
In-Reply-To: <479A77E4.2070800@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sat, 26 Jan 2008, Dragan Noveski wrote:
> >
> hallo list, i just compiled the new release on my laptop (ibm thinkpad
> r50e, debian testing) and im finiding this lines in dmesg:
>
> ....
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
> report
> system 00:00: iomem range 0x0-0x9ffff could not be reserved
> system 00:00: iomem range 0xc0000-0xc3fff could not be reserved
> system 00:00: iomem range 0xc4000-0xc7fff could not be reserved
> system 00:00: iomem range 0xc8000-0xcbfff has been reserved
> system 00:00: iomem range 0xcc000-0xcffff could not be reserved
> system 00:00: iomem range 0x0-0x0 could not be reserved
> system 00:00: iomem range 0x0-0x0 could not be reserved
> system 00:00: iomem range 0x0-0x0 could not be reserved
> system 00:00: iomem range 0xdc000-0xdffff has been reserved
> system 00:00: iomem range 0xe0000-0xe3fff could not be reserved
> system 00:00: iomem range 0xe4000-0xe7fff could not be reserved
> system 00:00: iomem range 0xe8000-0xebfff could not be reserved
> system 00:02: ioport range 0x1000-0x107f has been reserved
> system 00:02: ioport range 0x1180-0x11bf has been reserved
> system 00:02: ioport range 0x15e0-0x15ef has been reserved
> system 00:02: ioport range 0x1600-0x167f has been reserved
> ....
>
> i never saw this before, so could someone guess if i should be scared of it?
>

Do you see the same with vanilla 2.6.24?

-- Steve
