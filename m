From: Julia Cartwright <julia@ni.com>
Subject: Re: [CFP] RT Users Micro-Conf at Linux Plumbers 2017
Date: Tue, 28 Feb 2017 15:40:12 -0600
Message-ID: <20170228214012.GP1733@jcartwri.amer.corp.natinst.com>
References: <20170227172556.28dcbbb5@gandalf.local.home>
 <20170228204121.GO1733@jcartwri.amer.corp.natinst.com>
 <20170228160432.2f8eecbe@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:56965 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751778AbdB1VlO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2017 16:41:14 -0500
Content-Disposition: inline
In-Reply-To: <20170228160432.2f8eecbe@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 04:04:32PM -0500, Steven Rostedt wrote:
> On Tue, 28 Feb 2017 14:41:21 -0600 Julia Cartwright <julia@ni.com> wrote:
> > > A month later there will be a Real-Time get together in Prague, that
> > > would be perfect to be able to bring together a list of issues that
> > > users may have and present this to the PREEMPT_RT kernel developers. =
=20
> >=20
> > Having LPC host this seems a bit strange, given your defined audience
> > (users vs. kernel developers).  Perhaps it would be more effective as a
>=20
> I don't find it strange at all. There should be more "users" at
> plumbers. LPC is about discussion and not presentations. When users and
> developers get together, it should be a discussion.
>=20
> > session in the Open Source Summit track, or at the very least, if
> > attendees at the OSS Summit were able to attend the miniconference w/o
> > the purchase of a LPC badge.
>=20
> I think a badge would still be worth purchasing. Having the ability to
> help influence development is a worthy goal.

I didn't mean to make it sound like I didn't consider the LPC badge to
be worth it.  LPC is one of my favorite conferences to attend! Anyone
who asks me which Linux conferences to attend, LPC is always top on my
list.

However, from my experience, the attendees at LPC are largely already
kernel engineers, or other low-level usermode people.  I suppose it's a
question of what "users" you are looking for.

That doesn't necessarily include people who are domain-experts in RTOS
applications but are relatively new to Linux; or people who use a
distro-packaged RT kernels for professional audio but have run into a
few minor snags; or ...

> > > Are people willing to participate and have a discussion on what works
> > > and what doesn't work with PREEMPT_RT. Be able to share horror stories
> > > and work arounds with each other and perhaps come up with better
> > > solutions. I will take what comes out of this with me to Prague and
> > > perhaps be able to influence the development of PREEMPT_RT to address
> > > any issues that arise. =20
> >=20
> > As a brainstorming of potential content, here's what I'd like to see as
> > an attendee (certainly willing to present where appropriate too!):
> >=20
> >   1. Debugging case studies:
> >=20
> > There are a ton of debugging/visualizing/tracing tools out there
> > available for finding latency problems.  Too many tools; some with
> > overlapping purpose, and some better than others.  It would be an
> > interesting exercise to have a few folks demonstrate the complete
> > identification, debugging, and fix of a performance problem on RT,
> > complete with a walkthrough of what tools were used.
>=20
> Note, LPC is about discussions and not presentations or tutorials.
> Although, I could submit a talk that would hopefully be a good
> introduction into what the plumbers track would be like. I could maybe
> get it accepted for the "shared" day (talks for both plumbers and Open
> Source Summit attendees).
>=20
> If you can create a discussion out of debugging tools. "Here's what I
> have, is there a better way to do this?"

Yes, I didn't mean to say to suggest a session with a bunch of
presentations.  I'm only suggesting a presentation as a means to
facilitate meaningful discussions.  Having a ground to start with (a
real-life debugging scenario), I think is a good way to get there.

> >   2. What to consider when designing the priority scheme of your system
> >      (application threads, irqthreads, RCU threads, ...)
>
> I would turn this into something like "here's my work arounds to my
> problems, are there better ways to do this?"
>
> >
> >   3. An enumeration of "knobs" which impact RT behavior
> >
> > Where knobs are any of the compile-time or run-time configuration
> > parameters and how they impact determinism (I'm thinking things we've
> > run into like IRQSOFF tracing, timerslack, the bizarre
> > /dev/cpu_dma_latency, etc).
>
> "here's what I've done, are there better ways to do this?"
>
> Hmm, I'm seeing a trend here ;-)

Certainly.

> > > There's also talk about having this combined with a Safety Critical
> > > session focused on PREEMPT_RT.
> > >
> > > Are people interesting in attending such an event? If so, I'll submit=
 a
> > > proposal for having such a Micro-Conference at Linux Plumbers. If not,
> > > I wont bother wasting any time on it. =20
> >=20
> > Sounds good to me!  Let me know where I can help.
>=20
> I rather have you tell us were you want to help :)

I'd happily talk to/facilitate discussions on the topics I mentioned
above.

   Julia

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAli17jgACgkQjNrC4UVN
dG9nRQgAp4FedExBOpTSgx5twrUtJ3NjETd4x4oORdioia+nJKhvEQ67O9BHsu26
l6WUSDzeIrlKxxFGN2/sdmhHojFZqE/LODCopw3XN9XoauKsypJF5w/a8sno4Xdi
BgDls5uUj6w07CeJ9TKXP6OTnsFDmlDq3D5nCHgAWrhp0KtaSkC79hcaC90i3cFF
B/XoRI1US6Y0q+1JNBXKD8r6Xj/KJMOEUh0bfl6zOMDS89vwu+DUQBj+2Cv8r9Vx
N/5w8xwT8IchsN40gCm64n0i4qLTnbSrmrpcgCb+/dA5xiy1Ndyzhgj7JjYP3+ve
IntgG4C6aAfTLZgBlaxex2X/FKDEpw==
=D7cC
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
