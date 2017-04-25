From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 1/2] raid5: Use raw_spinlock for stripe management.
Date: Tue, 25 Apr 2017 10:46:46 -0500
Message-ID: <20170425154646.GK25232@jcartwri.amer.corp.natinst.com>
References: <1493040816-24038-1-git-send-email-gq@cs.msu.su>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Cc: <linux-rt-users@vger.kernel.org>,
        Alexander GQ Gerasiov <gq@redlab-i.ru>
To: Alexander GQ Gerasiov <gq@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:52804 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1950936AbdDYPrM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Apr 2017 11:47:12 -0400
Content-Disposition: inline
In-Reply-To: <1493040816-24038-1-git-send-email-gq@cs.msu.su>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2017 at 04:33:35PM +0300, Alexander GQ Gerasiov wrote:
> From: Alexander GQ Gerasiov <gq@redlab-i.ru>

Hello Alexander-

> This commit fixes the following warning:

In general, with the class of "convert to raw spinlock" patches, it's
nice to have written affirmation in the commit message that you've
looked through all of the codepaths and ensured bounded, minimal
behavior.

> [ ] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:993
> [ ] in_atomic(): 0, irqs_disabled(): 1, pid: 58, name: kworker/u12:1
> [ ] CPU: 5 PID: 58 Comm: kworker/u12:1 Tainted: G        W       4.9.20-rt16-stand6-686 #1
> [ ] Hardware name: Supermicro SYS-5027R-WRF/X9SRW-F, BIOS 3.2a 10/28/2015
> [ ] Workqueue: writeback wb_workfn (flush-253:0)
> [ ]  edf21a34 c12cdc6f c1078f0a edf08c40 edf21a64 c10787c1 c1668778 00000000
> [ ]  00000001 0000003a edf09144 00000000 80000000 ec694b18 ec775748 ec694ad0
> [ ]  edf21a70 c1584587 ec775790 edf21ac4 f893e8a3 00000000 c1078e52 00000000
> [ ] Call Trace:
> [ ]  [<c12cdc6f>] dump_stack+0x47/0x68
> [ ]  [<c1078f0a>] ? migrate_enable+0x4a/0xf0
> [ ]  [<c10787c1>] ___might_sleep+0x101/0x180
> [ ]  [<c1584587>] rt_spin_lock+0x17/0x40
> [ ]  [<f893e8a3>] add_stripe_bio+0x4e3/0x6c0 [raid456]
> [ ]  [<c1078e52>] ? preempt_count_add+0x42/0xb0
> [ ]  [<f89408f7>] raid5_make_request+0x737/0xdd0 [raid456]

Did you cut off the bottom of the callstack, here?

This conversion seems a bit fishy to me... is any of the raid5 code
invoked from hard interrupt context?

   Julia

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAlj/b2IACgkQjNrC4UVN
dG+xkAgAsCHpe7gJSSi120XOUEKDSCfoStZo7n6yxnIPwIUZ0v0rGniZ/HyKlFtG
9eo4pZ0q/SILgxKw8elL0772FYqKw5bjcU3MWvfA1mdyhVzYXWJWJOUm727urf69
q4dN1UfuacYb3wLjolUSDY8qjexnrOGAlwghsWA9kWHo+QqNq8pvjDeQPftPFOCP
hONtlbZi6jm92d3VGUI40ON13APc3/bJdZVh30utSwcMMYltVELVZfnttGRWU2hx
wQTU1M9kn7u63JkCWuK7B/HjfGns4y+QgzNSELAsss3S9bfCJFpSfwd8dQaMq6j+
KBJ0Og2mSxDi25OqXGZOnUT2xLdNbQ==
=+kWo
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
