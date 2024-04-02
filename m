Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EC5822A
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053507; cv=none; b=Bwur/BwP6z8q4Ws2K/BoK5YY8ypZeBxXsNut5vb5tSunkPYW14oDXss0ozq5416BUIMpWqdZyVPQK1L9lzbCcM1YzxsfVUec0rt2NxePbBl4VSKYS/1xFRiQLwPvielARjKB+yMsrbFgkHWO07su6DubJlupKbCrVLmoaK7ovqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053507; c=relaxed/simple;
	bh=TtIpJ2AIa7VlZ3JOs/8m+tY3NM9WNp0OE0c7DybqTY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WGnm2tFb6RPXBLscZUkuPlKejpKSKsn+XukhxNx05YuMPOHKoYu0yrQy3AbhXcjWAN7NJ7rB6qLpRRqIhSc16OOPz7mmQYzPiQcC6d59TxntmUvfkCQBY0mZ2CBqlVcG/cT9e1RE59rvueM2XlpG13dqCMaSZzDzMdJKfx/XvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4TcGoAK3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sA4CKIqo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4TcGoAK3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sA4CKIqo"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712053503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtIpJ2AIa7VlZ3JOs/8m+tY3NM9WNp0OE0c7DybqTY0=;
	b=4TcGoAK3Co7EeT3XK1CgoArA0OljD3cjnATVnc37kBi8BZqrqNSSTpSZBtw4jt+93XL4JB
	vbirI/hjg1gcFa7DWsOc6faUMioja4iIXWecTTtQOdgs7awSH+hfZt2KrWuQTBu9RiiLy0
	IsmZ/jnbSMK2KaxKOwlZA/Ushfaq7prQxHTNsQV0I5zJtybyjSaI0Gyrpf2kSnDwklNmLf
	u9RyHdIZ4aoM2sc52TgvgXVEKrcYD2Mj0dliE2RcbkFa/Mm5uzkOaseTTerra/Gxlx84tM
	vFKTGauR/05VSkDp5MabsMnktF77UhCbrCXXTy9Wb7pCTDCqTkNKVKvdCltawg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712053503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtIpJ2AIa7VlZ3JOs/8m+tY3NM9WNp0OE0c7DybqTY0=;
	b=sA4CKIqoEy3QBrDa43QIsZDKfOn68KLw/9BPxZ+jy4pW46aHow4W71Hm7+LCEdwMtMuFXX
	dRK/58vQiFlYg7Dg==
To: Esben Haabendal <esben@geanix.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-rt-users@vger.kernel.org
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 1/2] printk: export pr_flush()
In-Reply-To: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
References: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
Date: Tue, 02 Apr 2024 12:31:01 +0206
Message-ID: <874jckqcxu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-02, Esben Haabendal <esben@geanix.com> wrote:
> Outside prinkt users might wan't assure whatever printed has reached
> its destination before continuing. E.g. during the shutdown-procedure,
> where printk-buffers aren't emptied before the system goes down.

This is a reposting of:

https://lore.kernel.org/lkml/20231030092432.3434623-1-martin@geanix.com

As I wrote in that thread:

printk() tries to print directly from the calling context. Are you
experiencing problems where you do not see the restarting message?

(If your answer is "yes", please explain the scenario and provide
information about the console driver you are using.)

I assume you have tried the latest RT development version.

John Ogness
