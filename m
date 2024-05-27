Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76F3B295;
	Mon, 27 May 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801847; cv=none; b=RPdYofIvoeEKYLO76M/wNMZG/BAK8nt14lvrY/Qrb3bSPzC2xhW9DjhUlUAk/5RplOdVID7i7TxpYd6LMxOFbrnKIAMCId2Qn9E411olGXcgLz6HnegPVimswcwDQRvgus4ms8MArrwMYx8/W/fmCctcPPVeCIAZyCmfJFrV0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801847; c=relaxed/simple;
	bh=KN/Df7cVH1hfGLVbWzKUrHY38uo6ydApmWkCbVJqn+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb5D56dk2EBziCtjmbIqYaTuGwLgfJGs3bPbqcA7IBN/w4ubSJBbr34x8iVcQLu2Hm24gT5AQ2TEDYT0xyMoLmkVDn2FtqVKJNrrdUcnqGkYvRyDnyeQnXgHfOhi14Zp6eJoB1hbEFiBAXQV6P06n7ARU9R63TD/GbgsuUk8b3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cRCLwCR3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fp6PvISi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cRCLwCR3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fp6PvISi"
Date: Mon, 27 May 2024 11:24:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716801844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN/Df7cVH1hfGLVbWzKUrHY38uo6ydApmWkCbVJqn+c=;
	b=cRCLwCR3YCF/RSe4ks3cWTNQegoy6h7aU7wyx/vQvzm5wyAaD6L3KG0CNVSUZjQNSTfj9U
	1OJjMOc/SdM/sbewdoHJKwYFQ+G4UvXRVcpwgHFRXXWdVcjxbV+CB/OGgLaS53+9aqrRzH
	7rGFP0iUNEYNrYMCiKPo1EDDOpY79blVGHLdCpJEt1cgbY4407g6IRpt9N9XacpYeBQiAd
	8T3QAlchJnCAG6hwM5TTEc8ESUVdQ6c59niLM3AuQcn6mUR+XxjpuYjqZu6WFPLxK2TYTd
	PFs6Ok74N0VNlOGpc0N1BbBQ+rqe/cpa6POzeo4qR95jbUKboSvsAH3V3/qa1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716801845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN/Df7cVH1hfGLVbWzKUrHY38uo6ydApmWkCbVJqn+c=;
	b=fp6PvISiFRAUp9nnXxCWfy+JVAcGhIb+56FdPCV7TCeEYAJvzc8gsDwy+40Y55O1lnh60W
	PDpP3y6Id2lpo2BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: xu.xin16@zte.com.cn
Cc: john.ogness@linutronix.de, rostedt@goodmis.org, zhang.yunkai@zte.com.cn,
	yang.yang29@zte.com.cn, liu.chun2@zte.com.cn, si.hao@zte.com.cn,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH  5.10-rt] printk: ignore that console preempted by
 irq/softirq
Message-ID: <20240527092403.x2m7SpvL@linutronix.de>
References: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>

On 2024-05-23 23:55:37 [+0800], xu.xin16@zte.com.cn wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 7f27cfee283e..faab85dd4439 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3735,6 +3735,14 @@ bool pr_flush(int timeout_ms, bool reset_on_progre=
ss)
> diff =3D 0;
>=20
> for_each_console(con) {
> + /*
> + * When we're in the unpreemptible context on the same cpu
> + * with which the thread of console locates on, we should
> + * ignore this console, because it's a vain.
> + */
> + if (!preemptible() && con->thread &&
> + task_cpu(con->thread) =3D=3D smp_processor_id())
> + continue;
> if (!(con->flags & CON_ENABLED))
> continue;
> printk_seq =3D read_console_seq(con);

This does not apply.
There is `may_sleep' set earlier.

There is no console_lock() around for each=E2=80=A6

The other question is which kernel started enforcing might_sleep() for
pr_flush(). This should be applied to all kernel or none so we don't
have random behaviour across kernels (5.4 yes, 5.10 no, 5.15 yes).

This is a delay of max 1 sec during bug() and panic(). Not sure how
"critical" this is=E2=80=A6

Sebastian
