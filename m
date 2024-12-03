Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB021E230F;
	Tue,  3 Dec 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222177; cv=none; b=ZPhpHs/1whFLyZeRn4JZdRqJI7w+1DBH6ExJqHtwvN+aqw1WNtRJ4SHaTGdUamNyhpXZeha0U0Pu7aho/eXXhbWNR9oQp9e1CKn5oGVNJI0BlIMExMw8EkqHBzoEB98OQAFeArq3YQs2C0VKInQS3+5IPa+ip/AJkNJp7PhLMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222177; c=relaxed/simple;
	bh=H+/3cy0PhfbnjiVQnlXwazoQHdDVcgjWaiCqgDjKm4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db7oS/2FBCY10Olvv3tg3zgYPiWCKRR6u7TQXHyIt+srcdz3ISFl0pxkQUaYOcrOBXhm5pKuo+XBA2Fm4bZEwb9mq9iydHzBg6iFuwonqhWjhtgJkxOaehIVKMi8WNJaVDlAaZa6SeYrpeZVV+uFcYpcB1hcSo82sUGbmdUig44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P4REuu0m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qp+PITBA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P4REuu0m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qp+PITBA"
Date: Tue, 3 Dec 2024 11:36:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733222173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=THAUZHSmjislIATKXLO6V2BOkSbq6u6+YWZ5htNaO8k=;
	b=P4REuu0mKtnPz33L9zY8f7ENNdLIp7fGKVMYcEsG7h8WjHwpXI+Q6dG3bvPZVEtjJtRQ6x
	bFnIlbA5HC5R1FyfgSGonGs+WBIBaz+9Ruk5p8rnphAl4YhSgVo9m0VymTRN7z0JMmCvu9
	EjJTLl54S6rQ+F+2EA3xyS2O6pOMr9RN19Kvb6uhVq/0HJoKE61I/8D2N8g2oj3A+oaalH
	83TtaGeWxcXXZLJbnm91uX4Mq/ide+jl8vlqHYGSX3E3XqEthAoschtS7X7E4eb3bN0fR3
	xbRwd65llDa5n24doK+3ehKqog7RfOBZD0F4AFDcQ5IssV61GZOQN/Ztkpyb3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733222173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=THAUZHSmjislIATKXLO6V2BOkSbq6u6+YWZ5htNaO8k=;
	b=qp+PITBAWH5iqrLQlZvG/RU77p48qQQljEQKIXUHI6pVOD5Ahs/0yWXNatSlXQ2zflNHsv
	XiAqqo0TxVMZL7Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: ende.tan@starfivetech.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, leyfoon.tan@starfivetech.com,
	endeneer@gmail.com
Subject: Re: [RT,1/1] tty/serial/sifive: Make the locking RT aware
Message-ID: <20241203103611._nfkyEXJ@linutronix.de>
References: <20241203094009.67697-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203094009.67697-1-ende.tan@starfivetech.com>

On 2024-12-03 17:40:09 [+0800], ende.tan@starfivetech.com wrote:
> From: Tan En De <ende.tan@starfivetech.com>
> 
> The lock is a sleeping lock and local_irq_save() is not the optimsation
> we are looking for. Redo it to make it work on -RT and non-RT.

You need to state which kernel this needs to be applied to.
The change you looking for is
	32c694ec3efc2 ("serial: sifive: Use uart_prepare_sysrq_char() to handle sysrq.")

> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> Signed-off-by: Tan Ley Foon <leyfoon.tan@starfivetech.com>

Sebastian
