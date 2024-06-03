Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C33250EC;
	Mon,  3 Jun 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445499; cv=none; b=As9fuPxQmTjC3Ftjp7iuBycH5CwLTmjiNUDCSHbTyyYf7r83VIzUaSjv+egU+YdPcrEiIBEOH+AbBTfRbkXjsVXyS+DcLj4hbq/urd6RaWwtNvs0htRaNpOAG+Oa6VPLbdW1Wqe94aNBeS9faDM3QxxvLyX65IGUeOECyXzmBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445499; c=relaxed/simple;
	bh=efflADIZNzlpkBRyaW0qm7/xMHMy65QZOntk/PkZAjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d052PIO+1QhlrCoTxeNB3C5LsCJJkBXMn5Z+xSgpDnS2mQKptCUyXy5Kt/JJpbdzLY0OlsXDur84I3V11mxMApAfI6ru+htG1coEAmbf36huYcj6F3KE1XnZitCtC6FThkigUBsnGO13aTlBB0vSA6Tswp0+87MsPDC9tpXyidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DAVKUKIC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s7Acn0nK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAVKUKIC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s7Acn0nK"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717445496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8up0JG8Gg3x/DXNroh2NRpUxBKgV5IGxeM9N8TyMWU=;
	b=DAVKUKICNCB4UcTIeiQnqakm2LCAf9ePtoa94AdT3//OrxNn8qxPjNbSL72PoM3HfCbtZF
	7zeyWIrJjd4da6tRah35MY7DAPLqeIH2+a7MY5QOGz2a8XlUpkoGBX9Zhtote++SSAoHT/
	bJWdGc+lt1e+esHjVuZLHGtewHthqmgrejjuMtYF0lGoe+uhaZt0vDwEcfb1vIAJSa678u
	fa0wtiquHf0Rl4+CHTfw5YnpxrkV/v5o8JY7gIRSpXojILQabbJlvdLN0lzUzm6JzNordE
	8L8mXKX8PSQKHR013ZttDBslcq1hUFGN5duaHOLWb184ryk7FLOLyPhV+BC+aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717445496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8up0JG8Gg3x/DXNroh2NRpUxBKgV5IGxeM9N8TyMWU=;
	b=s7Acn0nKWp6E4PWzCfjQGhNvK+2UM0p192q2greVLp82dkmFFp37LnX7NZf79ZL+5dCL0i
	mCw14kUE2cL5OaAg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, xu xin
 <xu.xin.sc@gmail.com>
Cc: xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, liu.chun2@zte.com.cn, rostedt@goodmis.org,
 si.hao@zte.com.cn, yang.yang29@zte.com.cn, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH  5.10-rt] printk: ignore that console preempted by
 irq/softirq
In-Reply-To: <20240528152933.ns7uyFSD@linutronix.de>
References: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
 <20240528064003.776618-1-xu.xin16@zte.com.cn>
 <20240528152933.ns7uyFSD@linutronix.de>
Date: Mon, 03 Jun 2024 22:17:35 +0206
Message-ID: <87cyoxeqh4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-28, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> There is a `may_sleep` variable set earlier. Couldn't that be re-used?

Since the printing thread cannot preempt the softirq context and since
the printing threads are not started before @system_state is
SYSTEM_RUNNING, using @may_sleep is OK.

if (!may_sleep &&
    con->thread &&
    task_cpu(con->thread) == smp_processor_id()) {
	continue;
}

John Ogness
