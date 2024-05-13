Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433E1FA1;
	Mon, 13 May 2024 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715583592; cv=none; b=J8+bqoHKylscQIm/3dlyWjxgSiTJveVqeeCw+v1TtKTz+oN0BdSarQQDo9Pus7CzbTCgCEWyBWFTtNRtazwRT+LDDFMZtZg+EZkCUX+vXMhwSPfkfw2YMDHffeEnhWeRY9NDth6Bt86035VB68uPu+m/yubiPsI+RhxpNrhN71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715583592; c=relaxed/simple;
	bh=+QlJWeIeHVmESlV+OK30IFE5ABQo0wAgt6nEKn8jBuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKjEyylDgB+pFyBxuiKyQcQ1Q4UFzLrkjqJpOodcAx6MKBFCGkI/R/laxopyW2fG6JpzgmbRm8vHSpDTvVrwI7uddFR34dd2jAk3g3JQPjUj9PrlYv/TAQCXP8/fezr5eUwTqDp57jfd+m/XbymigtaO8eHQGyoUlQkIIEx3Sak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w1REv7aI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y764Y8pL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w1REv7aI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y764Y8pL"
Date: Mon, 13 May 2024 08:59:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715583588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYGAIigzwsVOzIOIcVnX378flEd/W0YT65rgmhlUiO8=;
	b=w1REv7aIwPEbQxbCBb7jjuer5yLMMtIy2VpN47nmcE8wJjeYJGZSpD/sQ+z9mB/fWktdpr
	z+Fx2qkOvBW+boVIj8esx01HmsxFvqTRz9s86QtJ2/W8W5YmjvN9wcJOTK7fvsqwEGrKeh
	mz5e9fm5tgEEowAjUj9umvS3x+tv+kNF41VWxNEjzuB8mAQg6J9zrM3Kq3lcOlkB/ZiHN+
	HIWqDMHBQcTE7+1kwm0XRJMJJbhG1SmyAV0iDMdxKsxGlhluBhrXFPL2oA89G/Lw4Bjx/X
	fMuCN1ixbl5o0dpPe/NcfFMcD8iDAajDnVYPUiRPUXmVdtdWQvMNn2/M7ZgLww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715583588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYGAIigzwsVOzIOIcVnX378flEd/W0YT65rgmhlUiO8=;
	b=Y764Y8pLx0BJGgo71/a/L8oPs1+vYyj5LzKk/T5Pdb/hgmrHC488lc8l0leXf6RSfyM0Og
	atk1bOCuT7F9P8AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.9-rc6-rt3
Message-ID: <20240513065952.ueOpPAaq@linutronix.de>
References: <20240430110347.LCK9LAJr@linutronix.de>
 <Zj5jVqzDMXGZtp7y@hatbackup>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zj5jVqzDMXGZtp7y@hatbackup>

On 2024-05-10 14:11:34 [-0400], John B. Wyatt IV wrote:
> On Tue, Apr 30, 2024 at 01:03:47PM +0200, Sebastian Andrzej Siewior wrote:
> > 
> >   - The selftest with the cxgb4 networking driver raised a warnings.
> >     Reported by John B. Wyatt IV.
> 
> Thank you for your work on the patch Sebastian.

You are welcome.

> QE said it fully resolved the issue in RHEL9.

Glad to here. This change is part of the v6.9 release even outside of
the RT queue (I just picked it up ahead of time).

Sebastian
