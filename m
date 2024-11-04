Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A267C0BE
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Nov 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721624; cv=none; b=acISzlrnxqOCdo0SqocIzIwBLW7ek2WOspyOati2su1X83pYGk+EOy3Dz76rFD3/+2uKq77ReryuVxi1RAUi4nkoJYgJ3tR1TeNZMEV9uVQnUD1Dc4NQTWs014O+9F5vkttnOe2sL/6Pm1bSrgRNF2xwt/3cYdJeTgDMerMYYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721624; c=relaxed/simple;
	bh=5BBFrW+8ZM+Zvr5DyoLUHxrYdi1HDfVs4SSZGaEByas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSs24tFKdE8j3FBDU74xre+4hv4HS9wbtwl2u+RxgjgxucJjK3S06yhaBeMGH9SxLOWRayTPRBsQ99EcOD4WGErmnNCmwwIXPaNhiWyXxU8xQ3Y025HoDw7L5Kmv0z4vhaDD2ryieJY+2pT8TanfZXxSWrJA9EUpiuZH7VhbBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VI2ttQq3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=buXjHz26; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VI2ttQq3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="buXjHz26"
Date: Mon, 4 Nov 2024 13:00:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730721621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsWwQK/l/iQLgAEaRvMD5opizwsMO+ss72Cp0nqlJeE=;
	b=VI2ttQq3eIcLWcNdQYQqS7JloKgr60U26VkXNnF26Br6SEpA0Y+OrBQoZ+Z89IwuM/DdV0
	A7JNKVJtdX6pS6kB2jaStlhQLidsDUHRfxndAEKYtGsAhMBlbabfvSysIsNz3QOLi9GoGO
	uWWFeZRNQq2VEb7r/bH6s2/xq1zYjENNcv8aZ2FyAnki/ODQrPw4sFxCicTN4thiQrNSLY
	gsAoh7SI9dvdHFMeHTH6Dg6/4FjRu89UqGcT1hoPsIxuRq+B6zndwIVgZjiDxVD/HH7DLa
	QtrgN6wtnSUD1vfYudTaNhH3WacsR2+bg3VyXuyviXEk9US2kGl8fTvK2O1WHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730721621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsWwQK/l/iQLgAEaRvMD5opizwsMO+ss72Cp0nqlJeE=;
	b=buXjHz26eJ+v6YXygo4xwhjKT21UmOY9foZgy1niY+7K+VIVMyTu5XnBpvVzBX8WKjlv0J
	I1+ZSSPZdJKdOtDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mohammad Pivezhandi <pivezhandi@wayne.edu>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Problem with using CPUSET along with preempt-rt patch on jetpack
 4.6 linux kernel
Message-ID: <20241104120015.ud-HnHQZ@linutronix.de>
References: <PH0PR11MB5830EAFF75D55F0CF20B035EDE6B2@PH0PR11MB5830.namprd11.prod.outlook.com>
 <20241004071451.-lAqS4qJ@linutronix.de>
 <PH0PR11MB5830EF5266EE9F931790C2E7DE4C2@PH0PR11MB5830.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PH0PR11MB5830EF5266EE9F931790C2E7DE4C2@PH0PR11MB5830.namprd11.prod.outlook.com>

On 2024-10-22 14:26:55 [+0000], Mohammad Pivezhandi wrote:
> Dear Sebastian,
Hi Mohammad,

> Sorry for the delayed response.
> Yes, I=C2=A0mean the cgroup support in Linux. The change in the path value
> referring to the creation of sets of cores does not take into effect
> although I checked the CPUSET configuration to be enabled after
> installing the preempt-rt patch.
> I rechecked whenever I reinstall the kernel without preempt-rt it
> becomes enabled and works perfectly. I figured out how to use the
> application level of cpuset configuration like assigning cpus through
> cpu_set_t on a c-code but in kernel level it still doesn't support.
> However, I checked the preempt rt in my laptop and it seems it works
> perfectly with c-group and this issue is only in embedded system Linux
> kernel of jetson tx2.

I don't really follow what the problem is. It might be that cgroup-v1
was not/ is not supported. We made a cut at some point.
Also v4.6 is not really supported in any way
	https://www.kernel.org/category/releases.html

I would suggest to use something more recent and try again. NVIDIA
Jetson TX2 seems to be supported so a newer kernel should not be a
problem.

> Best,
> Mohammad=C2=A0

Sebastian
