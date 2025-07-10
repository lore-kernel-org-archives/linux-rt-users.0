Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5221ABCB
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159888; cv=none; b=oS9vmfKOofoAS7xgU8rShCJR2pYywc1qgwjdbhzExDd+dvbTzNvGMrHdn/meC7Ou/yFez+H6ENZ0SzJb1LPRIGCBKhkKgG3xhBDUC/GGZNlyH1+fwp4gsNfiGjjNUVGMQsU3XF+pxuljHWAbEPiTDnnHxfliCOO6IlRp2cVt3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159888; c=relaxed/simple;
	bh=ymzN0OQOmMbxqP3l5Qj3gim/nnQL5NzNUtbMLt/hT5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzn6VVmJa90EzcPbc7qFcVB7Iji9AEzej/bpRdUEsgLOvwrQLGb3H2kXEjEgdr65Jl2BbEKPhfN7ZHj+gc2C0u2xqUiobECecw18QYHYyQdes3KLQFWwlzapmySgKfoccQ9OepYxhA0Zz2P9HiDg+fFkr1QsQXlqxM4ZFqyibXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVf6KCpU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVf6KCpU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752159886; x=1783695886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ymzN0OQOmMbxqP3l5Qj3gim/nnQL5NzNUtbMLt/hT5M=;
  b=hVf6KCpUlB5/19BGvFxFRuWsgzdCHov7GsW/i5+WvclsS22+okt2E1a2
   uKraFSCFHmXF12T+u2997/jrw9boPNtU0VXCkwlbR3CdMOafpYy2Zl+/I
   Qds1IrDpyaQD/vLkBEgBk/VYVvgtwqwEZG3sZh3GFTTNeSOAgiNvR5Egv
   daL3tK4Nq6dKha0dfwvIFmmXqYmeI8N7wY+Ew9FWvOIWCdabhlujx0oT/
   Kc/zj7hlxvjxTBx+yAYOnnbJP71axT6Eq6G5GAb9ChEHXgBigM9Hx1jkX
   j4uzE+DS5wuzfQTAmvzvAWrkmVlVlz6Lxr0LiFi/jSYsP3f7StsaVMPYi
   w==;
X-CSE-ConnectionGUID: wX8qhfPvTOyCPuLyuHtsUA==
X-CSE-MsgGUID: Dn65DhpPTbiKga8YYsYOeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54321420"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54321420"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:04:45 -0700
X-CSE-ConnectionGUID: h/ZtnT3DRsKiCm/16mmIrw==
X-CSE-MsgGUID: 2rW0fFz/S4q4uWAxsl3Jlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="161805873"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO stinkbox) ([10.245.244.160])
  by orviesa005.jf.intel.com with SMTP; 10 Jul 2025 08:04:43 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 10 Jul 2025 18:04:42 +0300
Date: Thu, 10 Jul 2025 18:04:42 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: PREEMPT_RT vs i915
Message-ID: <aG_VzpXaYRCQQGYt@intel.com>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
 <20250709194443.lkevdn6m@linutronix.de>
 <aG7MckLkTuzZ5LBe@intel.com>
 <20250710064136.rur6FoOU@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250710064136.rur6FoOU@linutronix.de>
X-Patchwork-Hint: comment

On Thu, Jul 10, 2025 at 08:41:36AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-07-09 23:09:22 [+0300], Ville Syrjälä wrote:
> > On Wed, Jul 09, 2025 at 09:44:43PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2025-07-09 20:30:26 [+0300], Ville Syrjälä wrote:
> > > > > 
> > > > > It seems like the critical uncore lock is currently held in a lot of
> > > > > places and potentially for a long time.
> > > > 
> > > > It shouldn't be held for that long. I think it should just be
> > > > a raw spinlock.
> > > 
> > > What about I resubmit the series and we look again? I don't think the
> > > lock should be made raw just to be done with it.
> > 
> > Until someone actually does the work to confirm the thing is working
> > reliably there's no point in posting anything.
> 
> Well it works on my machine and this machine dose not pass the code
> paths that I patch.
> 
> Every patch made was done because someone reported an error/ warning and
> confirmed afterwards that the patch fixes it for them and they can use
> the machine and don't observe anything.
> 
> > And IIRC the other remaining problem with RT was the spinlocks used
> > inside tracepoints (which is uncore lock, and probably some vblank
> > locks). So that too needs some kind of solution because it's going to
> > very hard to debug the timing sensitive parts without the tracepoints.
> 
> no, not just that. Making the lock raw led to latency spikes in simple
> spikes and I just disabled trace points. It could be worked around by
> taking the lock if the tracepoint is enabled and then invoking the
> tracepoint unconditionally and not taking the lock anymore. Steven made
> a suggestion a while ago how to put this in macro as far as I remember.

When this was last discussed I suggested that there should be a
versions of the tracepoint macros that do the sampling outside
the lock, but that wasn't deemed acceptable for whatever reason.
I don't even know why the current macros are doing the
sampling while holding the lock...

-- 
Ville Syrjälä
Intel
