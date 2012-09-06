From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: TI wl1271 wireless bug with 3.4-rt17
Date: Wed, 5 Sep 2012 22:48:46 -0500
Message-ID: <20120906034846.GB14942@beefymiracle.amer.corp.natinst.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120902194911.GT28643@pengutronix.de>
 <50444D2F.3040607@gentil.com>
 <20120904141138.GA14942@beefymiracle.amer.corp.natinst.com>
 <5046A959.3080904@gentil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Cc: linux-rt-users@vger.kernel.org, Luciano Coelho <coelho@ti.com>
To: Gregoire Gentil <gregoire@gentil.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:33150 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab2IFDst (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2012 23:48:49 -0400
In-Reply-To: <5046A959.3080904@gentil.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CC'd Luciano to let him know about breakage of wl12xx on -rt.

On Tue, Sep 04, 2012 at 06:22:33PM -0700, Gregoire Gentil wrote:
> On 09/04/2012 07:11 AM, Josh Cartwright wrote:
> >On Sun, Sep 02, 2012 at 11:24:47PM -0700, Gregoire Gentil wrote:
> >>Hello,
> >>
> >>I'm trying to debug a wifi bug with 3.4-rt17 applied, running on an
> >>OMAP4 ARM board such as Pandaboard.
> >>
> >>Wi-Fi works perfectly well without rt patches. It also works quite
> >>well with rt patches AND without wifi module loaded. But with both
> >>rt patches and wifi module, the system is very flaky and even if I
> >>manage to launch a big download, I get a kernel hang. I managed to
> >>get a trace:
> >>
> >>BUG: scheduling while atomic: irq/213-wl12xx/1588/0x00010002
> >>Modules linked in: omapdce(C) wl12xx wlcore omaprpc(C) mac80211 d
> >>[<c001beb4>] (unwind_backtrace+0x0/0xf0) from [<c0613548>] (dump)
> >>[<c0613548>] (dump_stack+0x20/0x24) from [<c0073908>] (__schedul)
> >>[<c0073908>] (__schedule_bug+0x54/0x60) from [<c0614818>] (__sch)
> >>[<c0614818>] (__schedule+0x74/0x6c0) from [<c0614f60>] (schedule)
> >>[<c0614f60>] (schedule+0xa0/0xb8) from [<c0615eb8>] (rt_spin_loc)
> >>[<c0615eb8>] (rt_spin_lock_slowlock+0x198/0x288) from [<c06160a8)
> >>[<c06160a8>] (rt_spin_lock+0x18/0x1c) from [<bf0c6b24>] (wl12xx_)
> >>[<bf0c6b24>] (wl12xx_hardirq+0x2c/0xa4 [wlcore]) from [<c00bd4f0)
> >>[<c00bd4f0>] (handle_irq_event_percpu+0xac/0x24c) from [<c00bd70)
> >>[<c00bd70c>] (handle_irq_event+0x7c/0x9c) from [<c00c08f0>] (han)
> >>[<c00c08f0>] (handle_level_irq+0xe4/0x134) from [<c00bcf58>] (ge)
> >>[<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c03217e8>] (g)
> >>[<c03217e8>] (gpio_irq_handler+0x160/0x1a4) from [<c00bcf58>] (g)
> >>[<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c001449c>] (h)
> >>[<c001449c>] (handle_IRQ+0x88/0xc8)
> >>
> >>Source code including the function wl12xx_hardirq is here:
> >>http://dev.omapzoom.org/?p=3Dintegration/kernel-ubuntu.git;a=3Dblob;f=
=3Ddrivers/net/wireless/ti/wlcore/main.c;h=3D45fe911a6504f92dddff5a9415bb77=
a643b3c4a9;hb=3Df84c72f6b36418ff11d16808c16a7c3216730bb0
> >>
> >>Any idea what could be wrong and how I could debug and fix this situati=
on?
> >
> >On first glance, it looks like the driver uses request_threaded_irq(),
> >to register its handlers, but is trying to acquire a regular spin_lock
> >in its primary handler.  That's bad news, since spin_locks' can
> >schedule() when contended with CONFIG_PREEMPT_RT.
> >
> >And it's not just that, unfortunately, since the primary handler also
> >complete()s a completion, which also can schedule().
> >
> >It looks like the overall interrupt handling strategy of this driver
> >probably needs to be revisited. :(.
>=20
> Josh,
>=20
> I really appreciate the answer. Thank you. Though I'm definitely not
> a RT expert, I really would like to make this work... Could you
> provide a little bit more guideline what I should patch to fix this
> situation? Could I change request_threaded_irq to something else?
> Would raw_spin* help?

In general, the hardirq handler should be doing the absolute bare
minimum necessary to determine whether or not the device is interrupting
(and if so, quiet it down and return IRQ_WAKE_THREAD), since
longer-running handlers have detrimental impact to the system
determinism.

The right solution for wl12xx seems to be pushing the logic currently
implemented in the hardirq handler into the threaded handler, but
without knowing too many details about the driver, its difficult to
judge the viability/impact of this solution.

Also, unfortunately, it looks like this driver isn't the only one acquiring
non-raw_spinlocks or complete()ing in their hardirq handler registered
with request_threaded_irq().  My grepping shows that the following
drivers will also break in similar ways with -rt.

   drivers/dma/sh/shdma-base.c
   drivers/media/video/via-camera.c
   drivers/mfd/db8500-prcmu.c
   drivers/misc/lis3lv02d/lis3lv02d.c
   drivers/mmc/host/jz4740_mmc.c
   drivers/mmc/host/sh_mmcif.c
   drivers/net/wireless/b43/main.c
   drivers/virt/fsl_hypervisor.c
   virt/kvm/assigned-dev.c

Potentially IIO as well, but my eyes started to glaze over reading the
iio interrupt handling code :\.

      joshc

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSB0dAAoJEEef0niEbw+lqocP+wcCiSsb013JN/TLZRuoGpQV
jIeSIH3tEwhc2AYTfDbBvxW1jEHyqsNtnzsOtzHOr5xLtbeBpTjdw59D5JJjAWXs
6kJkRjTkp6Hc5YmIVNnLSRwfhc3mMLUao6b8dvVlu+tNJuc2RkBkiJzhj13kRAcT
V6HHS9d3dTF6kJ+snBSF43+tXLnxqo/BTjRByExLQZETImHGcauo/WruitjX4d6F
QFSrEbIx/hwWOITJtoUgT91R93/AQm5k/Hutfuk8FW9gCddvgle3DvVfZlX0aHIw
2tufrfwbr6Q2pW/PozHT1rp5IKGanxP9hlwPyr4FY6d/mjQlnWsQ/mJ6XFVHlW7/
giUOVwqWjjA6z/8iukHjguoO/jvWnV7poyVKpLQTC4Gdaj2cGiBz5LIlF0DbDU/6
zEDHklkiTBICwFm0yq2qgnywE9P/kYakrY3BO6PzYBOLeVlQOWOE5QKUIH0ohUku
PEqnqQDpkLb7ifOHlwKfm+rLux2JGLWiC9TlT5M0WPmS1w/BKW/SDS0IWUWqxQZa
ixGAaPkDj8POmC5dpKZDlmhauvPurdC2KirvNAQbLnMWPVzeHsKEhwDUdWQhYpda
Os8BApgTqH3RVl6ZnR8czeKMu55mCrbCoSkA/35S1FShS7kr4zAtyZpau2Q/OOda
h2py/171heF+J4RlPSWV
=e6Vt
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
