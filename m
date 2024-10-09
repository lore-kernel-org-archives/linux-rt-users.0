Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012BA42070;
	Wed,  9 Oct 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458546; cv=none; b=u/BQIZr+NHlPnlg6a0vZbBOGiMEc1WNDv6NkpScMYavO2/alJfRWp66BWSFqiVcgcM4wBHMo7y72NT7KxchNan3XLwCIwm0yoxGVaJZghyBhW2tvxmxsEmHgkKbSq64+TsFTuLySEPHnGmFDWoVcrFaJiV0li/jWk7/WFbAecyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458546; c=relaxed/simple;
	bh=lU1+TGOSZjngrtvNvSYAx/4I9ejYNHXcu2cBGk+S0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq6EOdK04yJUgQW4zY06m7vToSD+C/kZkkl6l15lNx83F8Yoyt1UOgLpvX7pQfCO0XRBjbaKnmnFrTeg9ujDphcOfT0e16JDXx9lDBJr2cwpGekLU+J1FbAbdRXvLqmqXrD7lZw3YOXUCSk8jRIqe7QMxZKGezpBPjqr/8Y9gWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oFbNVdZY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFbNVdZY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hKTdrQqY1KerlqZ8NVlYllQr1UgAK/tqStYcq4dnlvs=; b=oFbNVdZYqt8+/2Y3DSehiJOWwE
	SLJKapBIMcFjUI/j9fHGPLmJeVp2UUyxqmyKz3LtNlZEZ3Yn3+3zq9nxa7wC/t4xtRsg4m+JHDcyx
	OAnthj+rVFjB5rxqaVpwkBMLpYCpTWSoMguVTVh5dEzHzsLKvzG2AoQiFF6TEBNMDavoj6xG4qkU7
	8+Pp6EmyInA4V6PHV+AQOsbNqwrtvFCTl+tq+w3fcGbtHzT8e/blP162ANfMdKB7wf45vQyzV6M3X
	SnEo52kSR/w1H0f2ZklwXyY/zfp9IUZv8V2Q0eZTsLYMDHQVEn11hJZAxPo5PwOI+6dfnXMs2K6Av
	hL6EU/0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syR1S-00000004q77-2P5s;
	Wed, 09 Oct 2024 07:22:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F15B73004AF; Wed,  9 Oct 2024 09:22:13 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:22:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <20241009072213.GF17263@noisy.programming.kicks-ass.net>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <20241008173859.GE17263@noisy.programming.kicks-ass.net>
 <5f125ed8-66bb-4654-b1da-b8db643b81d6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f125ed8-66bb-4654-b1da-b8db643b81d6@redhat.com>

On Tue, Oct 08, 2024 at 03:44:23PM -0400, Waiman Long wrote:
> 
> On 10/8/24 1:38 PM, Peter Zijlstra wrote:
> > On Tue, Oct 08, 2024 at 04:22:26PM +0100, Juri Lelli wrote:
> > > Does this report make any sense? If it does, has this issue ever been
> > > reported and possibly discussed? I guess it’s kind of a corner case, but
> > > I wonder if anybody has suggestions already on how to possibly try to
> > > tackle it from a kernel perspective.
> > Any shared lock can cause such havoc. Futex hash buckets is just one of
> > a number of very popular ones that's relatively easy to hit.
> > 
> > I do have some futex-numa patches still pending, but they won't
> > magically sure this either. Userspace needs help at the very least.
> 
> Regarding the futex-numa patches, are you planning to get them merged soon?
> We have customers asking for that.

They're on the todo list somewhere... I know Ampere had interest, other
than that nobody really said anything.
