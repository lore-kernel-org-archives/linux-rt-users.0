Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F6206962;
	Tue,  8 Oct 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409149; cv=none; b=PwMuvt5dVXSSknXmNbYGesg3D+cFc0eeATUFKJR5w25Oxmsp2en157kwUC6lRyUWD2+t+ge7Gh2Bf1OIUtt1mF8V+nadYeq56UeBB7xRe3xHlFcBn3b7T2ii0VQkJln3/NaMLCsKKO9xJs3zgHo8CkmakvrSTspijZLZpWtc31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409149; c=relaxed/simple;
	bh=LeNmQrCvMNToDiO8+U1mr3Y/hn1bq2qDwFPHijzQuOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRpv7H0garhs1exO+4+tOGRXHlEqokOY2AV2TLnVXzhIuIG00jVL0NZYAE2l8babRI2TRJxw4Ly4+wROLRzVH3eMCc652kcuasdi99KT25amkhqQReuSmA25A3xtTPuoH/1gvvPj1SvjTF01Jx4XjCSOzpB5veU5yCzi6icBAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DHDV2LrI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DHDV2LrI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LeNmQrCvMNToDiO8+U1mr3Y/hn1bq2qDwFPHijzQuOA=; b=DHDV2LrIIQAjuxu4quq9XxH46o
	+a5Kg93/BhPUz3F9q7f8t50MkOgIP1DTLW3DU6OFzSyGK8Q0dVmpvfhOKPErC45Q9Eo58KKDuOxHh
	di55iWcvYcx0HACbiD/NL/amMGbyIgMO3yST6fmC4eCVv/URiVSR5+/6ODRq2BBFNv6j1r4NLAT0l
	3ommyHCh4yW4qVxGnmgDfIEacshrGs6n4HyYtxIQn3Js1ifFrCy1cSPDGA2H6di1GO0udaxbr+h/d
	H205lD65Imt6q8G0/p6mlGikpjWoWqKGcCXucMavT7cqGgKLaD5BDzUROzq4Jg603CML2WdiqW4U/
	edq7GUiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syEAm-00000002qRG-0gZ3;
	Tue, 08 Oct 2024 17:39:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93E47300599; Tue,  8 Oct 2024 19:38:59 +0200 (CEST)
Date: Tue, 8 Oct 2024 19:38:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <20241008173859.GE17263@noisy.programming.kicks-ass.net>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Oct 08, 2024 at 04:22:26PM +0100, Juri Lelli wrote:
> Does this report make any sense? If it does, has this issue ever been
> reported and possibly discussed? I guess it’s kind of a corner case, but
> I wonder if anybody has suggestions already on how to possibly try to
> tackle it from a kernel perspective.

Any shared lock can cause such havoc. Futex hash buckets is just one of
a number of very popular ones that's relatively easy to hit.

I do have some futex-numa patches still pending, but they won't
magically sure this either. Userspace needs help at the very least.
