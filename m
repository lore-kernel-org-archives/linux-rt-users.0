Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B082749E3
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057819; cv=none; b=LGgNJT7pH4tOkWyX8AbtyZGE5kTgsr3c3s/Mf9S6Cd3am+CpPDc7d0qsebqt3S53Lv8g9yR+8Phq6m9+aukC2jYOY1/bBI63/Y6X8uNQ47IyWap5fkrl1s1yJ40wsdB6p7+fiyL2Kzl7SVrApnz6MiSYzVl9ZEUeuR/PH7XyyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057819; c=relaxed/simple;
	bh=oZH73HwDHaeAO/HEhyjMk3U0j+tByEMowX5f4r4SM00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8g8OptQWQALjYVxu6AXFpWUCaV9seW09zUhoW8fIJq8BULIAqQLnZ6If4X4vXf7F2Q0BzWCcSgtFdRVx/MtsJE12wCLrp8WF9aO6u3P3D6YCyufHkWaIuHrXitTGVjMTkeXl86BoJsR8k86SXkEuQy1mRfqpBzwlSFnZ557h9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UBoHV248; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7zE+e4VT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UBoHV248";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7zE+e4VT"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761057816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQY4fSAjtHt0cLOVpt5VGH3RqzsBuAghRn0J25QtCNM=;
	b=UBoHV2488/dmjOMq/LDQEhsA6XNnLP38N2nXA4lYa5je2R8ZsjdS7yiOuM5N86J8wfwKB6
	/SK++swiU72Aut7K8GNo8+MBp4IyGIpCLhP0aSNyVaTbRDVvYlrWXhCUuPmwIyxbehgUIc
	RVWP2gWzpql1WyXX3q/fGJsjPuPFZv0efVSez4KmhoFIfPu9BT6yBb/If61dQpcWv9XDRy
	oAMRc3C/1eF7X1kRHGkhgb1XIyzIMV6xhrmqu/AiWJ4lIv7VYm6aDVuMWA3d9In28+f68F
	jGM9kx3MNnY12QJn5rVQWVT3zszP6zboOU8hBWo4pQJ3Ue+yjVJohEkk8RWE0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761057816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQY4fSAjtHt0cLOVpt5VGH3RqzsBuAghRn0J25QtCNM=;
	b=7zE+e4VTqu6cnGFLaD0bsKFz/oWnMxnPM/F2w9xWrAbE+n6DEgNQ8arTJxf9ZM70mcP9Dz
	T0ip9blTaETTzdAA==
To: "KHUENY.Gerhard" <Gerhard.KHUENY@bachmann.info>
Cc: "KHUENY.Gerhard" <Gerhard.KHUENY@bachmann.info>,
 "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Subject: Re: Realtime throttling and Real-Time group scheduling
In-Reply-To: <AM9PR05MB77775F0B030DB96B505F00FB9BF2A@AM9PR05MB7777.eurprd05.prod.outlook.com>
References: <AM9PR05MB777740C6836026CE5A7F5F1C9BF5A@AM9PR05MB7777.eurprd05.prod.outlook.com>
 <874irt6hk8.fsf@jogness.linutronix.de>
 <AM9PR05MB77775F0B030DB96B505F00FB9BF2A@AM9PR05MB7777.eurprd05.prod.outlook.com>
Date: Tue, 21 Oct 2025 16:49:36 +0206
Message-ID: <87frbce2nb.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-21, KHUENY.Gerhard <Gerhard.KHUENY@bachmann.info> wrote:
>> > I'm running a 6.12.39-rt Linux kernel and have been experimenting with
>> > runtime throttling on my embedded hardware.  However, it seems that
>> > the settings for sched_rt_period_us and sched_rt_runtime_us have no
>> > effect. In my kernel configuration, CONFIG_RT_GROUP_SCHED is not set.
>> >
>> > Is my understanding correct that CONFIG_RT_GROUP_SCHED is not required
>> > to throttle real-time tasks?
>> 
>> Yes. But instead of adjusting "throttling", you adjust the guaranteed
>> bandwidth for !rt tasks. You can read about the fair deadline server in its
>> original commit message [0].
>> 
>> Basically you can adjust these debugfs files:
>> 
>> /sys/kernel/debug/sched/fair_server/cpu*/runtime
>> 
>> to guarantee bandwith for !rt tasks.
>> 
>> And yes, we are aware that proper documentation for this is missing.
>> 
>> John Ogness
>> 
>> [0]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Do
>> cumentation?&id=a110a81c52a9de73e2e57e826dd3bf0fd4c22226
>
> Thanks for clarification. So this means that if CONFIG_RT_GROUP_SCHED
> is not set, the parameters /proc/sys/kernel/sched_rt_period and
> /proc/sys/kernel/sched_rt_runtime have no effect?

They have no effect on the "RT throttling" feature, which does not exist
for CONFIG_RT_GROUP_SCHED=n. See where it was removed here [1].

However, the parameters are still used for admission control of
SCHED_DEADLINE tasks. And likewise they also affect what values can be
written to /sys/kernel/debug/sched/fair_server/cpu*/runtime to configure
the fair deadline server.

Note that this is all new starting with v6.12.

John Ogness

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
