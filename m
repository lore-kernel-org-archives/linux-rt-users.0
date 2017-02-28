From: Julia Cartwright <julia@ni.com>
Subject: Re: [CFP] RT Users Micro-Conf at Linux Plumbers 2017
Date: Tue, 28 Feb 2017 14:41:21 -0600
Message-ID: <20170228204121.GO1733@jcartwri.amer.corp.natinst.com>
References: <20170227172556.28dcbbb5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:60328 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751511AbdB1V7S (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2017 16:59:18 -0500
Content-Disposition: inline
In-Reply-To: <20170227172556.28dcbbb5@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2017 at 05:25:56PM -0500, Steven Rostedt wrote:
> Hi folks,
>
> Linux Plumbers Conference (LPC) will be held this year in Los Angeles
> California on September 13-15, 2017. Usually we have a Real-Time
> Micro-Conference but this year Thomas Gleixner may not be able to
> attend. Instead of having a kernel development focused event on the
> PREEMPT_RT patch, I would like to throw out the idea of a user
> experience focused event.

I think this is a great idea.  I know that in the past there have been
PREEMPT_RT workshops at RTLWS, but they stop at the "patch and boot an
-rt kernel, see cyclictest numbers change".  And, while these workshops
are useful for absolute beginners, there is a whole bunch of other
"stuff" that needs to happen between the initial integration and
shipping a final kernel in a production setting.

> A month later there will be a Real-Time get together in Prague, that
> would be perfect to be able to bring together a list of issues that
> users may have and present this to the PREEMPT_RT kernel developers.

Having LPC host this seems a bit strange, given your defined audience
(users vs. kernel developers).  Perhaps it would be more effective as a
session in the Open Source Summit track, or at the very least, if
attendees at the OSS Summit were able to attend the miniconference w/o
the purchase of a LPC badge.

> Are people willing to participate and have a discussion on what works
> and what doesn't work with PREEMPT_RT. Be able to share horror stories
> and work arounds with each other and perhaps come up with better
> solutions. I will take what comes out of this with me to Prague and
> perhaps be able to influence the development of PREEMPT_RT to address
> any issues that arise.

As a brainstorming of potential content, here's what I'd like to see as
an attendee (certainly willing to present where appropriate too!):

  1. Debugging case studies:

There are a ton of debugging/visualizing/tracing tools out there
available for finding latency problems.  Too many tools; some with
overlapping purpose, and some better than others.  It would be an
interesting exercise to have a few folks demonstrate the complete
identification, debugging, and fix of a performance problem on RT,
complete with a walkthrough of what tools were used.

  2. What to consider when designing the priority scheme of your system
     (application threads, irqthreads, RCU threads, ...)

  3. An enumeration of "knobs" which impact RT behavior

Where knobs are any of the compile-time or run-time configuration
parameters and how they impact determinism (I'm thinking things we've
run into like IRQSOFF tracing, timerslack, the bizarre
/dev/cpu_dma_latency, etc).

> There's also talk about having this combined with a Safety Critical
> session focused on PREEMPT_RT.
>
> Are people interesting in attending such an event? If so, I'll submit a
> proposal for having such a Micro-Conference at Linux Plumbers. If not,
> I wont bother wasting any time on it.

Sounds good to me!  Let me know where I can help.

   Julia

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAli14G4ACgkQjNrC4UVN
dG9adAf/So0j1OY2p6+RaxrPN6I7geTHc12wdUD/cg+AWTHvymjROULT9Mfk4VlW
7DEdTKzK0z7Np6JRQqUE8ZIhvhBo6hCk2dqbikMDST1dvsMCrA1pAzpzPkfD8yBP
9CDxzQRT6N5C5/GLedRwh2SssHq0ovp4K75x51ZUqqHOVSQ9EJNkvO96Rz01hJq5
bfcIKY62dXkTjrmX7cBV5cFJmGvoYErvlT5WZJZ2BoH78SPmEpiQQZ4yvnNqkZ9S
61D25nsgWlIIsNQIJjhzKsjvrG/6TtI2StERVPpSmnmmszu9APmlio5BrmqcFSr6
QA81MMh4Vm1W/BWbpZeQVFxr525pyg==
=bWsD
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
