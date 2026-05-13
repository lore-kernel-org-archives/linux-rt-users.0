Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7F31B837
	for <linux-rt-users@vger.kernel.org>; Wed, 13 May 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705299; cv=none; b=nlljXRYKdubTl1pugNFkOsOJVipE17VZT895iwH147nRYl2rxDMo7sowdz64pY+DRK+NcMaIpxb3+pw7LhQrq1uVpUEmq+N4b7su3kKtrROZM1auLhPgeMwj8imJ0ggACv7hzhgUAqiImrIV+ZT6OWh7QSZtnON/43CmENsrjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705299; c=relaxed/simple;
	bh=H6aCfuyELuLhcdHxGmDr1OTdRsXKjx00qHoNGAGAn30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0Mqb0x3wUoI8DAx6+fx2Et1+RDmTHMbm2X/WUMym4ROjq1gBPoVhbQbo4UAbQS0zPMGPVTVdsELBszxOVUKRf/gV4ENv5gIuO5p/SfPawA3ccVB5TPBIbCaIod+/eU+WB4ltWGHOPqtan6Ts3xSh6hCMm2Hmqq7ixka1+BXCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L0jo0aTR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8c5zDnG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L0jo0aTR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8c5zDnG"
Date: Wed, 13 May 2026 22:48:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778705296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6aCfuyELuLhcdHxGmDr1OTdRsXKjx00qHoNGAGAn30=;
	b=L0jo0aTRiFBP3ycSvEWe9wheb5tPap7GTFMpOz44sT/yAD/CUG7LrP25Iz9K1zoX5GtWiA
	5T41tZYCsk+FC2bdre4pph5McB+Z+J7IRlUjtcU9+ZrsYNW3R/3LAeseWlVpnmTv3Uu9Wm
	ueiyC+u1xxoaTcM5uBHC2n+27QTk9ruNBzv2EHWLHKT/0AZSlADQj4IkvpexUzWC9cp7AT
	6GLVqveZEZCrdhKGcTOxRNHYD30dCqFaoSvTDVGgzARNtZxwz0nPoFnR9lIy5PV6ekp0h3
	HsIwIcvJmF+iIHUtv0Q+ECj0nn7htUCsRd8mEVhKF+wxAD6nVgr3uxwebuN3zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778705296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6aCfuyELuLhcdHxGmDr1OTdRsXKjx00qHoNGAGAn30=;
	b=b8c5zDnGJ5DeaqdubqyXkxgEZE8/5igzrddQDC91VAGKglBMdZuzSbg4UvznN92P3pWABp
	Ra/daqSnRL16XQBA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 00/28] rt-tests: Rework cyclictest manpage
Message-ID: <agTjjlIOpp9u9Prp@lx-t490>
References: <20250704132721.13325-1-darwi@linutronix.de>
 <20250714130104.29nUrEeQ@linutronix.de>
 <da95e7b6-a1f0-c2b5-0b9d-3c2a5878c96b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da95e7b6-a1f0-c2b5-0b9d-3c2a5878c96b@redhat.com>

Hi,

On Mon, 14 Jul 2025, John Kacur wrote:
>
> We can still accept the patches that Ahmed sent fist, after I review them.
>

By chance I've just discovered that the manpage branch is not yet merged
into master, even though it has all the necessary Reviewed-by tags.

Is there any way we can start merging it?

Thanks,
Ahmed
