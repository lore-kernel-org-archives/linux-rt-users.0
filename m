Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D984A3E
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Dec 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499153; cv=none; b=lvHSH6O+LbBZs25cuUyIS4YxlVGybrwPCv+dPwY4suHfjCcEVsDXaYuGgc15yr9VOwX98pivBY8KTynHeAsksUe3C5hYyj+clCg3OONI1QK6jjhr239Cf7TTBOQmzSoh6YRPxkFfrLO+nMvz2CyjPsFuZriuJsksu3LZ9J1PnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499153; c=relaxed/simple;
	bh=6h4HEU7KY7Zcf4YpYKw/zb/k0S6NQm8FxPp11irddw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5KAlZgIQmeFVUwFJ8VJAtRSmeiUGQZ+Q1zcUm/o2LzXoE/XaZMhp5sFhJIr+vdjxabmiMvj+ryjqS47h7SW3+VXRbv16Wdsb8/sX7X90vGZ/Q3p6KAvyBbzef87r10QguTiA5dufoM+mN7MN3Q1jukjtc7ryHYE9yaAUx00awI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXV5Jnki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXV5Jnki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDB2C4CED1;
	Fri,  6 Dec 2024 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733499152;
	bh=6h4HEU7KY7Zcf4YpYKw/zb/k0S6NQm8FxPp11irddw0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GXV5Jnki+YfCYSccV+nmPZ/XHdAKKexMusH+KMDRX899Eg5zNa4qFAAdllPeVfEn3
	 5QpC50h50REY3PC51Pn+MUwXC2Hxw23FpzQZS1Y7nPLrPvt9yDLySqKLNoCIiPbGBR
	 2oz2G4DK+IHbwKmtobcmBlUiDVKesNM9esAaPtFa7FngvlncmTj40l+wt+XVFko2Yo
	 H+fK4cWKBJennScCKQP6K8oyIT/ILU4X+wa1XwpF4B4DMX4WpOQ4K6fZTvAbVGa7H2
	 9w+j0nR7UOLjLsAb8oe6VtT96iq5+3VlbCaEX92AVAUVg3Orvztbw8Aw0/sdydSDIm
	 JHspju8nUbFgw==
Message-ID: <97f8415f78e0bd6e3ce7d45bc378561a4f88767a.camel@kernel.org>
Subject: Re: Information regarding rt-kernel patch
From: Tom Zanussi <zanussi@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Prajwal Gowda
	 <prajwalgowdahm.1@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Date: Fri, 06 Dec 2024 09:32:31 -0600
In-Reply-To: <20241206115542.1PNgwiHm@linutronix.de>
References: 
	<CAOJh2-kFD7fd6km5PEBDXdYNwwWZXi2n8MKkz-Y6TEn643-Q1w@mail.gmail.com>
	 <20241206115542.1PNgwiHm@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 12:55 +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-14 15:10:20 [+0530], Prajwal Gowda wrote:
> > Hi @linux-rt-users@vger.kernel.org
> >=20
> > I would like to know when a new patch for rt-kernel v5.4.y will be
> > available.
> > As I could see last patch release for rt-kernel was in June for
> > v5.4.278 after that there are no new patch releases available for
> > v5.4.y.
>=20
> We are currently at v5.4.285-rt93
>=20

Right, I did the latest 5.4 release a couple weeks ago:

https://lore.kernel.org/lkml/1f9ef532e9d0a5bbabfb8461c9528418b65e4c78.camel=
@kernel.org/


> > Further I would also like to know about the future of rt-kernel
> > patch
> > release for 5.4.y.
>=20
> Tom is currently looking after it. I don't know if we shuffle things
> by
> the end of the year.

The currently supported versions and the support timelines are here:

https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

So, according to that, 5.4 will be supported until the end of 2025,
which I plan to do.

I do plan on doing another release by the end of the year..

hth,

Tom

>=20
> Sebastian

