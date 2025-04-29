Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69468BEE;
	Tue, 29 Apr 2025 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930736; cv=none; b=Zu5iEq+FgDw3206R5xYpSiXVAZFt8fXUK8wZrRJkyir3ayVlnrKxfhd1tV6j3vuI1F47ASpu2arOyKrLsU3P+OUwQcql5TLxySdOOmQ5a9RAyyIhhgxObPm2piQM8w/gIf9DWAwrJnXHAc6TtTyOq/kpLx/OtuPkK83zbBBpnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930736; c=relaxed/simple;
	bh=6+2F9d2vQJBN+qiFNCygGrCDiRttfJH3PpspPZdJpHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAGlYK+vJB3hxeTdtzeh0U5jLZX5IwIYIZ5FFjKYxu34ceFnKTyuJAV23nodihwDnMcVZeZ+Ia+Mnrrhf1whdUaGpAbxLVfFi0XmgqKirfRrHteQhhjzslcQQ22plJ0fh+SXhrpsHa/174RCx1oXJPt35yF5DsiJ21m3eY+257E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f83v9cDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f83v9cDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2485AC4CEEB;
	Tue, 29 Apr 2025 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930736;
	bh=6+2F9d2vQJBN+qiFNCygGrCDiRttfJH3PpspPZdJpHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f83v9cDXKLb1VwZ/DAPpgaGXVtLDI+kpIKw5NMOzQ4qa6A5nicXNdkPDgTrtU/voo
	 g5rBqU2eJq1Bo1J4jjqOWZAjueEC8rpxcJui3Ah1q6HjyJSoCs6H5pmDmiYD97MWQJ
	 58upXHW+LefVfSV0qnJCWAICk7A27SvEd4htO43DF/Z5aFxL2+zSaEAKRgXfVxQKd8
	 6ZqeZU8wVcMO0Stvx4aKB97s4Y2y4UvANw046gzyM8fYiu4Kc8y4KEUBir7/hhqX9L
	 D6V4xZ30oNREaq9zY3/6ycZtGrGVMHSsk+bcXKZxDqaj8r4JMHJbegyNCv7gAbnkDv
	 ZPLbRDCkqiNNA==
Date: Tue, 29 Apr 2025 13:45:29 +0100
From: Will Deacon <will@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
	Peter Collingbourne <pcc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 1/1] arm64: enable PREEMPT_LAZY
Message-ID: <20250429124528.GA25752@willie-the-truck>
References: <20250305104925.189198-1-vschneid@redhat.com>
 <20250305104925.189198-2-vschneid@redhat.com>
 <Z8hAZ09Q40fxLJSk@J2N7QTR9R3>
 <20250331090756.L7iXi1Ee@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331090756.L7iXi1Ee@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 31, 2025 at 11:07:56AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-03-05 12:15:35 [+0000], Mark Rutland wrote:
> > Catalin, Will, given this is small and self-contained, I reckon it makes
> > sense to pick this up ahead of Jinjie's series to move arm64 over to the
> > generic entry library (which is on my queue of things to review). Even
> > if we pick up both, it'll be easier to bisect and debug issues caused by
> > this patch alone.
> 
> Any updates here? I know it is the merge window but I don't know if
> upstream considers this or wants to sit on it until the generic entry
> gets in.
> In the meantime I stuff it into my RT tree so it does not get lost.

Sorry for the delay; I'll pick this up in the arm64 tree today.

Will
