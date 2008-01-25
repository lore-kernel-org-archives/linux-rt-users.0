From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.24-rt1
Date: Sat, 26 Jan 2008 00:59:32 +0100
Message-ID: <479A77E4.2070800@gmx.net>
References: <1201299433.318.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53181 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754689AbYAZAFu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jan 2008 19:05:50 -0500
In-Reply-To: <1201299433.318.21.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> We are pleased to announce the 2.6.24-rt1 tree, which can be
> downloaded from the location:
>
>   http://rt.et.redhat.com/download/
>
>   
hallo list, i just compiled the new release on my laptop (ibm thinkpad 
r50e, debian testing) and im finiding this lines in dmesg:

...
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
system 00:00: iomem range 0x0-0x9ffff could not be reserved
system 00:00: iomem range 0xc0000-0xc3fff could not be reserved
system 00:00: iomem range 0xc4000-0xc7fff could not be reserved
system 00:00: iomem range 0xc8000-0xcbfff has been reserved
system 00:00: iomem range 0xcc000-0xcffff could not be reserved
system 00:00: iomem range 0x0-0x0 could not be reserved
system 00:00: iomem range 0x0-0x0 could not be reserved
system 00:00: iomem range 0x0-0x0 could not be reserved
system 00:00: iomem range 0xdc000-0xdffff has been reserved
system 00:00: iomem range 0xe0000-0xe3fff could not be reserved
system 00:00: iomem range 0xe4000-0xe7fff could not be reserved
system 00:00: iomem range 0xe8000-0xebfff could not be reserved
system 00:02: ioport range 0x1000-0x107f has been reserved
system 00:02: ioport range 0x1180-0x11bf has been reserved
system 00:02: ioport range 0x15e0-0x15ef has been reserved
system 00:02: ioport range 0x1600-0x167f has been reserved
...

i never saw this before, so could someone guess if i should be scared of it?

cheers,
doc
