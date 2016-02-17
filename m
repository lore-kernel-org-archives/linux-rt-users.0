From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH] sc16is7xx: switch to threaded irq for fixing RT issues
Date: Wed, 17 Feb 2016 17:25:46 -0600
Message-ID: <20160217232546.GA4009@jcartwri.amer.corp.natinst.com>
References: <1455523133-29895-1-git-send-email-sean.nyekjaer@prevas.dk>
 <20160215220810.11529101@laptop>
 <56C2D1A7.1030908@prevas.dk>
 <20160216210250.34c2f07f@laptop>
 <56C41FA5.4010605@prevas.dk>
 <20160217215427.0263dbbc@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	linux-serial@vger.kernel.org, kubakici@wp.pl,
	linux-rt-users@vger.kernel.org
To: Jakub Kicinski <moorray3@wp.pl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:32931 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1424577AbcBQXZv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Feb 2016 18:25:51 -0500
In-Reply-To: <20160217215427.0263dbbc@laptop>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 17, 2016 at 09:54:27PM +0000, Jakub Kicinski wrote:
> [CC: linux-rt-users, can you guys help?]
>=20
> On Wed, 17 Feb 2016 08:22:13 +0100, Sean Nyekj=E6r wrote:
> > On 2016-02-16 22:02, Jakub Kici??ski wrote:
> > > On Tue, 16 Feb 2016 08:37:11 +0100, Sean Nyekj=E6r wrote:
> > >> On 2016-02-15 23:08, Jakub Kicinski wrote:
> > >>> On Mon, 15 Feb 2016 08:58:53 +0100, Sean Nyekjaer wrote:
> > >>>> Working with RT patches reveals this driver have some spin_loc=
k issues.
> > >>>>
> > >>>> spin_lock moved from sc16is7xx_reg_proc to protect to call to
> > >>>> uart_handle_cts_change as it's the only call that isn't alread=
y
> > >>>> protected in serial-core.
> > >>> Sorry but this does not look fine.  You are removing all async =
items
> > >>> from the driver.  This works for you because in RT code can sle=
ep with
> > >>> spin locks taken but for upstream it's not acceptable.  Did you=
 test
> > >>> this patch with upstream kernel and lockdep enabled?
> > >> I have a 4.1.y with cherry-pick of the commits from tty-testing
> > >> regarding sc16is7xx. (exept the new gpio api)
> > >> On our custom board we have 3 sc16is750 on a single SPI channel.=
 I'm
> > >> using an FTDI chip(connected to a test PC) TX wired to the 3x RX=
 pins on
> > >> the sc16is750.
> > >> The problem is easy reproducible just by creating data from the =
PC at
> > >> 115200 baud, causes the kernel oops almost immediately.
> > >>
> > >> I have not seen any issues with a vanilla 4.1.y, only when i'm a=
pplying
> > >> the RT patch and loading the system.
> > > Thanks for providing the details, I think there is a misunderstan=
ding
> > > between us.  Allow me to explain again what I meant ;)
> > >
> > > I do acknowledge that there may be a problem with the driver on R=
T
> > > kernels and I do trust you that you tested your patch on RT kerne=
l
> > > with latest version of the driver cherry-picked from mainline and=
 it
> > > works there.
> > >
> > > However, IIUC you are proposing your patch to be included in main=
line.
> > >
> > > What I'm trying to say is that in mainline we need the async work=
s
> > > which you remove in your patch because we cannot perform SPI/I2C
> > > blocking I/O under a spinlock...  If you compile mainline with yo=
ur
> > > patch you will see a slew of "sleeping in atomic context" warning=
s.
> > >
> > > So basically the questions are do you want this patch in mainline=
 and
> > > have you tested it on non-RT kernels?  (Please don't be discourag=
ed -
> > > there definitely must be a bug somewhere if you're seeing crashes=
, but
> > > I'm afraid the proposed solutions is not good enough...)
> > >
> > > Thanks
> > Yeah the first priority must be for the driver to work on the mainl=
ine=20
> > kernel :-)
> >=20
> > I just wanted to flag a problem with the driver with the RT patches=
=20
> > applied. I thought
> > RT patch (maybe) revaled that the driver have underlying problem.
> >=20
> > So maybe this patch should be included in the RT patch?
> > No i have not tested this with a non-RT kernel, maybe i should try =
:-)
>=20
> I've looked at the stack dump you posted in previous email.  It looks
> like we deadlock on the on spinlock_irqsave() in queue_kthread_work()
> because our interrupt is not threaded!?  I thought all interrupts are
> threaded in RT by default.

I believe the actual problem is that the handler is being registered w/
IRQF_ONESHOT.  I'm not sure that even makes sense in this scenario, but
is perhaps an unintended carry over from request_threaded_irq ->
request_irq transition in 9e6f4ca3 ("sc16is7xx: use kthread_worker for
tx_work and irq").

Sean-

Does this solve your problem?

  Josh

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
index e78fa99..1bb5c0e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1257,7 +1257,7 @@ static int sc16is7xx_probe(struct device *dev,
=20
 	/* Setup interrupt */
 	ret =3D devm_request_irq(dev, irq, sc16is7xx_irq,
-			       IRQF_ONESHOT | flags, dev_name(dev), s);
+			       flags, dev_name(dev), s);
 	if (!ret)
 		return 0;
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
