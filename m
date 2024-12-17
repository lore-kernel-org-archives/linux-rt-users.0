Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2191F03FC
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440194; cv=none; b=OrHsYcmJ6huTshV77O2mS7vnAqYDvKVdG4/MXG7shQPzaJOBoOLj4aXylwhhnPXvO7yZiIWlMCZQukHqCRkbb/LUMStABBZ80XFm/u4b8Ng5yfiizkgRPpjh5nBOU+J/rtqOhPOFbRAOxojCKHhjDai/sLy/aEwfrtlABEV3Ezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440194; c=relaxed/simple;
	bh=AFCjjXCxlKJe3fVfBvFowKGpIMwsBsx6alDGaTz8iIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stGvjK1i8F/nd/+32cT3z6gTk1bPYyEuXYaoUO9p4gufrB1rye04v3vkFKwYgKMSTAp89IGZD4mophFnT4xvf3f8hqZHY8yvVZDEmpSQh8pRHwTsv79Y9Eef+MyADFNGVTKH7h8i3jPQy8U+v+levTkmomH0E/sbRR3u2vkVtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMsWL/eR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B7InoJRD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMsWL/eR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B7InoJRD"
Date: Tue, 17 Dec 2024 13:56:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734440191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B87wKrk8z3c3w6NKCAFepzxx167xsHMqu35UhQnDGMg=;
	b=nMsWL/eRXJKu3QQzF9MUtoqFz/IsDgOEWaz9YgB4ClwadBL7A64GOlk893szg6TMQZy0th
	rSi1gOvxtFf+4jUJEVbl37dt6km5qORK+TbB6SAlFVIGAV7ytgZOdmPJM7DL2gpLa3Q1Jz
	1BMvIqkWYQAtZmMZm0IgNd+0fO4VL1miKjXZax7DOMzD54uVBRtprGKqEcA+hdw/GqWYIF
	Pv2FvtiDERy8iELLscJG+rsnkxY8tLhE9j89OzOhwDfsrI2GTLrctJr2c4W9E+qKpzRuSM
	hNF+vDnMNvARJ5V1N0rnilJd45fyNGzPNDfYBAM02tXpTvn4IN9f4MaIsSguow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734440191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B87wKrk8z3c3w6NKCAFepzxx167xsHMqu35UhQnDGMg=;
	b=B7InoJRDcczd3xfuiev6paDQkhFPCmn5xUhMOix0rmdaQHJOiB+hijVCL3BZuKpKl6CAzb
	4L9/wfSFHZLwYlAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-rt-users@vger.kernel.org
Subject: Re: Lazy preemption on arm64
Message-ID: <20241217125630.EfJm0MX0@linutronix.de>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
 <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
 <20241217073151.5aa2352a@mordecai.tesarici.cz>
 <20241217085031.Wh45Bd2r@linutronix.de>
 <Z2Fh09GyYx09Mx1_@J2N7QTR9R3>
 <20241217115931.wjw_HO2V@linutronix.de>
 <Z2FtNgp_OVIy0D36@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z2FtNgp_OVIy0D36@J2N7QTR9R3>

On 2024-12-17 12:23:18 [+0000], Mark Rutland wrote:
> Yep, I had that in my HACK patch:
>=20
>   https://lore.kernel.org/linux-rt-users/20241217115931.wjw_HO2V@linutron=
ix.de/T/#m12eece66786a3a207e4e952bdf58570ab75c6a89
>=20
> ... so it sounds like we're on the same page. :)

That is great then. I somehow accounted this for the KVM bits but you
have KVM_XFER_TO_GUEST_WORK so it is all good.

> > I would appreciate it. However if there is reason to delay it I could
> > hold to it for some time=E2=80=A6
>=20
> I'll try to spin it as a proper patch later this week (and will Cc the
> folk here, along with Jinjie, etc); it'll be up to Will and Catalin as
> to whether they're happy to pick it up, but given it's small I suspect
> that'll be fine.
Okay.

> Mark.

Sebastian
