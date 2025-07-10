Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE342777F2
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160876; cv=none; b=AKyhRYpGSAjQi8fib3Pt/8gzi3ynUpMseMn5CoWlrJA4xIfmMt+/HutpRnQqHFKRPHSgJG22uUCXVY9WiRNz3Z3Et5d1y9GG+nynJfW0QWbo6xwuSvjH3Ilq4b00T4uX4CT9aSp/1JokOvYSldOa+OqcLibYB4Jt0Ox40o0p2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160876; c=relaxed/simple;
	bh=d0E5n0/EB+UH7WM6S6v655lTkEKHYB74BAQhnlrxQXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgdNdlkWn+4TyNT8IihZ3XLeWI7MDlGm7/auwZfFWgGUhJca3KEWw8WdgGoB+7TW5/jvUjwBCmZv8NP4q7UD+g/BgZNyODOFaWyJTyfdJjM+gMTr6+AzaeIRlDrYl3plC5/3KzkMqlgnvvA2OhIp9dnfd/TYIEbFeo1p7GvFwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUZTmpyN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUZTmpyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752160875; x=1783696875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d0E5n0/EB+UH7WM6S6v655lTkEKHYB74BAQhnlrxQXY=;
  b=cUZTmpyNakliIDSa/SWn4OWAEgtSB8veeR+Q63aFBEdkCeImzYrM5HxA
   xM0oIp8vEirfTQSVM4dTiNWa7RaHynaTrDjuJQ8HiN4M/BNEBPMd5NXyC
   ALusAH2r/jjbjZSOvD1cEf6GS6nUQs00F0eycWsMNpX0eQVTrp63RJ+gv
   E2aJPYTZskAicUB0VSD9bdwfr1ArQJ4BLEIlUqm04EJNMguQQsfZ9D3Ij
   lNc8+cMj+9FsSeweA3yIteKDjr8reuFJEff388VfE6KZesdn4pM1OYsT5
   d+R5siy+F7VFm7alDEcskCQ3Ju508JK4KqvGATi1/X+1GGhXxsMh3nYhm
   Q==;
X-CSE-ConnectionGUID: 2dJM6e9UQqq4wYjACx7WFw==
X-CSE-MsgGUID: qmY8U/YOQqqXLCoYoFcyRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54323318"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54323318"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:21:14 -0700
X-CSE-ConnectionGUID: Nw711/NGSGSeuiptHPRZzw==
X-CSE-MsgGUID: ryLfEY8nQey8Ea7OPoMRyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="161807075"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO stinkbox) ([10.245.244.160])
  by orviesa005.jf.intel.com with SMTP; 10 Jul 2025 08:21:10 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 10 Jul 2025 18:21:10 +0300
Date: Thu, 10 Jul 2025 18:21:09 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: PREEMPT_RT vs i915
Message-ID: <aG_aZYhDxGVZXVDa@intel.com>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
 <20250709194443.lkevdn6m@linutronix.de>
 <aG7MckLkTuzZ5LBe@intel.com>
 <aG7na/6m/IcrJ3xx@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG7na/6m/IcrJ3xx@lstrano-desk.jf.intel.com>
X-Patchwork-Hint: comment

On Wed, Jul 09, 2025 at 03:04:27PM -0700, Matthew Brost wrote:
> On Wed, Jul 09, 2025 at 11:09:22PM +0300, Ville Syrjälä wrote:
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
> > 
> > And IIRC the other remaining problem with RT was the spinlocks used
> > inside tracepoints (which is uncore lock, and probably some vblank
> > locks). So that too needs some kind of solution because it's going to
> > very hard to debug the timing sensitive parts without the tracepoints.
> 
> A bit of a drive-by comment, but taking locks inside tracepoints seems
> like a pretty horrible idea in general. We've managed to write an entire
> driver (Xe) from scratch and bring it up without doing this.

For xe gt stuff specifically the one reason for needing a lock
could be forcewake. Ie. if you read a register that needs
forcewake from a tracepoint you might need some kind of protection
against concurrent access. But xe lacks any kind of forcewake
sanity checker, so no one would likely even know if you get that
wrong. Unless they notice a bogus register value in the
trace that is. But maybe xe doesn't use such registers in its
tracepoints atm, who knows.

And speaking for hardware in general, indexed registers aren't
exactly an uncommon thing. So the tracing stuff really should
have a sane standard way to deal with them...

> I'd be very
> surprised if this is truly necessary in i915.

The most fundemental reason is the hardware issue present on
some platforms which can hang the machine if you access the
same cacheline from multiple threads simultaneously.

The other reason is that some machines lack the hardware
frame counter so we have to cook one up based on cpu side
timestamps, and that involves the vblank machinery locks.

-- 
Ville Syrjälä
Intel
