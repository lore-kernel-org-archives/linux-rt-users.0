From: Julia Cartwright <julia@ni.com>
Subject: Re: How to write RT applications ?
Date: Tue, 21 Mar 2017 15:17:02 -0500
Message-ID: <20170321201702.GF10423@jcartwri.amer.corp.natinst.com>
References: <CAJ2oMhJp-uBxxj7tyPHM2M9cFnjhus4ORYYfFgNywaMFXS4Q9Q@mail.gmail.com>
 <20170317201741.bwwycyl5ggbpjksw@linutronix.de>
 <CAEYdEeR=04qszshTum6mbCwj_H53uLwwgbE4YDnDh1hHYqP7UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ran Shalit <ranshalit@gmail.com>,
        <linux-rt-users@vger.kernel.org>
To: Brian Wrenn <dcbrianw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:39223 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932511AbdCUUSi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Mar 2017 16:18:38 -0400
Content-Disposition: inline
In-Reply-To: <CAEYdEeR=04qszshTum6mbCwj_H53uLwwgbE4YDnDh1hHYqP7UQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 21, 2017 at 01:08:40PM -0400, Brian Wrenn wrote:
> I've tried to find a way to use ::std::thread or ::boost::thread to
> accomplish what the article for creating a simple RT application with
> pthreads does, but unfortunately I don't think those two OOP
> approaches provide enough attribute configuration to suffice.  Has
> anyone else found otherwise?

There is a defined member function for the std::thread type,
native_thread() which will return the underlying native thread type,
which, if you're using gcc/glibc is most likely the pthread_t.

Alternatively, the thread can adjust its own scheduling properties using
pthread_self().

See: http://en.cppreference.com/w/cpp/thread/thread/native_handle

For an example.

   Julia

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAljRij4ACgkQjNrC4UVN
dG/b8wf/aVcz+FCFT8vf43aryQdB8HBw28A2oWweN8MigEcaMrxPyhhf84FPDEKL
vT0bkNgHUzap/6KNtjIGLZKpntraaG4c0WWilQ0F+5DX7Bv0QdHgOOM4KIEA1Sj3
I1xUbx3EuRRraKvj6MckDLNJmmTqSMl1m9bRk8HqthG24fcmL+iqyotiW/XMQVai
+LPXudvCy5KiDeoLFkYEKpEeDhx3V38g24jL1QD3XcLfxPDR5g+bex/iC0DEsvnz
BfBdh7bhkJXyC6ZH1TfFj5pEg0ROi4tsyKTALi3amaa/cI6czKN8fhF9XtMdcbcE
1iBZlolDA0BvmgRuqjIFQQ7On8wqKQ==
=eKlC
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
