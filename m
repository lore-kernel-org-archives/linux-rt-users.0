From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 9 Oct 2007 11:34:48 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0710091131400.25146@localhost.localdomain>
References: <470B44A1.7080007@free.fr> <1191921343.13628.0.camel@godzilla.tecnorama.it> <470B49BD.4070506@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alessio Igor Bogani <abogani@texware.it>,
	linux-rt-users@vger.kernel.org, linux-acpi@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47141 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbXJIJfD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 05:35:03 -0400
In-Reply-To: <470B49BD.4070506@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 9 Oct 2007, John Sigler wrote:
> Alessio Igor Bogani wrote: 
> > On Tue, 2007-10-09 at 11:06 +0200, John Sigler wrote:
> > [...] 
> > > I enabled high resolution timer support and disabled ACPI support.
> > [...]
> > 
> > http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00375.html
> 
> There are other clock sources on my system.
> The timestamp counter is reliable (as far as I can tell).

See previous mail.

> The LAPIC timer is reliable.

LAPIC timer is a clock event device, not a clock source. It can be
used to program the next event, but not to read the time.

> (I've just disabled the PM timer.)

Yup, which in turn disables highres.

     tglx
