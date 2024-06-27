Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5D20323;
	Thu, 27 Jun 2024 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471194; cv=none; b=WhCVybUsPi1zYLXKkKK2WkrjOVS3bFrIjJKpC3XEHaJc32KI4hrd5cZwgZ6O2uiIYSIC0MvSYd9u+2eu3RpqV9VTn5FNXmj/WrgjJPNA4wQDG++/mGV0kz2bwswQ//ZCGXw8hz92+EFV+5+IPnDgNDa5bKaP0Ge807MTV6Jmpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471194; c=relaxed/simple;
	bh=/7Mxx0jd2xM4StJXo+7I3Dwl3lT3bz1Lts1n3VSaGEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTijKr0dDnBxDFBnEZ5YdPwNHygE2OuOEGQ3xo8+zd9BclKLPsLsnJb0GWL+BBbE/D8ZMxCDCeMSM6RtY0RFvpMsGiUGfqDgXXKyuxaIjYz5u8iwK7H8euuJlOXKIverfiiHs4SHdjcX45O7YtdjJWTPjmB0JhFB7LvCe4lIObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RwUJhGHw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAoLI2ou; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RwUJhGHw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAoLI2ou"
Date: Thu, 27 Jun 2024 08:53:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719471191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+0Tkyg1+ybCmBf89qscsR5FClPspd4mnvaMAACYGJKc=;
	b=RwUJhGHwRO5l63b/1JGHetCHTawfpNXcaJWFSXbIS1yA4gL6n1vteXz5k5m+MBQL+dpoeT
	oWEpQ7HgMm4fKkgESrQKZ/hmbnv0iHk7FdG4E2PiVPi1CDX4PSHSVStQ49c0oa2w5oWS67
	ylN1mTVcnH6l1JIN4fphV+92DGGHep9JcsS6jgd6B+MfgEV6zfz6bh93i1xTLvPYHvT0t2
	c0VdnzsOjszLR8/XzzXZFLXpz3cxl/sQNVo4BYcnGG3UrGkBb/8buHipI4NJTwmiRn8K2N
	pejPkDynC691zWW9ITMDt4XzVG70nKKxk8rIc8+HS5K9dro5G/s4tynK71+Mrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719471191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+0Tkyg1+ybCmBf89qscsR5FClPspd4mnvaMAACYGJKc=;
	b=SAoLI2outADmF0P7Gy4qtP48qrsbdCBfHV04iRzxqxGNhAOCl0ZtJZ5JgCKSzbU7hX9/S+
	3DFaG711XhLFWJAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sam Kappen <skappen@mvista.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tom.zanussi@linux.intel.com, zanussi@kernel.org, sam.gsk@gmail.com
Subject: Re: [PATCH RT v4.19] tcp: md5: Add a serialization in tcp MD5 hash
 functions.
Message-ID: <20240627065309.e_MPmlKm@linutronix.de>
References: <1718966972-17507-1-git-send-email-skappen@mvista.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1718966972-17507-1-git-send-email-skappen@mvista.com>

On 2024-06-21 12:49:32 [+0200], Sam Kappen wrote:
=E2=80=A6
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const st=
ruct tcp_md5sig_key *key,
>  			       __be32 daddr, __be32 saddr, const struct tcphdr *th);
>  #endif
> =20
> +static DEFINE_LOCAL_IRQ_LOCK(tcp_md5_lock);
>  struct inet_hashinfo tcp_hashinfo;
>  EXPORT_SYMBOL(tcp_hashinfo);
> =20
> @@ -1224,6 +1225,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, cons=
t struct tcp_md5sig_key *key,
>  	struct tcp_md5sig_pool *hp;
>  	struct ahash_request *req;
> =20
> +	local_lock(tcp_md5_lock);
>  	hp =3D tcp_get_md5sig_pool();

Instead of this, could you please move the lock to within
tcp_get_md5sig_pool()/ tcp_put_md5sig_pool()? That way it will also fix
ipv6 in the same way.

Sebastian
