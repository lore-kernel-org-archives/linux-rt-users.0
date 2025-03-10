Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7CFE573
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Mar 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617107; cv=none; b=LU73+N3TQ9ZbDMCzcSyPF33bIcr7rmuq2vaVYYzlfHEgrQkIwXTdS8dSw3Ce0nUED7iSDqQIuvMPL8zxTqaJnqsXEJNPkm8vVShQdMzCOq5hucM6tsyaBH6MLHuKi2Rf2f6OFhrZAbIjFMad7EoJKub1KWCJ6vte/aKGv8xamQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617107; c=relaxed/simple;
	bh=lE8W6A1kW+OvW9aWeAEUIJB6L8GSrT7LIwEB2zwCWRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNPQt9TzrUtasElGjcnEbNw9cVM0od04e7dq22zRi2dlYpLlx03PI8i6mwB3eM8yA2pIAPsiL6wjpw2iAgUkWOlepD1WDLNdDeUN5PgYRGYMK4BjhHr/I+ctF0XuXIAREdTGetQXysf3azPRG6BDc2uJp1ytfY+Pyu3exnblMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZ8PRE40; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mQv0qyLC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZ8PRE40";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mQv0qyLC"
Date: Mon, 10 Mar 2025 15:31:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741617104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7C8fsaTzLFFU0ghPoZEVt3GxzYtVYlLHNSCrIs+s1o=;
	b=LZ8PRE40tHGLAKH2CuYX1+v2zHD6Jirb1jFMrFVZ84qGw780YldvB/+tJ3zscBS1Ib1Qq+
	0kzTmtEFQfrgL9fFR6YSpIFn0ruCE43iXa+itYJgBy7GWetOejR/zIguUyxKCQSr+ofls3
	sxdkFYTWDfVmm7mU6A84Z07g72zP7erUl5L3+tA694DAX2tSeqIhkL4ltE4t5/60q+SFko
	9SvpuMFmmtOpItCUPfY0fnK6AqcPvbsNMjVvc/DT0EEIKtcBMeckeFUXhjsezDwwO8uLNq
	aOUfRj8vMAMMBheaSkqAjVZHCAhWuJ7cFD5T060v/RkE3rXTeZx3pjwxFZLGsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741617104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7C8fsaTzLFFU0ghPoZEVt3GxzYtVYlLHNSCrIs+s1o=;
	b=mQv0qyLCpyQORHuTzZGOc9j8ExkwzshywsyneCsb7LZxjll9Ukk1P0y8GD5OQUSAosR0BT
	tydK0Zhew3OntdBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: linux-rt-users@vger.kernel.org,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: 6.12: i915 not allowed in combination with RT
Message-ID: <20250310143141.ymOjk-jm@linutronix.de>
References: <a3444741784adda2b9ff462ca5d92d343ef700ba.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3444741784adda2b9ff462ca5d92d343ef700ba.camel@siemens.com>

On 2025-03-10 12:31:21 [+0100], Florian Bezdeka wrote:
> Hi all,
Hi,

> the following commit (taken from 6.6-rt branch) resides in all stable-
> rt branches but is not part of mainline 6.12 and above, which makes it
> impossible to use i915 in combination with PREEMPT_RT enabled.
> 
> Is that by intention? Are there any known issues that makes it
> necessary to disable i915 in combination with RT in current releases?

As noted by Luis the revert is only there because the previous patches
"fix" the i915 to the point where it seems to be working at least on my
box on people's that were complaining about things.

Those patches were not merged upstream by the maintainer therefore we
have the disable patch upstream while revert is only available in the RT
queue.

I have a few other things on my list before I go exploring the i915
dungeons again.

> Best regards,
> Florian

Sebastian
