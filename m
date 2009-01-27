From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Tue, 27 Jan 2009 12:22:22 +0100
Message-ID: <20090127112222.GB21011@elf.ucw.cz>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Jon Masters <jcm@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56965 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbZA0LWg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Jan 2009 06:22:36 -0500
Content-Disposition: inline
In-Reply-To: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

> In case anyone wants to play with it, and especially help clean it up :)
> 
> SMI events are particularly unhelpful on Real Time systems because we
> effectively have the CPU stolen from under us. We can't prevent this
> easily without BIOS vendors/system vendor co-operation, but we can help
> to diagnose and log that these are occuring...which can be very helpful
> too.
> 
> Cheers,
> 
> Jon.
> 

> This patch adds the module smi_detector under drivers/misc
> 
> Code from Jon Masters with small changes from Luis Goncalves and
> documentation from Clark Williams.
> 
> ---
> diff -uNp a/drivers/misc/Makefile b/drivers/misc/Makefile
> --- a/drivers/misc/Makefile	2009-01-09 13:25:31.000000000 -0200
> +++ b/drivers/misc/Makefile	2009-01-15 10:55:58.000000000 -0200
> @@ -18,3 +18,5 @@ obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop
>  obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>  obj-$(CONFIG_FUJITSU_LAPTOP)	+= fujitsu-laptop.o
>  obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
> +obj-m				+= smi_detector.o
> +

Please use Kconfig here.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
