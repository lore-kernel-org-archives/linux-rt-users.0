Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB6132106
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Oct 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026103; cv=none; b=rnvyrOzk3gB+KW2yOYULNmvmYysxsSBf9DmJdsjrvWKVF95iMY2TnB2eANGsH/Ipo12bMCHlsFaQD3I//KN8gXLHc1tnLqCLa06w5qfQ2TWafjwiMU5aBAAB79AmpG11FILNTlJTmHUZRBAtwytlPZGdLubtQhI0HA4xXVezrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026103; c=relaxed/simple;
	bh=e+u/99bUR550PmlRK6RBeRAn5NUY9SmfATjGbW9ZK0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/C9N9Um699Wub0ddFs8NliBq6fIY4YN5uM8NToxBfN1XUd3vjLnCbV7UnKey+1ULFsH+oIi/PkXJDDDs/9MprmzxJNVqpqyuE777NC7pT9RgNMoIDfc535d9T8l7lp77tJ+q7s/AwyPF1mNN01UvVOKawy5RSlggcDez5InW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1pN6a5AI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ajCELKuX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1pN6a5AI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ajCELKuX"
Date: Fri, 4 Oct 2024 09:14:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728026092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+u/99bUR550PmlRK6RBeRAn5NUY9SmfATjGbW9ZK0M=;
	b=1pN6a5AIFzGmHyVRHkRKygCallhkY42Pbkm3Qtq5qsyDk/yGa99fWN0Cdc2CwT1XSbUS+p
	eR7KWdd14blmy69YZLdQ16CzECmMbCrfH8ARmBRWcl2IMR2GL/ZHcio4/Htr+e92YMb6od
	LTbiiz9VxwdTdEXN4xtBlog+bHESUNga1yv1VXuGzK6EVGjF53glAqJiGXn4vUTzHcAmPq
	lXfzuv7jN5P25UiVK4JPx5DCi1Cph3iynRwA5tzCjDDVKxpp2trdjeIQhjemfmHKaXB4u8
	G/uPpMuSKU0HcaBK3iCW39BZQWorXESjOnZg51DAlxaGxYle5dnvaEwmCLf54w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728026092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+u/99bUR550PmlRK6RBeRAn5NUY9SmfATjGbW9ZK0M=;
	b=ajCELKuX36w2QSrsDoCDVEZsTRYXhPVJy7VpowLS1BRavbVwziFIB77LDlvisew55N9bY6
	hErBl1/jMA2WOlBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mohammad Pivezhandi <pivezhandi@wayne.edu>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Problem with using CPUSET along with preempt-rt patch on jetpack
 4.6 linux kernel
Message-ID: <20241004071451.-lAqS4qJ@linutronix.de>
References: <PH0PR11MB5830EAFF75D55F0CF20B035EDE6B2@PH0PR11MB5830.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5830EAFF75D55F0CF20B035EDE6B2@PH0PR11MB5830.namprd11.prod.outlook.com>

On 2024-09-27 14:56:51 [+0000], Mohammad Pivezhandi wrote:
> Hello,
Hi,

> I am working with jetson tx2 and got issues with cpu isolation through
> cpuset when I apply preempt-rt patch. I use jetson linux 32.7.5 from
> jetpack 4.6.5 and after applying the preempt-rt patch it disables the
> cpuset for assigning core to the tasks. Without preempt rt the core
> isolation works perfectly, and I am wondering if there is any fixation
> to my problem. Thanks for your help in advance.

By cpuset you I guess you mean cgroup with cpuset support. What do you
mean that it does not work? I don't remember that something has been
here.

> Best,
> Mohammad

Sebastian
