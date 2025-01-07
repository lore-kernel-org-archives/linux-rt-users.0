Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704261E0DE5;
	Tue,  7 Jan 2025 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251117; cv=none; b=heNrcOJwgx6vNspN3miSyMUXzDwhu+2HYtr942fNTcJC9bEpbyPQf9SB/JkCH0/BCI7FQNW+F74yoqFJX99zD9KqW4B7dnCqR7FWSNRC1k9uIJuPekUS5V9ogQcHxKejFXUUNVvU2WTiv3iSaMG8uoB0Ki5Ot1eNR5NGZksAcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251117; c=relaxed/simple;
	bh=/Kud4TxOnAy247c/F1cZEY8jHX+ETxp5Rv7pUOUsZzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzuU+wDgmdL115CpRel8sKhTfu+qAUEL0F6otLXSnurN9Ck7tv6u62y8wz5OS2sKm/f+BPHddocOc4StWaB+5FVKW+2+Mz76M6B2HJ8ql0Ly5diLCEfkyhtxpHUuELjhiaAkbKhvrUEhXy3Oy4E4LcvXykc82s7so9VvRvxn/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3VAXpXN/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2zvg5j5f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3VAXpXN/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2zvg5j5f"
Date: Tue, 7 Jan 2025 12:58:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736251113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubR3kOEYyEaA5n266Uhkl21Qr7nP0Vx39hZF56qXK+g=;
	b=3VAXpXN/xegFG3ybANJgqMMn9sYS/ZJixJUQzpSmE0qEDO/QxT5+wThDwpfYqCMX6Ul1iJ
	uCQ10IpYxmp4tARFX/FtuEJkF1EXP0ULhls/n22kiiC97vkfGa+lV6HOCGO3fe9Ke6azJd
	98kGhGkbzV9uOVkwUgdXNPRINhJsC/+EIzuaIX3EDR0QR3iavUXMa/IshNQqCqNQGoB5w5
	j50Vh0MuxiYYpRkSjoGV++2Hq/vxV77g7vdj2dp1+B2KKp6EEdGSo4Qq+4km94+dXf3qof
	WQKiQjWZiti4hWgZwrylncTZ2/iFiDtmVKEn5v+FCZ/t1YMAGvYqL5xph3C/WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736251113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubR3kOEYyEaA5n266Uhkl21Qr7nP0Vx39hZF56qXK+g=;
	b=2zvg5j5fxBOiuYJ5ETXcZ61ARxlsMfHbUyrC0UXCbwz8KoxJvtQ1+ID4OA/bw8lWSOG0v8
	dO+qVdPhRspVMoDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Robert Joslyn <robert_joslyn@selinc.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Message-ID: <20250107115832.jLUSKKwG@linutronix.de>
References: <20241226191238.2559880-1-robert_joslyn@selinc.com>
 <20250107115606.q67--i0f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107115606.q67--i0f@linutronix.de>

On 2025-01-07 12:56:08 [+0100], To Robert Joslyn wrote:
> On 2024-12-26 11:12:38 [-0800], Robert Joslyn wrote:
> > This branch is needed to allow preemptible IRQs to be scheduled,
> > otherwise the kernel hangs during boot on my e300 based platforms.
> > This branch is needed for both CONFIG_PREEMPT and CONFIG_PREEMPT_RT,
> > so broaden the check to CONFIG_PREEMPTION, which is selected by both.
> > 
> > This was previously set to CONFIG_PREEMPTION, but was reverted as part
> > of removing LAZY_PREEMPT support.
> 
> I remember I pointed this out while Shrikanth posted the preempt-lazy
> patches but didn't realize that I need this in RT tree, too.
> 
> The lazy-preempt patches for powerpc were merged upstream, I am going to
> pull them into the v6.6-series.
> I am going to Cc you, hopefully you can confirm that it is working.

Robert, you are referring to v6.6-RT, correct?

Sebastian
