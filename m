Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FD207DEF;
	Thu,  5 Jun 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127904; cv=none; b=tfw28hfIJEyyvmq1DwKkpPy1rnroFxZi1hROpEHREyOUrNHl4QsqRTerKuMevD5sdIsSk4hgGi5ikbw+p5dO+CmmwuHa7I9R7ENGxM03Ums/xLMDHsldgtwzcAFuSFe62o7meVlagAYLZtYhzXXwcbvsNf4CyCyI3dG0AR4fQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127904; c=relaxed/simple;
	bh=ZUiM2pkU5guQg7oZO9uuxObekdLbXUp+WUeLWTU1E7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9TVxADbymZlfmOyEqD9EutXI36J1O+IhO/TCjbRDOpB7UNKxgR/LFX2RxD+hHYNeob4z1ypcadfqpcJuMyvlb0RivgcFbm1DzEU1v1XeDqjZ3G9va+TBcclPy+vd3MAIIU+8/4kgBOb3yo0MeKVw9l2yOpDIiDmAZKu4ZCVavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PTEuv5ns; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d21005hq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PTEuv5ns";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d21005hq"
Date: Thu, 5 Jun 2025 14:51:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749127894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCmTpUNfy7T8yo4V20ZVkio/sIqfW8HzcHKaNAgKW18=;
	b=PTEuv5nsUWLZys8DENTNcZsIyN49ik21podpmtqSK8k4vLEhhsb0AtWhmX4yt2+Ynaj2b8
	01TcBJRBi5D9Ts509oYUzjoxOpIgb/PrJ7y8JXAthT6iX/NFtB2NZMlNMeDQ+X29C2NcuZ
	BOwQI67Z9tnFort4BlmYDvimqUmXPAYxWCzpTXSxxDfJX9rwqEnY9tNU0PONpskTfSPeT2
	b+zwggzar2jk6is9mc2w5uh0ypUHS+JlgmK8oVahG2oPn3ksKScA969movFEjn1Qcdr+3J
	w4HEOaLfihb7xs8e30Pz8Hn0NTHJRX0Qa8ERtjo3k45YuSjO9Z5EpbhYXMj6Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749127894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCmTpUNfy7T8yo4V20ZVkio/sIqfW8HzcHKaNAgKW18=;
	b=d21005hqko/hOLnXpMvYTsZmSB9gvwFEMk/FtM89eSRJ4+wuVFPHJBmJcS7888+XJFVKKf
	U919T0WuRb6ygKDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-users@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
Message-ID: <20250605125133.RSTingmi@linutronix.de>
References: <20250605091904.5853-1-spasswolf@web.de>
 <20250605084816.3e5d1af1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605084816.3e5d1af1@gandalf.local.home>

On 2025-06-05 08:48:38 [-0400], Steven Rostedt wrote:
> On Thu,  5 Jun 2025 11:19:03 +0200
> Bert Karwatzki <spasswolf@web.de> wrote:
> 
> > This patch seems to create so much output that the orginal error message and
> > backtrace often get lost, so I needed several runs to get a meaningful message
> > when running
> 
> Are you familiar with preempt count tracing?

I have an initial set of patches to tackle this problem, I'm going to
send them after the merge window.

Sebastian
