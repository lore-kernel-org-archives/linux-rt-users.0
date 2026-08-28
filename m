Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F2331A65
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Aug 2026 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933420; cv=none; b=cByHfw489ZcRNLHWtm7FT7txtctQCqZHEjMZN1Uu/XgGfYbipULAF8XaInQ3RHyEAksGwPmX20WY0OdUE97pXMvxMlQkmyHwQ0fULbx4SccH8bv8jwdInA8aUd+vU9iSZiwlO5Et1RnVP+VR7UlRsyRYCfvroq74mwet+VUoFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933420; c=relaxed/simple;
	bh=BK58HVWFkgS0qBVAHlPneH0gJrg10gifb+S+PKBiXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmyw2U9T/vW8iCTzzOukoMgPH0ehdIJTsx89OTg3coWXtMCUs/TA0Ky320Gwc1CoChhcTY53TYotoB7iOaCKeuBSTHK5HjfedM6db7GdrJSo5Rd0eOnYzfogdK699ED1QfaWhBK895a/zw+GGPaW+EYsHQRXGvss0Scos80C6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I2ejq+z+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nr0aQUxz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I2ejq+z+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nr0aQUxz"
Date: Fri, 28 Aug 2026 18:10:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787933417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fMwg2XclRViDBueu44WoHquw2rAoKMryAsOiOfghIoM=;
	b=I2ejq+z+qsQwmTHDxXICTdOkQcJbW2pttiB2AlKep7xGRMlXwvMGKYEwFZLvqR65zqEY9q
	KDLfgFKbBKfBMFTU/cSzUTvR6b+XSIcmX4eiiWc9E0ICAwHqT5BcUA38qLNxuWaQHEJqWB
	PbSu2R++OhwkuK3fY5bNoY/OzHcHCtOtT8FxK05VRrNyeIqV5Hbn6FHzgsQbuZ1tyXueMY
	/Nslgetibgo2ujXKk4VRNaF9215HU8oY5xTGKDEbv+REnW1DqOV3U7JA1nh0NwoxnybPFy
	GINegx+KoXP8b6+Bf3e4SpZveU7vVkQ7jC2ISDHyyOTRtaayksrD8bozaGdHQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787933417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fMwg2XclRViDBueu44WoHquw2rAoKMryAsOiOfghIoM=;
	b=Nr0aQUxzyV/vs0b9DDkByYIrO/iH6zg1smd/k1yoXAJ0QovI5WtOUulpXM3mkxmGxNdTBX
	t1MDixbR61eYyZDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Kacur <jkacur@gmail.com>
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 5/5] cyclictest: Add a timestamp of the last update
Message-ID: <20260828161016.-zQq0HyY@linutronix.de>
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
 <20260826132153.2476006-6-bigeasy@linutronix.de>
 <f6692168-cc78-d625-f750-bf979be73dfe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6692168-cc78-d625-f750-bf979be73dfe@gmail.com>

On 2026-08-28 10:26:59 [-0400], John Kacur wrote:
> This creates a really long line with redundant information, for example
> 
> T: 0 (36716) P: 0 I:1000 C:   1331 Min:      1 Act:    2 Avg:   12 Max:      
> 71 Fri, 28 Aug 2026 10:18:32 -0400
> T: 1 (36717) P: 0 I:1500 C:    887 Min:      1 Act:    2 Avg:   10 Max:      
> 62 Fri, 28 Aug 2026 10:18:32 -0400
> T: 2 (36718) P: 0 I:2000 C:    665 Min:      1 Act:    2 Avg:   28 Max:      
> 56 Fri, 28 Aug 2026 10:18:32 -0400
> T: 3 (36719) P: 0 I:2500 C:    532 Min:      1 Act:   52 Avg:   36 Max:      
> 57 Fri, 28 Aug 2026 10:18:32 -0400
> T: 4 (36720) P: 0 I:3000 C:    443 Min:      1 Act:   51 Avg:   21 Max:      
> 55 Fri, 28 Aug 2026 10:18:32 -0400
> T: 5 (36721) P: 0 I:3500 C:    380 Min:      1 Act:    2 Avg:    1 Max:      
> 12 Fri, 28 Aug 2026 10:18:32 -0400
> T: 6 (36722) P: 0 I:4000 C:    332 Min:      1 Act:   52 Avg:   49 Max:      
> 62 Fri, 28 Aug 2026 10:18:32 -0400
> 
> Why not strftime(ts_str, sizeof(ts_str), "%T", &tm);
> This will still go over 80 char, but it's more succinct.

I have do this wide screen here now. And I was using it on a test box
over network in tmux running for some time so I figured having a date is
helpful.

> T: 0 (40468) P: 0 I:1000 C:    282 Min:      1 Act:   52 Avg:   17 Max:      
> 65 10:25:32
> T: 1 (40469) P: 0 I:1500 C:    188 Min:      1 Act:   51 Avg:   22 Max:      
> 56 10:25:31
> T: 2 (40470) P: 0 I:2000 C:    141 Min:      1 Act:    2 Avg:    7 Max:      
> 55 10:25:31
> T: 3 (40471) P: 0 I:2500 C:    113 Min:      1 Act:   63 Avg:   19 Max:      
> 63 10:25:32
> T: 4 (40472) P: 0 I:3000 C:     94 Min:      1 Act:   52 Avg:   27 Max:      
> 54 10:25:31
> T: 5 (40473) P: 0 I:3500 C:     80 Min:      1 Act:    5 Avg:   43 Max:      
> 56 10:25:32
> T: 6 (40474) P: 0 I:4000 C:     70 Min:      1 Act:   51 Avg:   27 Max:      
> 55 10:25:32
> 
> The other patches in this series look fine.

Drop just 5/5 and I think of something once it bothers me again. If the
first four are good then the actual problem is gone. Thank you.

> John

Sebastian
