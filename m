Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79981340416;
	Wed,  3 Jun 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484168; cv=none; b=SknYC/X3njaTOvIeQ07kEix0u0bxriBenjcY2v0UM4QC6sAhMWsDItupekWke1xtC2GGmOoeDO18dyXdhyXjOvg8u/fE3eRTTc2W4JOkJ6uqbS8Z/lHKZPFoz7d4IpVIIt7AaaabfeNqUVeTGQleaMbfxsKBxnu572rzLPx4KhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484168; c=relaxed/simple;
	bh=qB/lQfI4dsfp4RRMTU7nRrxcm6HE6yD9Mh5ftr5+Odg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WP4SPVvlM2iB5abIPAzvHP+nEw60TLw8AQkaGtdOr+15My4Mb4Kfw1UrPKVgk0i0dEq0ljmmuC2w1D7ydwlUaOJ/DidobFKtk/qyq9ybEsuCmVc/DcDDTOw22vc/Psb6NMEezbR2s3G2eJ08fhynu7cIaEu6GuPnbz4CWtqvUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hksvWnts; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hksvWnts"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gVl422n9qz9t1S;
	Wed,  3 Jun 2026 12:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780484162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYLPDcy2H/OdgxAqqsMYxi9ouNTaBTAKlEi5O7LobLk=;
	b=hksvWntszK8FsFQalsKjtqSDsZK714OAzxKxHZRLgm8W/t3xn/R/cGeKVOv3knByosd6LJ
	2rLwRKAyWUKPOl5QB/8yaHrq7uu5Vbvsmu2r1SRThs3Rl59hX0leQ/PdR6uSTPFVpNygNI
	wll8BA16q4sts9e1EWYEQp6LFxsy2LXrKsNwJBH7ozmejLNhSG2GvS4Z9tsY7btQnysOWq
	/8fa7p+CfK+NY+/xOFeYUwIdH3ybS3d60CE/WwFYiMy0WKvgzL/zVvs9YE8rpChHyDzv7z
	Qa7kRMQ7VnAE9ewyx/IWP7n53sUEKWUx4kXuzO9dgmkUFkGDXv3PKIXvw0bBzw==
Message-ID: <a553f123de4b4887e8e78e751ca727f9992d8b00.camel@mailbox.org>
Subject: Re: [PATCH] Documentation: index.rst: add entry of other
 sub-directory
From: Manuel Ebner <manuelebner@mailbox.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-rt-users
	 <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "open list:Real-time Linux (PREEMPT_RT)"
 <linux-rt-devel@lists.linux.dev>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Wed, 03 Jun 2026 12:55:57 +0200
In-Reply-To: <20260603102020.ZsS16TaP@linutronix.de>
References: <20260603080430.344391-2-manuelebner@mailbox.org>
	 <20260603102020.ZsS16TaP@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: j8nar46ch35zgpd5mmtm4uy6g3qsymah
X-MBO-RS-ID: 97f1a0ade6ecd05d2bd

On Wed, 2026-06-03 at 12:20 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-06-03 10:04:31 [+0200], Manuel Ebner wrote:
> > add reference to scheduler/sched-rt-group.rst
> >=20
> > Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> > ---
> > =C2=A0Documentation/core-api/real-time/index.rst | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/core-api/real-time/index.rst b/Documentation=
/core-api/real-
> > time/index.rst
> > index f08d2395a22c..661b419e7f8f 100644
> > --- a/Documentation/core-api/real-time/index.rst
> > +++ b/Documentation/core-api/real-time/index.rst
> > @@ -15,3 +15,4 @@ the required changes compared to a non-PREEMPT_RT con=
figuration.
> > =C2=A0=C2=A0=C2=A0 differences
> > =C2=A0=C2=A0=C2=A0 hardware
> > =C2=A0=C2=A0=C2=A0 architecture-porting
> > +=C2=A0=C2=A0 Real-Time group scheduling <../../scheduler/sched-rt-grou=
p>
>=20
> Have you been using this and are referencing this because it is useful
> or did you just happen to find it?

I happened to find it.

> People have been complaining about this=C2=A0

Maybe with the help of them we can figure out what's happening.
adding linux-rt-user@vger.kernel.org=20

> and I *think* it fails to work
> in multi-CPU scenarios (it might work if the task is restricted to
> single CPU usage). Not entirely certain. But complains, that I am
> certain of.
> There is replacement underway to utilize SCHED_DL for this as in
> "Hierarchical Constant Bandwidth Server (HCBS)"
> 	https://lore.kernel.org/all/20260430213835.62217-1-yurand2000@gmail.com/

will look into this.
>=20
> Sebastian

Thanks for the feedback
 Manuel
