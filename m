Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173021ABDF
	for <linux-rt-users@vger.kernel.org>; Mon, 17 Mar 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198839; cv=none; b=MpI3KOQI5vLdqwr9lkfKRgpU8wkrjfkbmhoRYkNbg9eDRQ9d5L4x6ExxPg1tzZNZyJku9p7Tb9aiN29UhGvUlJ0o76Wm7xzkBcoBk/h7Obm90kgPrRftk+kA/3lq5ujv8xmm1OE1JaLch5uzgEjWBWbwzauPFSlyyQc2orXEtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198839; c=relaxed/simple;
	bh=LOmERRiuAUgzMHYxZ7UuI89JDucAEl+8Zdyd5/x4y4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYs1zYL6W+4zwlJSe87lYwp7L/a9Nc1waDpQSlj3GBsOHoVU4Cqg7Q240XhfXjplowpycllRCPYSyO9veJRWDg4DFisp4HnCevHqlQN3NjF0tmzT58oUUhoDm1LpphtON7eq6KkLmBT6bFU6nd/wXFtt/RF4r22+ptMOzIxO1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TRQAj1DM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtBB7OzC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TRQAj1DM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtBB7OzC"
Date: Mon, 17 Mar 2025 09:07:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742198836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=domcKPnUawR3p2aSYQdYMuJNLonknuibDrGxM3+fV+Y=;
	b=TRQAj1DMuMlzVhDENniQBkWE9iA5x/MUkM/m5sNCpNMh06No9HXvICOIi8H9HiaBeOUJfl
	N8NmdAmfUoP+liKDuItBHcJb13+M3sjInEjUAPGbfPHdk6YDNbZ/1HZct147kuX/r8185j
	lAltAeFKDn2XJunT2aVqRiqAnnoa6kQxVpl+2R17x54xRGkp7wwMn70jKlILq9aT+JeDZ/
	kNCxdEpti0bMgAirBGJ53iXIB6o+zt6lf4NxvYFIDf1W7ABIAOlf0HqJsXOIqLJuH7QIlO
	M6BfK6DfmA3ScK/r1tZAE3P04QeMPIpr7rdAjan/8fshKeBC1xESU3bnFzRwdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742198836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=domcKPnUawR3p2aSYQdYMuJNLonknuibDrGxM3+fV+Y=;
	b=ZtBB7OzCxV2o067EYIXCZYRG1FMxdI9GNbb/58izg0WYfPm3CNriZoCC2rBoKSdaCs7FhS
	8DtW/TVv2BItmrDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: Linux RT Users ML <linux-rt-users@vger.kernel.org>,
	Florent Carli <florent.carli@rte-france.com>
Subject: Re: "BUG: scheduling while atomic" with nested KVM and LVM snapshots
Message-ID: <20250317080714.9ufn6kZ8@linutronix.de>
References: <Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local>
 <20250228142828.wQvZ_Tpm@linutronix.de>
 <CAMSfU+52bD40i8zp+6RsO6ckhT65GgxxNVAFO0wW+YDDoz5r2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMSfU+52bD40i8zp+6RsO6ckhT65GgxxNVAFO0wW+YDDoz5r2w@mail.gmail.com>

On 2025-03-14 15:48:57 [+0100], Yoann Congal wrote:
> Hello Sebastian,
Hi Yoann,

> If I understood correctly, this "BUG: scheduling while atomic" message
> is not the same as a BUG_ON() macro and has less side effects :
> * tainting the kernel
> * might panic depending on the configuration
> * signal potential high latencies for realtime workload
> * But does not kill the current thread (like BUG_ON() does)
> 
> So, as long as we don't use dm_snapshot during realtime workload
> (which might cause high latencies and "scheduling while atomic") we
> should be okay.
> 
> Does that sound right to you?

if you don't use dm_snapshot on a PREEMPT_RT kernel, you don't see the
warning, you don't have the warning warns about.

> Regards,

Sebastian
