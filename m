Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630FEEC5;
	Sun, 26 May 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716745886; cv=none; b=Zspg1qRARd5mDQxh1YfBdY7xKP8BzaqZAmHbJLsZKp2L6mPp1aZEbPqppdmshszEhSyBSifhZ/WfyHs2RLJdn5i/ltTUa+VDKvqSN0CDguCnl+Oh7XDlZ0jCPCN3Pvbc9O6JPNvCnj3TbCR80IT87EXZly/CQiUHca3qXwKb4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716745886; c=relaxed/simple;
	bh=fSmJATrahFNhZTbXeAPx7NpqgqqfQgR8k7RfvhRLMw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PquHuj2pHzaRIfhAbC8EjMGwo0VAmqSi/Zm7+H+XRwI2iVnSwAPAmZcES7AGJlrj6vlhHdIxF2R/2Kd0JjNrJ5CcGqfZgMHl8kfV6pYtbjFytEXsW04Jps3aXMw+taOh4oMFN5nHuQ72twAfr9D+lo1bMfg6OHWaB06FLsCD6nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RFxme2+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GmWeaa2m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RFxme2+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GmWeaa2m"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716745882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3r4vIslQHp+LF+Z5/5dj9t9dmVGSNrujiV846kaqNQ=;
	b=4RFxme2+BaLd+zvrZkqGVLGCJrK0b7cBBVCyH3npxqn7vJQ8tSJ3yv+56DiyzhN14ydffe
	l+AgPDJaXgHru1kT7zmxzEggvP1ZC7a2pw5UxaMZParV5QBCPTrpuZ391Tg5CHCtx2r90O
	7pMaoWFqAqrp/3kXK6o3Z505I72dy3/j5jwcQSfBTsNo624DGZS2xjy3EXQOReWa8XXQ0Q
	SlRIBb70dN/GvlleOSrKLbOVisOIrZL4sdlJ0CHFVO2YYB+wRauReRXhLCRtZ6b4WnOVnq
	qxXduwyT1Do5fApx4NtrmrEB1Orj635FDVAfaZKOjA936CQOnmg/fkR+R1vPfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716745882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3r4vIslQHp+LF+Z5/5dj9t9dmVGSNrujiV846kaqNQ=;
	b=GmWeaa2mRBegpptHMoZkyEQyzVGQry9rEpEuEpp76NYPn+JQqzuGF+gYJT7aP9//5Lrx1Q
	lIMMNtZKfoFn1oDA==
To: xu.xin16@zte.com.cn, bigeasy@linutronix.de, rostedt@goodmis.org
Cc: zhang.yunkai@zte.com.cn, yang.yang29@zte.com.cn, liu.chun2@zte.com.cn,
 si.hao@zte.com.cn, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, rostedt@goodmis.org
Subject: Re: =?utf-8?B?wqBbUEFUQ0jCoA==?= 5.15-rt] printk: ignore that
 console preempted by
 irq/softirq.
In-Reply-To: <20240523235401355RFqSAGtIPwMKV39mUulN1@zte.com.cn>
References: <20240523235401355RFqSAGtIPwMKV39mUulN1@zte.com.cn>
Date: Sun, 26 May 2024 19:56:57 +0206
Message-ID: <87r0doo41q.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-23, <xu.xin16@zte.com.cn> wrote:
> From: xu xin <xu.xin16@zte.com.cn>
>
> When we're in the unpreemptible context on the same cpu with which the
> thread of console locates on, we should ignore this console for
> pr_flush, because it's a vain and always lead to timeout  until the console
> thread get cpu resource.
>
> Fixes: e65be5f4dc3ed("printk: Update John Ogness' printk series")
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
