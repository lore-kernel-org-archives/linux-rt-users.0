Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0A1E0B74
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Oct 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544183; cv=none; b=rdeFFaOb9xDo2RriVBw5T6V8aEPze6bveQqiFiTqB435iKjXAxFxwKJfp4JCjotvMQ98KBjtQDUV0BwsLGvPJcAFBwFAJ4ioUv30M/mMTFBM0e1N/8GJVYyeItcssr+34WduggNcAgACyF3/8uRezUbqlyZJdbRJ2lnQKp772SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544183; c=relaxed/simple;
	bh=5Efa6JPsgPAmLs9phPgQUzu9dFdIh0K8xBxCAjbxBY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YuYQyGtUrR2VIqXSq9TdALSNzDedjPLD26nx3oahshTVg5rRNfHJNB9+gvWXHnCUP5m7DATFzcqISlyApDya7fJt978aayGuC4tvuZLxDRGtzhSYgknJPWAJ/V3SSQhwY9v3D3tcc5aLvhT11UVZwQG9ZdXrmIH94lh9KFE5S6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JxFjpNmf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jWekIhK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JxFjpNmf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jWekIhK"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729544179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYVhaPxM510U0zYvoJtG3TSO0Ajm2Y0B1WvIHsfGUVE=;
	b=JxFjpNmfZnzqPud2EEdGxssdSQieebV0vZ5Z46K9aoxvTEUHsNVl1xN5yUKuRire/ClnRa
	MM/XHyGs166YmYfsuoYJ7SqHueqNUBfVGM09UxJK4ZJD2uwJglFDr9b6RaW0XUGWHrzd8m
	aVIIs41z0mM4Tg1pgFbfkRgVxCS3gdM7eY8Sd26ioaT1gr/UXmvpmP2qXND1dmlSv5WB4p
	QILUzfkGzbmXkZ37MwfWWBzUYEwQWQEmg2ZoOu50UHOwOjDx6YDlJTwsHZ6HSDJVw6UwXQ
	3I982UlvUVv51lc9B7Ozup1miQ8knHehN8OkzKL4uSuKQHDI3Deb8xHFBwaA+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729544179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYVhaPxM510U0zYvoJtG3TSO0Ajm2Y0B1WvIHsfGUVE=;
	b=0jWekIhKMbb5HF6exMOtepXI0UE1+bnVgTXKa3YOPdKyYQOMZtKIKeAGhpohvl2BZpecUk
	dC5yRWosWwLwSQDw==
To: debarbos@redhat.com, williams@redhat.com
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] v6.6-rt-stable: printk/nbcon: Fix Illegal RCU Usage
In-Reply-To: <ZxZ5WXV6umbL9XG9@debarbos-thinkpadt14sgen2i.remote.csb>
References: <ZxZ5WXV6umbL9XG9@debarbos-thinkpadt14sgen2i.remote.csb>
Date: Mon, 21 Oct 2024 23:02:18 +0206
Message-ID: <84msix5g5p.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-21, Derek Barbosa <debarbos@redhat.com> wrote:
> From 1188b21c357dcb750a6851d7e5fd2d1f70ca9690 Mon Sep 17 00:00:00 2001
> From: Derek Barbosa <debarbos@redhat.com>
> Date: Mon, 21 Oct 2024 11:30:30 -0400
> Subject: [PATCH 1/1] [PATCH] printk: nbcon: Fix illegal RCU usage on thread
>  wakeup
>
> In debug kernels, printk'ing during the SMP startup of a secondary CPU
> results in a splat [0] on boot that details illegal RCU usage from
> offline CPUs.
>
> This patch aligns rcuwait_has_sleeper() with what currently exists in
> Torvalds' tree, at commit 76f258bf3f2aa, and will avoid the
> aforementioned splat.
>
> Furthermore, this patch makes it so that we avoid the use of hacky
> rcu_derefrencing through the waiter's task struct,and instead leverages
> the correct RCU API with the rcuwait_active() function.
>
> [0] https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn/
>
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>

Thanks!

Reviewed-by: John Ogness <john.ogness@linutronix.de>
