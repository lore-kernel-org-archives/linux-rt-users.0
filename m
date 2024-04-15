Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257B679E2
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Apr 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183951; cv=none; b=axGt1tJIcaG7MscJQLMM4P2972s5paQ33M4oMwIwd7CpgDs6PTiT5GYwalimZGd3X007Qf+YMCNocYhEaz6JG+20K81X0A1SDuf9mdl64AKKrIu66IDx+t8m/bF2wYx2++HW066Z8pCelTUHX7SsTU09voYf5Wk4IZdhTo3f+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183951; c=relaxed/simple;
	bh=L1V0jRuSiUbCxImGX5gLQ66xX5kwC8N2gF7cCPTzXv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxmsHUzzTV9cW9ZNEQJT17eqNuvsxJab4/1qrFsebWQU/NkrL5aYswmGm9EyEjNaR39+HX6KC+274S6HULzQMQFlNllmCbcdbGOH5OVtYSE0T48G/qkMHqyD8VHoQ4cB1YxBuVfIwTU3d5nQIgdLIn4G7ZGLgJrUF1rv3MU6wxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIgPiwOR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIgPiwOR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713183948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xi1nc+JsCBSl9tDY1rQ0F/hUsrd+06AFpIRijMer3uU=;
	b=JIgPiwORdszwCyhBKYJe5FQs9kpIS8CbIzhee1QzgNbwHZ5l9GUTqbxVFyM09P9tMgUxyL
	Fad1HzYh4s56tGBwk4WBBm56AWsnucZaUyBS/uTvwGCf/dWQQlmbWr2kMpHepOxB0ZhRUN
	3yGuVsXgoIWChFJTrJ1qR3EBPQD6epk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-eTFHdXHtPr6tar0TtmvQyQ-1; Mon,
 15 Apr 2024 08:25:45 -0400
X-MC-Unique: eTFHdXHtPr6tar0TtmvQyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DB933C02764;
	Mon, 15 Apr 2024 12:25:44 +0000 (UTC)
Received: from localhost (unknown [10.22.8.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 882BB2026D06;
	Mon, 15 Apr 2024 12:25:43 +0000 (UTC)
Date: Mon, 15 Apr 2024 09:25:42 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.213-rt105
Message-ID: <Zh0cxp0i-jO7Lisp@uudg.org>
References: <ZgFy9au0Gvkzr6gZ@uudg.org>
 <ZhzdqyqZrjhXs7ZJ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gOSc9cJjPjL7deDu"
Content-Disposition: inline
In-Reply-To: <ZhzdqyqZrjhXs7ZJ@duo.ucw.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


--gOSc9cJjPjL7deDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:56:27AM +0200, Pavel Machek wrote:
> Hi!
>=20
> > I'm pleased to announce the 5.10.213-rt105 stable release.
> >=20
> > This release is an update to the new stable 5.10.213 version and no ext=
ra
> > changes have been performed.
>=20
> Thanks for release.
>=20
> I see v5.10.214-rt106-rc1 is out there and now v5.10.215-rt107-rc1,
> but I don't see v5.10.214-rt106 (which would be useful to me).

Hi Pavel!

I submitted v5.10.214-rt106-rc1 to kernelci around 2 weeks ago and there
were more build problems than usual, though I didn't observe problems in my
local tests. So I decided to run a few more local tests before releasing th=
is
kernel. Based on the current results I will probably release
v5.10.214-rt106 in the next few hours.

As for v5.10.215-rt107, there were a few printk changes that I decided to
submit to kernelci as soon as possible, given the HW diversity available
there.

Best regards,
Luis
=20
> Is it a mistake or should I plan for v5.10.215-rt107?
>=20
> Thanks and best regards,
> 								Pavel
> --=20
> People of Russia, stop Putin before his war on Ukraine escalates.


---end quoted text---

--gOSc9cJjPjL7deDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmYdHMYACgkQ85SkI/jm
fCYbow//ceRSONcoqY3ExwTMNRxulYIWVkeP9I1Z9k0EdgXCsNqC+hlN9gGYmAkt
6g4QT7vLTdtr84CEsJQ8+hrOl72TlllC4mAgxwOpIUIxh0KQqu9E8VW6qyMbzv9f
Oq0s/6rt7jRSwDIxEKnIZJWF4E9NtvVzERtmX3I3UC+scZIrHSe/4Ui+dnR++XOh
kmiUTR3hQGofhKO674WJXf304yDoZe5J9h1NzFdw1tmKG6lY8Gx1tys7vLaBlA5Q
czmW2gS+S5o6/UjAqajNP5cwXxnFZIhLTwJ0yNEiPYauF5i7b2AEv3WdWjPERCWJ
ceMUMOOmR3jwTaBEL10TxeOCLSSAXj10cg8AiFyYJIvSFnYIJPW9Mg2k4VBdyUyV
r6xz9gfjUntfAfwuLyAK2vBtgK9u+RqQVgkedmagmJZ8kXA0EKz4feB1DSMMBS6d
4LahZlFLHNmFWSOlN1Yw51pc9qn8mz20dEG6eRzgS9uWZawPXY2Otmy4XMVr5YgN
4pZaLT0imyINFoO1Z3MiAgbk8J4rt5viosugL0Jr0zlaFVJcypOzX1Ni86wce6l9
+uztTNlJgFsm5RyKgL/FRLbHpNqE+UmADALiI4v/0TG3ZYKaCeRx9BLVXGfpDPJA
WfejCcs2ZfYIYu22w81PoQocAUpPrS1OexE1mCiOd+f0iQzue/o=
=2fPT
-----END PGP SIGNATURE-----

--gOSc9cJjPjL7deDu--

