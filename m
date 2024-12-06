Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1E1FF7A1
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Dec 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486147; cv=none; b=EkLIZcZDGTbQjYqUtQxycCllT1OKaxo7yvrHJo8EVYyKCcdQNLKNFB+1LuCUHkoQOA3yZKDKejGaRl5U9A1jkqLff6/sdhdW0JQtcWXdwnvPzA7zNjFxJpeqQplbhkM4Xet2b7xzuew6vnfv2SpFMmOvmTLbM+rXOuLoIJ+7sF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486147; c=relaxed/simple;
	bh=mTFMCeeA+qwrLLW5c3Lz8eVOA2QwC652UcgCAIXWAOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcAfXKdaFFFoRcvQtSt10m0iWIdpDc2SwzVm3FKzfslhHBUxv1lj2ioPTrpRmZZCh3vZprOpTRsbewK4lgVfZqBhRoZINre0b/FeVISxBRC8SEWfteO7oR0bT2Fe0Kj0LT0VEYDeNe0jXg+aIXXn3K8PYm/+1kmpxlIkrNgsGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UaZQVFqS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3BL6/hdk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UaZQVFqS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3BL6/hdk"
Date: Fri, 6 Dec 2024 12:55:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733486144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ytjxwednkl7iw+mMvez4YAu1i3pypuHYN8Bqaqyjds=;
	b=UaZQVFqSJSBjuz2JuBwc0NkW6ilQouqqPNveGopgTIYftBolbAKiyl0unLAbSFqSTB9/SZ
	H8Ezn870AAQEHI07taldgoU0+cdrmKczV36a+X22mgk09uCG6jcZBa7kY7+GNxeooMhJKI
	xDd4XognyImLfV1+t9BwmE0+JnIdElWC1JyAX9KN/XKaHhopWPKZZsP2syul3mG8SFgWBE
	N3x2wOkI94cCVg3BUy9KkHoG6sQ4eXlXOjCG3FxFMtrvCNTheXneh6FVXkZC5S8XCOi8HW
	q05cyDq5aLs0LMBkImLPev3RAQJ2pDAn6OlGDDLAe550tecK2TraGR4V0b2/SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733486144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ytjxwednkl7iw+mMvez4YAu1i3pypuHYN8Bqaqyjds=;
	b=3BL6/hdke5mFPcAulIumyiRRa1rwtshMZQCvvIzThSqkzRV4tr5UuZMKb9ueIczoRa/nQu
	q3wfuF1zN78lJ8Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Prajwal Gowda <prajwalgowdahm.1@gmail.com>
Cc: linux-rt-users@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: Information regarding rt-kernel patch
Message-ID: <20241206115542.1PNgwiHm@linutronix.de>
References: <CAOJh2-kFD7fd6km5PEBDXdYNwwWZXi2n8MKkz-Y6TEn643-Q1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOJh2-kFD7fd6km5PEBDXdYNwwWZXi2n8MKkz-Y6TEn643-Q1w@mail.gmail.com>

On 2024-11-14 15:10:20 [+0530], Prajwal Gowda wrote:
> Hi @linux-rt-users@vger.kernel.org
> 
> I would like to know when a new patch for rt-kernel v5.4.y will be available.
> As I could see last patch release for rt-kernel was in June for
> v5.4.278 after that there are no new patch releases available for
> v5.4.y.

We are currently at v5.4.285-rt93

> Further I would also like to know about the future of rt-kernel patch
> release for 5.4.y.

Tom is currently looking after it. I don't know if we shuffle things by
the end of the year.

Sebastian
