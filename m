From: Josh Cartwright <joshc@ni.com>
Subject: Re: [4.1.7-rt8][report] Very high cyclictest latency during glmark2
 on i915 gpu
Date: Fri, 16 Oct 2015 15:36:29 -0500
Message-ID: <20151016203629.GE12756@jcartwri.amer.corp.natinst.com>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
 <CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:52854 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751904AbbJPUgb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Oct 2015 16:36:31 -0400
In-Reply-To: <CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2015 at 11:08:38AM +0200, Christoph Mathys wrote:
> On Tue, Oct 13, 2015 at 5:35 PM, Christoph Mathys <eraserix@gmail.com> wrote:
> > Can anyone reproduce this? Any ideas? dmesg does not contain any funny
> > reports...
>
> It is actually not true that there are no funny reports. After
> enabling more debug options I now get the BUG below once per second.
> There are other callpaths than the one below that trigger this
> message, but they all go through the function
> intel_pipe_update_start().
>
> [   17.694307] BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex.c:917
> [   17.694308] in_atomic(): 0, irqs_disabled(): 1, pid: 102, name: kworker/3:1
[..]
> [   17.694347] hardirqs last disabled at (21082): [<ffffffffa02fabf3>] intel_pipe_update_start+0x113/0x640 [i915]
[..]
> [   17.694367] Call Trace:
> [   17.694370]  [<ffffffff817f961d>] dump_stack+0x4a/0x61
> [   17.694372]  [<ffffffff8108785a>] ___might_sleep+0x13a/0x200
> [   17.694373]  [<ffffffff81800f24>] rt_spin_lock+0x24/0x60
> [   17.694374]  [<ffffffff8108bbac>] ? migrate_disable+0x6c/0xe0
> [   17.694375]  [<ffffffff810a9bab>] prepare_to_wait+0x2b/0xa0
> [   17.694386]  [<ffffffffa02faca8>] intel_pipe_update_start+0x1c8/0x640 [i915]

Looks like intel_pipe_update_start() is trying to queue the caller up on
the drm_crtc_vblank_waitqueue() from an local_irq_disable()'d region,
which doesn't fly on -rt, as the internal waitqueue lock is a converted
rt_mutex w/ PREEMPT_RT (and thus can sleep if contended).

Perhaps this driver is a candidate for a simple waitqueue conversion.

  Josh

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWIV/KAAoJEKp7ZBKwQFArGV4H/jvDA3DTs/KKOYuWWhy+Zx41
O5uG5h/Cc+Ph4GdcryDq18KrOFpnvK6msni17vjinqAHhNWUBna6iMIAr/i9cUl1
GXHOODYj2+3NdgC/X2AV87VMcRGjGjHcweCVsDSvsrg10Vll0RHe7W5XG7XmJwgK
ZpWhBYrrbunwTMcNXw3Ko7e69B2W0Kk/4RJkudZ92LNf1MOWKn/XhJAg4huSaL9c
OcYo+1pRZgRsC3orSZoe+l6IUBAmmciG9lDAu905oFMrzZWEbJs9ncZbMZdbJeOL
gEBDDFSt7lcTQZdEax4XA+k4PVxA8GfSOTxwRR5R68IyFUMSiYMCuZCIg9Me4pc=
=VEDg
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
