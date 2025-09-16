Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA31C862F
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Sep 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009012; cv=none; b=IeUdNGgOaN6f9jkI3rVY7WD0X3hEpBrk65ypATdKyfJUh8JwfTPej/1QC4tKxDZTU3Waw/K3Mmwq/qBYFbKzJMEQgjDD0HuCU1HtDwqgXkyzHPwaC3We3bfH7J5pX6cXE5EKUAxIrQmv6ODMyI87o+0qEVitTMRHUVogt8RBZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009012; c=relaxed/simple;
	bh=N9o69Tti/DNiPVIhTDuPeiwB+qxp82w1yD/HVfGRGdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNl0L/JFj/lZRLexqfT0IkQAB+aJfzEaYwjICtdF9gtI1zbsJ83kabZWWHXrDCXeKoNJ7SsltXUyOYVdPKyok/UCAfX90VWbYkdusqpQs/JglwSNhk1Uk2e8swBgscqDfEcPgDyWKDr+PdDGvaeNLhGNFkBGyatnnidaWPecZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aKtXhLS4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/LJ7us7e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aKtXhLS4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/LJ7us7e"
Date: Tue, 16 Sep 2025 09:50:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758009002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N9o69Tti/DNiPVIhTDuPeiwB+qxp82w1yD/HVfGRGdE=;
	b=aKtXhLS4CdIVRgOTigKokaCz51klmRm1aSbU3brq0BXRLe4iaqtLVOLs8d6XCbQYbw5Btp
	rHhGgaKSYloEMdNJX0XHZRhZkvMMN5Occ2qyIrxxXVvxiLXZ+EajZg2mGrWawk23cM3rm9
	+iQDgwyxfFaUGwpHRpYN2Eueeo1BLCUQ9H8i9RgKzPFdc6cA7ORjLndUQqHzNfL80hhsdg
	jfVaHLPzHloKqIT2M7KJYXz/F1I2mmF376qZOHPHu7UCISyW2biXG04SixzhfJfjS2Vy9w
	DLagV9+UewBfLaPTIISqoUnfw12k3jdgUrlDCzQ9eSiAd4ApLb4sWVs8Qrm3aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758009002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N9o69Tti/DNiPVIhTDuPeiwB+qxp82w1yD/HVfGRGdE=;
	b=/LJ7us7eP8S1WUmb81fHzg1zGji8xHt7556ullFzXi89Vj4RJ3hNyUbznt375jPITtQMO9
	L0KKEiFMCDy1iOAg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Daniel Wagner <dwagner@suse.de>, Leon Woestenberg <leon@sidebranch.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
	Luis Goncalves <lgoncalv@redhat.com>,
	John McCalpin <mccalpin@tacc.utexas.edu>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, agner@agner.org
Subject: Re: Unexplained variance in run-time of trivial program
Message-ID: <aMkWqQyHIzg4kjk_@lx-t490>
References: <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
 <ddb85a49-934b-4c11-ac2a-c8a562e76e7e@free.fr>
 <CAMjhiJjMOQN-nWd+KP4JBBNHf20M+J2fXAuTTvowXctJgvGOcQ@mail.gmail.com>
 <41b7c365-62c2-4bfa-acd7-db73dc9f94f0@free.fr>
 <c462578d-4010-4063-9f01-54008ac91f95@flourine.local>
 <60e4eb3c-3dfc-4212-bdcc-229a5b67b975@free.fr>
 <913e8f73-d10f-47c9-b608-f8f9cb9eef1c@free.fr>
 <1b76251b-6f57-4d72-bc48-b8df6ac077b2@flourine.local>
 <10a88382-dc37-4912-86b5-fe6bf98e5491@free.fr>
 <491b2ee8-1c25-486c-acb5-0d68454a5769@free.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491b2ee8-1c25-486c-acb5-0d68454a5769@free.fr>

On Mon, 15 Sep 2025, Marc Gonzalez wrote:
>
> These types of events happen when different cores share memory (true
> sharing or false sharing). Since my code is purely single-threaded, it
> must be false sharing.
>

I don't know if you're just having "fun" with the CPU or optimizing a
real-world use-case...

With that in mind, maybe the following helps: understand the topology of
your x86 CPU and turn off the cores that might be causing a "noisy
neighbor" problem.

If you were able to root it down, and your CPU supports class of service
resource monitoring and allocation, then check
Documentation/filesystems/resctrl.rst.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
