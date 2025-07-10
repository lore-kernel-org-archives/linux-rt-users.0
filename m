Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0703274FDF
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162620; cv=none; b=Aio8Aue/7SazN5fix8ow53s1NZOohZI0jb8Lva+w1GAgoUdPBRxwhhxb0YJmT7LdP/+mFsMHmQVqwyYx/ptWgr7oLYzPN0h5vuoUe/SyfM70Z1s1VFv50IX1eXfGr1D3NP6+ETnb28OitsyrTblpbt1qAPR9PcGdFgYyPFxTOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162620; c=relaxed/simple;
	bh=8qKwoMldSoFJAqR2IgLUMw+Ke+CgyWISgmL5Uhpawxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSOtfPoQrFeokSbKZEJlzFTmwjhuqoUWK5b7T2KfW9AFniGfsHfIgecVcbr14H8uOLLaFkwpIhkrxZdA56KJ2MooGiAoFYu/VFxROGxD3nhYq+cyIxbqKE2O1cx/1hqq66QmWPtMlRzyIkXpXvqz33dA9erxPe8IPRosKils7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsfdm1Zm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsfdm1Zm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752162618; x=1783698618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8qKwoMldSoFJAqR2IgLUMw+Ke+CgyWISgmL5Uhpawxg=;
  b=jsfdm1Zm0+FrHEQoUM7UNklLQ2KyvyX2VgM9v34H3DWygSCZ4wUFUgCt
   paMXdLO1em2gX/b7pF5T4jb7SWJEjsVDRQwCRZog8GOywjptgN2wgGp6f
   VvnGfGK9gCzUK95Pb7BfYt4ajczzN9wzPGtvKZIxT+fA7HZ1fqDCgIjT8
   tiHKqtvnWweX+zyVPW6htc/k7uBNDkNYH2I4HA/IqQueLET912C/O3kjx
   LCs/0qCMw8i3WgQ6RkFXkQl/LbvF3o5m0afJQzTlNajOuw9tVUYdUek45
   cHxgt3InpaApdUr7njAen5qzF+1kgHm2H+E68wtthOwFrvzBm+M6O0UCY
   w==;
X-CSE-ConnectionGUID: Pa2SlhVITd+Nti+eWepvTA==
X-CSE-MsgGUID: n/Wrs2ABS+ilqbBOmoJfaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57061965"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="57061965"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:50:18 -0700
X-CSE-ConnectionGUID: j3yqM9L8T0mJRY8InUSTCg==
X-CSE-MsgGUID: HGzhJdOlT7e/xQQ4nEl2SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="161815976"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO stinkbox) ([10.245.244.160])
  by orviesa005.jf.intel.com with SMTP; 10 Jul 2025 08:50:15 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 10 Jul 2025 18:50:13 +0300
Date: Thu, 10 Jul 2025 18:50:13 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: PREEMPT_RT vs i915
Message-ID: <aG_hNb-c_m0yfVE4@intel.com>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
 <20250709194443.lkevdn6m@linutronix.de>
 <aG7MckLkTuzZ5LBe@intel.com>
 <da51a963b04f0a1b628e80a2c5df72a1609960d1.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da51a963b04f0a1b628e80a2c5df72a1609960d1.camel@gmx.de>
X-Patchwork-Hint: comment

On Thu, Jul 10, 2025 at 06:52:58AM +0200, Mike Galbraith wrote:
> On Wed, 2025-07-09 at 23:09 +0300, Ville Syrjälä wrote:
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
> What does that entail?

Basic testing would be something like this:
- enable CONFIG_DRM_I915_DEBUG_VBLANK_EVADE
- set i915.enable_dsb=0 to make sure everything takes the
  mmio path
- stress the heck out of it and make sure the histogram
  doesn't look significantly worse than on !RT
  (kms_atomic_transition --extended might take care of the display
  side here, but it should probably be accompanied with some
  horrendous system loads which is a less well defined part)
- ideally do that on a potato
  (some VLV/CHV (Atom) thing would probably be a good candidate)
- repeat with lockdep enabled to make everything even harder

-- 
Ville Syrjälä
Intel
