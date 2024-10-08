Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345420ADC9;
	Tue,  8 Oct 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410956; cv=none; b=VJGBeYWyQg0A1PJrsBLYYMPvmO5O5b+r+RB9hdib7vfgTTLmrtuo4CZAW3oWK803/ISC/WLdcPbbuoRJQI2pEMUavZPRHBTYG3LtFSVmmnhNqscA5RoBxQZ6VKoLM/tnuwO2zYVRpF2J5M3iyk2HWI3DALEwMm7EJIO3q8gX8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410956; c=relaxed/simple;
	bh=EhH9DC1i9cz8xPTOhL6YRHnQ8m9vWEkv8IP9TCDsvd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdRiEEFyGmVB6fb2kbUTvWdYUan16HEEdIeAy/GftgHV9msohiesifNrXE3cH1T1EZGt0kjM3QIouMwfImFSa2zjIXwVZZmoDidBysmZdNRWPcc5zcaoNBrSinnA62FAeumbx/6loHYzdRYQPpEACbJqHphpxC1iZYG0SNVL0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9BYbyXe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+hdnyHbL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9BYbyXe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+hdnyHbL"
Date: Tue, 8 Oct 2024 20:09:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728410953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhH9DC1i9cz8xPTOhL6YRHnQ8m9vWEkv8IP9TCDsvd4=;
	b=N9BYbyXefgSWIiYEf4qVWdZdWtXAJhYa1z+rB+MCCmciWnWubgbb2eWBA5ADkntCnrXOoX
	1daNwreD5wcHm81KGdTZ6dZuzpEPLmk+Upz3iG6yIR4paxwef/fDWeT07/uvitPS9dGC8n
	cH2jJzNv+x/GDrCK6gTdWDDGOdFR8oxXUdtJ5894MJLdjidQICgsNM/F84BjzqWU6ahg0S
	prTl6JqC4bu1swbIBySmCriNfzgct7l6PKAcJRakGUM3HCijzsXWEqONAdOjYU7KU43yFW
	JQyks7NPpb0s+L9pK274St/6+0XpuN77yNSzS0xdZz/zn13tOKoLqMYTelpBIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728410953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhH9DC1i9cz8xPTOhL6YRHnQ8m9vWEkv8IP9TCDsvd4=;
	b=+hdnyHbLxnOG4ef70EQs8c9ALb31wcaY2hQDzwCHGOVTIwRjk+JjCnkY7Sc0oDBbnD7g0x
	GhmLP+zO1ojKDhBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <20241008180911.JiqZxSLg@linutronix.de>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <98b3dcb0-8b64-45a5-9531-16aeb010c052@igalia.com>
 <20241008155129.z7ZZVzW3@linutronix.de>
 <46c259c2-5503-4a63-94ae-96660e5ce0eb@igalia.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <46c259c2-5503-4a63-94ae-96660e5ce0eb@igalia.com>

On 2024-10-08 12:59:24 [-0300], Andr=C3=A9 Almeida wrote:
>=20
> So if every process has it owns hb-lock, every process has their own buck=
et?
> It would act just like a linked list then?

If you have one hb-lock, yes. But you could have 4 or 8 slots. A slot
has 64 bytes due to alignment. As-is the 8 slots would occupy 512 bytes
of memory.

Sebastian
