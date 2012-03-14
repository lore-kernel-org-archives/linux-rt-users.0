From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/7] [ANNOUNCE] 3.0.23-rt40-rc1
Date: Wed, 14 Mar 2012 11:14:37 -0400
Message-ID: <1331738077.25686.668.camel@gandalf.stny.rr.com>
References: <20120314022658.783312660@goodmis.org>
	 <201203141352.10145.fzuuzf@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Karsten Wiese <fzuuzf@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:2587 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab2CNPOk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Mar 2012 11:14:40 -0400
In-Reply-To: <201203141352.10145.fzuuzf@googlemail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-03-14 at 13:52 +0100, Karsten Wiese wrote:
> Am Mittwoch 14 M=E4rz 2012 schrieb Steven Rostedt:
>=20
>=20
> > Changes from 3.0.23-rt39:
> >=20
> > ---
> >=20
> >=20
> > Steven Rostedt (2):
> >       Revert "ACPI: Convert embedded controller lock to raw spinloc=
k"
> >       Linux 3.0.23-rt40-rc1
>=20
>=20
> How about also reverting the commit that has changed acpi_gbl_gpe_loc=
k to a
> raw spinlock?

Hmm, you're right, I missed that.

It's harder to find things removed from Thomas's series than it is to
add new stuff :-/

As I'm ready to push this, I'll do the removal after updating to 3.0.24=
=2E

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
