Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC92980B3
	for <linux-rt-users@vger.kernel.org>; Tue,  8 Jul 2025 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960102; cv=none; b=MNH5rsU1f+7fyEaS8UNQrPxkADaK3cp7J9aXcoUcBESGHN/uRDLTqEmoXa5YZ1amva8k1CspVxbb94T4CyH6xN4jbvGXWWrOROImQqFT2gL7Zlqm4uFt/Z7pCGlH4iYLqB6VaA4m9g8YieGYJNaYDC8MTSapNtE1KA/o2DwZHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960102; c=relaxed/simple;
	bh=6tqb3VQu8YUKoXHDgOn7DmVvhozmuUPkruG9uw2AN7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+d/Zva6UkP3G3/h4p8AJyDYxiKVUSxvNStFRSLps/MqhSRksiAY7ATnvqLDmyxgKFjLN1OUqmSX/TvGH7ulNdk8//u3ccUt24pvZU7Zaf8tlwrlWEs+L8aP7Xr1Ruz5NtANhnYAR7+cvHbGmJHaiJIX+8qdErbd5ixVU9iCdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eGEPhsxA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SYfRu4az; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGEPhsxA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SYfRu4az"
Date: Tue, 8 Jul 2025 09:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751960099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6tHRklRLLcc1wh1rJcz67ZjtcuZxvPpLjRbPfg+pmE=;
	b=eGEPhsxA5tF3KzAHfhF/eKvob3n9fRqizSrsVZ8U1H9fqxZG71HDmOyTDz+YwOXy0dXByC
	1/iaW6hCzcwYEVge66Jyzcu6KAe7lIxx10s80WmdjKSF3T/c3LAsTvq2U61lAiHq7AwqQF
	QE2vQxoQByWfCoC0VE/DaVxZ8egZF2Uf36jRXfsSvz/CGPZZKPHBKrhHRFy+eZaZ14BmD6
	/4hu0KqgM1ttBCZHBOEKvs46GeMEKRIbWzyh/7q1E93fjsid0VPw6IxuNZjPerRcoyxIXp
	V8VG9TtBjGJOSNNhET9LoCBPMek5sfWjfHWzO9djzAxhtGDS3D1VnDhdqzdbtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751960099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6tHRklRLLcc1wh1rJcz67ZjtcuZxvPpLjRbPfg+pmE=;
	b=SYfRu4azNPvGDa+ubooSGYlE7YYRHqxDw0JO2xaBswWdtNBd2sXey2iTx5jbXUnqjm5QKS
	BvCGKF/fd+Zg9UBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: question about semantics of RT mutexes and RT throttling
Message-ID: <20250708073457.wTm14nwU@linutronix.de>
References: <25673be5-e83f-419d-9066-336ecb32ba3d@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25673be5-e83f-419d-9066-336ecb32ba3d@windriver.com>

On 2025-07-04 14:32:51 [-0600], Chris Friesen wrote:
> Hi all,
> 
> Just wondering, with PREEMPT_RT on the 6.6 kernel (and I'm curious about the
> 6.12 kernel as well), if a realtime-priority task is on the waiter list for
> a mutex, and RT throttling kicks in, are non-RT tasks able to acquire the
> mutex?   Or does the RT task acquire the mutex even though it's supposed to
> be throttled?  Or does nobody acquire the mutex until RT throttling ends?

The rtmutex is priority aware. If a RT-task blocks on a rtmutex then it
is "next" in line before all the SCHED_OTHER tasks. The owner of the
lock has to be a RT task as well either due to its original priority or
due to PI.
Assuming the rtmutex was unlocked before another RT task could lock it
and RT throttling kicked in then any SCHED_OTHER task will not acquire
the lock but go to end of the line and wait for its turn.

> Just wondering if RT throttling helps at all if multiple RT tasks are
> contending on a mutex at the same time as non-RT tasks?

SCHED_OTHER tasks  are always the last in line. RT throttling is only
meant to keep the system going if a RT task is going out of control. Is
not meant to be part of a normal setup.

> Thanks,
> 
> Chris

Sebastian
