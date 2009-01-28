From: Claus Gindhart <claus.gindhart@kontron.com>
Subject: Re: Realtime capability of ioctl() vs. read() and write()
Date: Wed, 28 Jan 2009 15:15:57 +0100
Message-ID: <200901281515.57813.claus.gindhart@kontron.com>
References: <200901280834.28139.claus.gindhart@kontron.com> <CEE27071B8F0914B91B3076CEB63C2B6080240F7@de01ex08.GLOBAL.JHCN.NET>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Lampersperger Andreas <lampersperger.andreas@heidenhain.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kontron-modular.com ([213.179.130.140]:38305 "EHLO
	mail.kontron-modular.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZA1OQB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Jan 2009 09:16:01 -0500
In-Reply-To: <CEE27071B8F0914B91B3076CEB63C2B6080240F7@de01ex08.GLOBAL.JHCN.NET>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Andreas,

yes, this works perfectly, thank you. The modification immediately eliminated 
my task delays.
However, this modification requires some additional modifications in the 
driver, like described in 
http://kerneltrap.org/mailarchive/linux-kernel/2008/1/8/548252
But that's easy now !

Claus


On Wednesday 28 January 2009 09:09:37 am Lampersperger Andreas wrote:
> Hello,
>
> try to use .unlocked_ioctl instead of .ioctl for your drivers
> file_operations struct.
>
> Andreas
>
> > -----Original Message-----
> > From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> > owner@vger.kernel.org] On Behalf Of Claus Gindhart
> > Sent: Wednesday, January 28, 2009 8:34 AM
> > To: linux-rt-users@vger.kernel.org; Gerd Koenig; Peter Widmann
> > Cc: klaus weschmann; Jochen Beier
> > Subject: Realtime capability of ioctl() vs. read() and write()
> >
> > I am running a Linux 2.6.24.7-rt21 Kernel on our HW.
> >
> > This HW contains a number of IO-Ports, and the drivers for these IO-
> > Ports are
> > designed in a way, that various ioctl() function provide the interface
> > to
> > these Ports.
> >
> > Now, i recognized, that processes, which are using such ioctl()'s,
> > absolutely
> > do not run in realtime (regardless on the priority). If i cat a huge
> > file to
> > a /dev/ttyX device, the process jitters for many milliseconds.
> >
> > This does NOT happen, if i modify the driver and the user space process
> > to
> > access IO's via read() and write() instead of ioctl()'s.
> >
> > My question is: Is it a known and intended behaviour, that ioctl()'s
> > ruin
> > realtime behaviour, and that IO's should only be accessed via read()
> > and
> > write() ?
> > I didnt find any documentation, which would advice me not to use
> > ioctl() in
> > realtime applications.
> >
> > --
> > Mit freundlichen Gruessen / Best regards
> >
> > Claus Gindhart
> > SW R&D
> > Kontron Modular Computers
> > phone :++49 (0)8341-803-374
> > mailto:claus.gindhart@kontron-modular.com
> > http://www.kontron.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-
> > users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com
