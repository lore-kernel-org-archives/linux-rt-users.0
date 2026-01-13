Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180E3793AE
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291984; cv=none; b=IqpVZQyljGw6r4YvH7Y25c0mJgga/5nYI0VbvBNhl6/guxxVWAp1SmQBNw/ncC1P6GLIrvmlaRek/dXzIH+LLvj5acQSWbw1QnHEqMZ7szZLiyhA73nVHgKWiqe6oAy3ZlBMkvJdkMlAFo4Wi8eBWplic9rpO1C5N7m6zjhK3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291984; c=relaxed/simple;
	bh=oMzRtpIIEKTf27duYGQ14TFQGkhojn3tuhvOCTgxVmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ0o7RZbxj6ZVtZDVZudBfpmxn9U3VJNDpSQFMKwcxQLoB3kBV8wFuaMX+/e56lH4IJE1Ku/8mpMQ2IsdWZrCffn6iHUpzq+HSUPqDt8Z9TshX39dz5otV65R3+Io3Xo2K01KgwJd0INE3w/8dlsciew2+Ib+6rLVQPPZRYuFGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MNoRXABh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+hFye44Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MNoRXABh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+hFye44Y"
Date: Tue, 13 Jan 2026 09:13:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768291981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REwbP9pDAmosbUGlyA6m3dYaxAAlVS6hdM+H3fccf6w=;
	b=MNoRXABhSVb2uYh9mPm1NuMFpNXqvCCQoCulU0aa6iyICSNIuDoKuquChndjY/FJnO1QUm
	ANnjt4tPP4OuPODQaOljIj8VbyAaxUy5L/kFu3LZsVqvafVFpKIKmuPzwa0caMSrzYqwr0
	rQ47N72ohr4pwP2UqL+aS8kHtrtb1U/Sj51SNa4FERkk5zXKpqAlGYy/g8J7JF3eQUuVCl
	asI+IU+VVpDezuuJc0PgTA/MGsURrye6Xnp6gNU+m/0B410bJb8n7UXU2vFqVN1srn5CRT
	1dwgEtmUZxh1IUWsN7cH/d1JETOFIjxvvkeeRF91T9AyrxVYwIc3WyVWH//qLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768291981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REwbP9pDAmosbUGlyA6m3dYaxAAlVS6hdM+H3fccf6w=;
	b=+hFye44Yb0e0teKo5ONcuGAwH7p+CWB+gVs7t5vNy3f2HOKrjU7z2yWgCogi0dVYX9caX9
	l/H9w5fg2Ej4/JAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Crystal Wood <crwood@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH v1] cyclictest: Generate optstring dynamically from
 long_options
Message-ID: <20260113081300.s3s115wU@linutronix.de>
References: <20260110113738.2376456-1-costa.shul@redhat.com>
 <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com>

On 2026-01-12 15:13:22 [-0600], Crystal Wood wrote:
> > --- /dev/null
> > +++ b/src/lib/opt.c
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +#include <stdlib.h>
> > +
> > +#include "opt.h"
> > +
> > +char *build_optstring(const struct option *long_opts)
> > +{
> > +	char *opts =3D NULL;
> > +	int n =3D 0;
> > +
> > +	for (int i =3D 0; long_opts[i].name; i++) {
> > +		opts =3D realloc(opts, n + 4);
>=20
> I realize this isn't going to be noticeable even if it ends up being a
> copy each time, but linear realloc like this makes me twinge and think
> of how just about every other language in common use would have a
> readily available growable string implementation :-P

and assume you never run out of memory=E2=80=A6

> > +
> > +		if (long_opts[i].flag || long_opts[i].val < 32 || long_opts[i].val >=
 127)
> > +			continue;
>=20
> What happens if the OPT enum grows beyond 32 entries?  It's already at
> 16.  Maybe start the enum at 0x100, and print an error if val is less
> than that but not valid for getopt?
>=20
> Why is the implementation (slightly) different here versus the rtla
> patch?  We should probably use an enum in rtla instead of '4', '\1',
> etc. as well.

GNU ARGP might be easier to parse and maintain in the long run
especially if 20 other options are added.
	https://www.gnu.org/software/libc/manual/html_node/Argp-Example-4.html

> -Crystal

Sebastian
