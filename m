Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC6216616;
	Thu,  9 Jan 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423073; cv=none; b=sVeaEXDLaPNlHZFO2vXWABap7PBaFXG4ccbylZ41lMRAr8Of9aDPeAc02BW9ptdiNrzGfwBJ9wtzJMdqUF/CAR8lEy5RCKCyHMkuntHOt/a6aEkGQQ8ZRZVQKhaloITY1tykyuDWtUs8Sa/L96dGhSvZBl8FDH5crer8Xd525jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423073; c=relaxed/simple;
	bh=mLSHUI0ViczE2xMAjdJL5WFGByH/x09LMT89EA6MTb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGpNZxuOITVnVx/YETXsITSu2R0lLwwD1Qyk31/wj1RFdOKg0NZz5SD0v/INH6KwbW0X+cGvq2ZtN5oH6W5sB0FoxXbsQovInpI8bC7Ip18abrIrMUz2KhlENvtQS4CV+V9zsIObY88KnBKkfsH3CStB9KcLFVSuF4UYUJMG6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGJRf0I9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=np9tvODk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGJRf0I9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="np9tvODk"
Date: Thu, 9 Jan 2025 12:44:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736423069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szejLwXs9dyyogBjEt0/Lz89CjzS37So6iqwH5y3aSg=;
	b=cGJRf0I98bPrbR0WLlCeDiOuGFRO8fGGVHq3oE1d+9UtSDSMRsJgWDSf2GQi3+ooslAI22
	jk+nWP9ssl7LgS72I34cPsNyxDvs/OcwYsATyf0f6Rwych4P8uqBv8jUhbmPSQPLOzo0fX
	oobELfbOypLTn1CKNffUM8wTgV5mcKEOHwaJW1OJVQ55jEw7PmjCdnumbZnxlPvCvmY1k8
	I8y113a5JjuL3WJlP7px/Nf1le5fK+QcToWD192tmaAp3rek1kqE0mN/IjJINzQpq5Wzov
	xNfwYjIMwhnTEIItSCZglvAclw10z5r8HC+ZKMB9BtSL04cPYQmu6wPwTpc58A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736423069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szejLwXs9dyyogBjEt0/Lz89CjzS37So6iqwH5y3aSg=;
	b=np9tvODkCZCV5cBMBC+MoanzKgRmS02bB/zB2FK+g6FtuDCnKNLW9lcU5ITgwIIsz9b0un
	gEFx3Je0xAGmcpAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Robert Joslyn <robert_joslyn@selinc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: RE: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Message-ID: <20250109114428.4fvi0KRC@linutronix.de>
References: <20241226191238.2559880-1-robert_joslyn@selinc.com>
 <20250107115606.q67--i0f@linutronix.de>
 <20250107115832.jLUSKKwG@linutronix.de>
 <SJ2PR22MB382271FBE556A6A4AD978F0CE5112@SJ2PR22MB3822.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ2PR22MB382271FBE556A6A4AD978F0CE5112@SJ2PR22MB3822.namprd22.prod.outlook.com>

On 2025-01-07 18:09:46 [+0000], Robert Joslyn wrote:
> 
> Yes, I'm using 6.6.58-rt45 at the moment. We found this regression
> while trying to update from 5.10-rt. I haven't played with
> lazy-preempt yet but I can certainly test the patches, presently we
> run everything with PREEMPT_RT.

So I released v6.12.8-rt8 and v6.13-rc6-rt3. Looking at the lazy bits I
think I just forward your patch to the stable queue for v6.6.

> Thanks,
> Robert

Sebastian
