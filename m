Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91A2E11A4;
	Fri, 13 Jun 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844723; cv=none; b=jIgSpI89SCFgoozamLaQTlaBYklTKljSMSdHU1HsLzR84e2PMbw7teb7Cnc+/JbLSe6QCq0UTWlbzcMIdTXQIemAiIy7o0hnwdyc8G9HUAjktwOrnUO9QUxuT+lEQQJyAD7KT6LLr9Cqm8nJOiBJB8413G2ISVLeUHBXt9nBcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844723; c=relaxed/simple;
	bh=ymXTtsfX9C9aaHeOfLlUZe3fofSZISf2I3CC4sJN8cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXsO0+wtJ2RNwLVjQKOHmn64c5HfYg8CsY3eDoGTHuynExbVlshbONk3ufSd1S4EjxrUckRLwgQevHuyXW6hA2eFI3Up7ybL19CrLVB6E4/yVgQZFQj45HaH/cGveLj8B08VIj65afLwDmFbqNqf6UYOmlEG2N4Anpziglp3omY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uyRtt/CT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x7gHM2VE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uyRtt/CT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x7gHM2VE"
Date: Fri, 13 Jun 2025 21:58:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749844719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymXTtsfX9C9aaHeOfLlUZe3fofSZISf2I3CC4sJN8cs=;
	b=uyRtt/CT1kCkvstsyyry8N4E/4bj2rOMOikcSuPPwTujBXT4p6MEdengs7hsRSf0vaAVIf
	uJVl3wlJAXpmE72iaTEKoj5dpJJiFQaklD1D5eQF7SAg5Hr46OFxi6Y2krFVVPj8RY4i30
	j9Sn8PdNOStgdu6UKl0tQui/zE3SNAv6uss+e0KGvWwneumNEw14mXbJTY05PLLxrJdiFN
	yM9T/WG913BFh/rhQvImP3wchvEuOQOtzwMr6ESfgFwKVjo+2uTDCpF97XYIZzw7wS94K+
	LzDjZG+8Vqhmsz1umCc3OYa5IovWz0x2OvSBz3NXHqFf7+LiM/QGhNk5nbnt/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749844719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymXTtsfX9C9aaHeOfLlUZe3fofSZISf2I3CC4sJN8cs=;
	b=x7gHM2VEYOQNqJm5QCfWmK7ELuFJA2kEMy9Lo6Pou3R/HGNyLMCwEiRIuN7PJKtZSXfgMe
	awWT6yYqxEiQOTDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "marc.straemke" <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
Message-ID: <20250613195838.0-gZ6bqS@linutronix.de>
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>

On 2025-06-13 17:26:15 [+0200], marc.straemke wrote:
> Thanks Sebastian, I will do that tomorrow.To confirm: Just pure event
> tracing without the function tracer? (After enabling the sched
> events)Regards,Marc=C2=A0

The event tracing should narrow down which of the tasks cause the spike.
So if you say it is the ip comment then you should see ip.
Step two would be the function tracer to narrow it down further. You
could start right away with the function tracer to see where the big gap
is.
rtla could speed up the whole process (via the timerlat auto analysis).

Sebastian
