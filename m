Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E428060E
	for <linux-rt-users@vger.kernel.org>; Tue,  5 Mar 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626789; cv=none; b=kGuMpzuzcxTbwVL/D4hl2md3KxzrQ4MfhIZUWd7QpWS1iJ/BSYhFHSJ1YQrbn2yZQTpLv1rDTeDh6Z3UerX7qbRrUCAji6Inu1BpTpKOXxAQu27G0uKAF7Yv5UZjxH7HuusOepl6T3H1peTBjn5e8BbX0U8fSeo5IJ7ypK9J/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626789; c=relaxed/simple;
	bh=+xFAmHJYsSAwzh2sFhSClyH+E30uIC2XSlz2fiLr5HQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUv9SEJyiUg7trunAb8+IPvjbxH3+dQWarlWuE+X0gYDQ9K6+vEhnT9IRn87DhIUkvLOaGunNytFttHgmT9AMFyIMYjXi5oBjpbeOpDaJkK94ecR6gZc9mwWBQrFxQSMn4BA6PGQMauvlESPrk8vU0uggraeGN0RdSztnQsQpJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lajD8mQe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wwbQJnCC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lajD8mQe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwbQJnCC"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709626786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+xFAmHJYsSAwzh2sFhSClyH+E30uIC2XSlz2fiLr5HQ=;
	b=lajD8mQejPMZM3eIzewJuNgrJJrWjvhFDxKxbBg7ycgG7sKePD1/DUWcL4Dy/f74Tk/KqW
	Wj084z/cNr5bT4JeUYGiUNdqicw7k20Xj+4DfL30kj3q6xk2p6tAibk1mN59/IFG1gaYgF
	sh8qoJJPxHvezIzT7DvEqAXTENqcMchZH6/e7puX+pQcH5/hM9mZ9BbpUxPiuaLVFMIeW3
	roYruSPkkXPI3hyBTYrqNjWe8cwxgf7jW+S6wnlpILrVYD+AgrRy4q7TCBdg3gQwP/nfIA
	+PlWt+YVG+Mb88WQG6E9CZ7c83PI23v7vzVIq5mTCvTQW8CpVGgbyQiZ2BtLQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709626786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+xFAmHJYsSAwzh2sFhSClyH+E30uIC2XSlz2fiLr5HQ=;
	b=wwbQJnCC3PZacrbx+fcjxd/IDyUx+JDIwDgrGRC8YbuKitDafTi934nSUkopzW139wGlYL
	JIuUuCPN1+TY+FDA==
To: Sahil Chandna <quic_chandna@quicinc.com>,
 linux-rt-users@vger.kernel.org, quic_akdwived@quicinc.com, Pavan Kondeti
 <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH 0/1] Fix NULL ptr dereference in nbcon driver
In-Reply-To: <8fe5266e-b26e-4751-a6bf-0bb694a394d3@quicinc.com>
References: <20240222101626.1142-1-quic_chandna@quicinc.com>
 <874je04qqu.fsf@jogness.linutronix.de>
 <8fe5266e-b26e-4751-a6bf-0bb694a394d3@quicinc.com>
Date: Tue, 05 Mar 2024 09:25:10 +0106
Message-ID: <87le6x6qgx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Sahil,

On 2024-03-05, Sahil Chandna <quic_chandna@quicinc.com> wrote:
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/, I
> don't see this fix. Even on latest stable version for 6.6. kernel i.e.
> patch-6.6.20-rt25.patch.gz, this fix is not present.

It _is_ part of 6.6.20-rt25:

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/log/?h=v6.6-rt-rebase

02e87cb0499f ("printk: nbcon: move locked_port flag to struct uart_port")

John
