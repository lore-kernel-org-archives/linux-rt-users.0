Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7D28E8
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Nov 2024 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732666142; cv=none; b=GUkQ/r+Sthkt+YFv4gziSgoV2QOgDPfQj9mzuoOjP/1/GPCoOpKQFi6l31ALmTI3u/WF/k/gyta4r0tMFJompEU5iU8IkCpXbi38+IAgjlY+2pMdgsJrzFzEWzr2UOeB74yq5XzPv1a2lxj2sfQMUl9hfCWhpKmYzAUjg7vyZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732666142; c=relaxed/simple;
	bh=0OwrQSTvGfyEzMw0mTirA/OkgOjRJ2yZcDs9BxyJ4b8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tAAAJaGugGghc+yUVO8xj5LS3gDhXQuOOz8KXFJJqNYpBgDp6F3t0fYRVH3f5QTkNtUp46Ra3FbbfphZPnxjJKRv0HGJlHLWd4Pc4q/nkNv3+6NgQTQOlO6u+CAGNFVPTn6Cb6z77N85YwS4VsXfIsFRVope1hzVHumrDUz05/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e61WmXfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e61WmXfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732666139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqH5MIGjxFplncu5qNGdyYpKqwM6DwZ7Rml0bxf4wyk=;
	b=e61WmXfO3bSJ6xiP9bytfLxlOZUaglpdpEtebarMMDrIGP7h9Vc8Cdb+vXXcaeYlSts0CO
	Q9+UA1cJkY436e27JpiI9jLIqRR/Swrli9e1At6N8MVjEINnTBxAMf09RgR6jaJQ+wMyVe
	2PxBsLy10m+0nHa9smDh/EIKd4f7lN0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-CFwVdHC2O7-8dimPpmaTig-1; Tue, 26 Nov 2024 19:08:55 -0500
X-MC-Unique: CFwVdHC2O7-8dimPpmaTig-1
X-Mimecast-MFC-AGG-ID: CFwVdHC2O7-8dimPpmaTig
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84181aad98aso345642439f.0
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Nov 2024 16:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732666135; x=1733270935;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqH5MIGjxFplncu5qNGdyYpKqwM6DwZ7Rml0bxf4wyk=;
        b=KVv/rfosYdXn0J4AxvrWAj4u+pq/H9QYuu83sLpgZSFYX8kVLWUFc3WL9C4Go0wCuI
         K0fzVlkufcY1Ealf0bKRQLsFjqyBPLvVu9DBp9z10iZ2jWIHxUz0eULJ0lsmccF6jqaH
         kPIZE2gqkYabqC72DYuC/pnVt2Qqu67gq3PJEWQJ/YX+htSTXzLP4QsNLHJn2ucqgz1P
         zb6r6Y5Qu92lPbRSnpAsU54j9E8I94mWqwLKU1pv7E2HksVwCu+T+45sqBNCFvgJAONy
         7IqLHrPu6KZKFeGgN7BWtMn82Dls4BSQnEAg17/fHvmSVOt0UVbvWSjUYZBTlyxV5/k+
         XDfQ==
X-Gm-Message-State: AOJu0Yz6MOa/N0piVBZBQeqrl4jLC9CjaWA+Vb/4nkCeb07j5usZIHyf
	TfcBdvg1wzrOTnCVYha5f5cmLdDEXIt6qKDVEQBUndx7tdOwt4LTVDJMVWy5Hd7jTqoZ/tggVsq
	OKgs25vSvqHGj0dbBV+ER7sf5m3vqGf0JPDsuj1VA2+SPQmeUKjY/KR6Qfx6SuwpAPpiES5eR
X-Gm-Gg: ASbGncvZU2OCabnkfXEF0B5l8Fv8inwCoiDExYa5+xAtO8fHx2LEqVwRnXYfnrSk5m1
	pADI7gyh3F53Gpun4ZzdyZ4v0c+P5C0QEaPf8hN6pw/6ZeO5t0rlHjhTuSgbXtGr7heT6GH7Mar
	XoIgMJmmHp0sIXDVjIyCknGDTMjkR6iotX8V2DVsJmgAstE7N74HjgY6V5+C5ROQB2zVYIvM26d
	ZfPeO0jqGO1C3aZJWHqXBoMEe1VSuY9FiXO+bR9iu6oJgHyg9RaqU2pHbYtUFSpfrC2NGnzO6cF
	E5shww==
X-Received: by 2002:a6b:d318:0:b0:841:a9d3:3b39 with SMTP id ca18e2360f4ac-843ecfce126mr145794739f.5.1732666135058;
        Tue, 26 Nov 2024 16:08:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHdTxGegLWp9MNekFfdPURPyCQgaH6iqBZzzcYWyN844CQiZAhB/X78O2E26lqsTwwekDKJg==
X-Received: by 2002:a6b:d318:0:b0:841:a9d3:3b39 with SMTP id ca18e2360f4ac-843ecfce126mr145793039f.5.1732666134838;
        Tue, 26 Nov 2024 16:08:54 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e20e6f98e7sm886585173.142.2024.11.26.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 16:08:54 -0800 (PST)
Message-ID: <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state
 disabling via libcpupower
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
Date: Tue, 26 Nov 2024 18:08:53 -0600
In-Reply-To: <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com>
	 <20241113114509.1058593-3-tglozar@redhat.com>
	 <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-26 at 17:29 -0500, John Kacur wrote:
>=20
> On Wed, 13 Nov 2024, tglozar@redhat.com wrote:
>=20
>=20
> > @@ -254,6 +259,11 @@ static void set_latency_target(void)
> >  		return;
> >  	}
> > =20
> > +	if (deepest_idle_state >=3D -1) {
> > +		warn("not setting cpu_dma_latency, --deepest-idle-state is set inste=
ad\n");
>=20
> I don't think we want to have a warning when the software is doing what w=
e=20
> request of it.
> Can we either just move the logic out of this function into main and
> call either set_latency_target or the deepest latency state logic as=20
> appropriate, or move all the power management logic into a new function?

This could be said about the laptop and power_management checks too...
I'd go with verbose info prints rather than warnings for all three, if
anything.

I'm not sure how cluttering up main() with more logic would help, but
turning set_latency_target() into something like
setup_power()/cleanup_power() sounds good.

-Crystal

