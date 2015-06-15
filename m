From: John Kacur <jkacur@redhat.com>
Subject: Re: [ANNOUNCE] rt-tests v0.92
Date: Mon, 15 Jun 2015 09:25:00 -0400 (EDT)
Message-ID: <2037002657.2007437.1434374700995.JavaMail.zimbra@redhat.com>
References: <alpine.LFD.2.10.1506091552470.10554@riemann> <20150613114104.6ff44c05@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Anna-Maria Gleixner <anna-maria@glx-um.de>,
	Clark Williams <williams@redhat.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: Joakim Hernberg <jhernberg@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:38600 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbbFONZj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Jun 2015 09:25:39 -0400
In-Reply-To: <20150613114104.6ff44c05@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm thinking - without looking at any code here, just using my memory, that we purposely decided that this should not be used as a built-in.
If this is true, perhaps we need a patch that eliminates that as an option.

Thanks

John

----- Original Message -----
> On Tue, 9 Jun 2015 16:11:20 +0200 (CEST)
> John Kacur <jkacur@redhat.com> wrote:
> 
> > 
> > I'm pleased to announce v0.92 of rt-tests, thanks everyone for the
> > patches!
> 
> There is a test in the hwlatdetect script that checks for the existence
> of the hwlat_detector module.  This fails if the modules have been
> compressed and also if the driver is built into the kernel.
> 
> --
> 
>    Joakim
> 
