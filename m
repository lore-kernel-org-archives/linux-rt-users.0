From: Clark Williams <williams@redhat.com>
Subject: RFC: NUMA modifications to cyclictest
Date: Tue, 19 Jan 2010 17:14:39 -0600
Message-ID: <20100119171439.24726f2e@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/uBDN3AmdiuNvPDlM=GwJldQ"; protocol="application/pgp-signature"
Cc: LKML <linux-kernel@vger.kernel.org>, Carsten Emde <ce@ceag.ch>,
	John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50247 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab0ASXO5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jan 2010 18:14:57 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/uBDN3AmdiuNvPDlM=GwJldQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

RT-ers,

Lately we've been struggling with some performance issues on high-core
count (>16 cores) NUMA machines with the RT kernel. During the course
of troubleshooting this issue, we tried using the 'numactl' program to
constrain our measurement testing tool (rteval) to a particular memory
node, rather than letting everything float. Doing so showed marked
improvement in both max latency and jitter.  While this doesn't solve
our performance problems I thought it might make sense to have a --numa
mode for cylictest that compliments the --smp mode just added.=20

The big difference here is that when using --numa, each measurement
thread (one per cpu) has it's stack allocated from the memory node
associated with it's cpu. Also, the major data structures for each
thread (parameter block, statistics block and histogram) are allocated
from the appropriate node. This is done with calls into libnuma,
which means this will add a dependency on libnuma.=20

The intent is to measure latency on a numa system in the same way a
well-written RT application would run on a NUMA machine, that is
minimizing the off-node memory references.=20

If you're interested in looking at this, please pull the numa branch
from my git repo at:

	git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

and let me know if you find bugs or disagree with the approach.=20

Thanks,
Clark

--Sig_/uBDN3AmdiuNvPDlM=GwJldQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAktWPOcACgkQHyuj/+TTEp0AeQCfUialeqzQtuz30tUGZASsQpah
+U4AoJpMmEFnjbv3Rn4brrvGi3WcBX5O
=0+y3
-----END PGP SIGNATURE-----

--Sig_/uBDN3AmdiuNvPDlM=GwJldQ--
