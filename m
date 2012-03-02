From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: traceback on 3.2.7-rt13
Date: Fri, 2 Mar 2012 11:41:08 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203021134340.2742@ionos>
References: <20120225105502.0f4553a3@gmail.com> <alpine.LFD.2.02.1203011619530.2742@ionos> <CAONaPpFqas6RK1PNbiuzCg=LcVf1J9DuBxqxZDc2gHPgbDU91g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1690821183-1330684869=:2742"
Cc: Clark Williams <clark.williams@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42297 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab2CBKlN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Mar 2012 05:41:13 -0500
In-Reply-To: <CAONaPpFqas6RK1PNbiuzCg=LcVf1J9DuBxqxZDc2gHPgbDU91g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1690821183-1330684869=:2742
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 1 Mar 2012, John Kacur wrote:
> On Thu, Mar 1, 2012 at 4:23 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > That's why I asked to revert the
> >
> >       acpi-make-gbl-hardware-lock-raw.patch
> >       acpi-make-ec-lock-raw-as-well.patch
> >
> > patches, so we can get that information.
> >
> > It might be a non issue on 3.2 and only a 3.0 problem, but as I can't
> > find anything I'm going to drop those patches from the next 3.2
> > release and wait for proper bugreports coming again :)
> >
> 
> FWIW
> I believe the latter comes from here: https://lkml.org/lkml/2011/12/3/53

And how does that help? I know that the ec lock conversion was a
follow up to the gbl hardware lock conversion, but I need to see the
backtrace again which made us convert gbl lock.

Thanks,

	tglx
--8323328-1690821183-1330684869=:2742--
