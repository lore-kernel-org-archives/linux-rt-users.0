Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FBB111A8
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Jul 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091769; cv=none; b=J+MFw5j3+fyAohTotv/nsT8tVViDemR2Z0GP9cDkzWx9BlBQNohdgj8RZ8ZmSFvFXCgZpeDl+WL/Hyzuq0otFsnLNAun2hj3AoR14L/iqLsZD00/3C57VtFY9iYMbST0GENkfSibHrnOr80K2yyYlNPLIbxwWnVf5YU9VWwasu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091769; c=relaxed/simple;
	bh=ew437jZZzUtNEW+hKJWQw2cXISzgxG9iDRIQDnuG6dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/54BMGv22qZpKbtwMfq++PDj7/u5mptr2SXv5lRNOKvvoqKZApQxCn9+bHPtbZWDf8fJv08K0p6WIxdiXoe7m+3pNrHy2shjY5lkhqU5LU07qFBL01X6wdb3JA7d+H3sui4dvl2JHzAhBqc7YNj77ZDROZlBi4p94ohKHcT1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAOzdJxh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAOzdJxh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091767; x=1783627767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ew437jZZzUtNEW+hKJWQw2cXISzgxG9iDRIQDnuG6dg=;
  b=cAOzdJxh0fNOu4+ui/iRw2sq3h6cRImgi4W7h8tX5UcfuTIjOtKd2x+7
   CeRBceAA2/DVithOiHclLFztgGDX8QCRLk0kzt8D+eu4fk+24EOFoAMb1
   +yT6R+avvrUwWu8dO1A4yZ6BmXeVXFOTMle1kv5QuH51eNg0ISFhrOovJ
   yvP7TYpaaYi/mH77ZmZXJ/a+tLdW44SPtbCSMbRD5qYm3hZCBUAbFCrDY
   E0JF2bofut2OyohNJPfmC4GRSGyVBLdPRBuPTsWj38qxThUdF6BCoHiP2
   fLh/nvxJspNAgE82Rxs3ORF/RULK+vPezt8HwiYC8EPXkdOgGSeZ/J0Do
   A==;
X-CSE-ConnectionGUID: vydI58Y1QhS/S3hRLaGhnA==
X-CSE-MsgGUID: ctRMnf7hTnO/OjQEUez9WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56971988"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="56971988"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:09:26 -0700
X-CSE-ConnectionGUID: pbREcFI9SoGVLEVrDuroiw==
X-CSE-MsgGUID: Sm2uVTLkRtuv9BpAD9V/WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161528138"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO stinkbox) ([10.245.245.254])
  by orviesa005.jf.intel.com with SMTP; 09 Jul 2025 13:09:24 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 09 Jul 2025 23:09:22 +0300
Date: Wed, 9 Jul 2025 23:09:22 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: PREEMPT_RT vs i915
Message-ID: <aG7MckLkTuzZ5LBe@intel.com>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
 <20250709194443.lkevdn6m@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709194443.lkevdn6m@linutronix.de>
X-Patchwork-Hint: comment

On Wed, Jul 09, 2025 at 09:44:43PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-07-09 20:30:26 [+0300], Ville Syrjälä wrote:
> > > 
> > > It seems like the critical uncore lock is currently held in a lot of
> > > places and potentially for a long time.
> > 
> > It shouldn't be held for that long. I think it should just be
> > a raw spinlock.
> 
> What about I resubmit the series and we look again? I don't think the
> lock should be made raw just to be done with it.

Until someone actually does the work to confirm the thing is working
reliably there's no point in posting anything.

And IIRC the other remaining problem with RT was the spinlocks used
inside tracepoints (which is uncore lock, and probably some vblank
locks). So that too needs some kind of solution because it's going to
very hard to debug the timing sensitive parts without the tracepoints.

-- 
Ville Syrjälä
Intel
