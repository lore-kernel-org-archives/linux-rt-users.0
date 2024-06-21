Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C1625;
	Fri, 21 Jun 2024 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932614; cv=none; b=fdFwBLmQeZ4csdjxfEtZSeNistOeJY9t50bHOHLwhpBJWOjavmLGq+mOkC3lc10Hmd7mhsVpeivosTeLjynGHvKb6yhdrfbIgIToBqOE18DgeJK6sOrc9xp5EOh0HqMGA+069Bhh/jPFou1+iNA9WQ6SN7V3C3b9QZFjqbSdXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932614; c=relaxed/simple;
	bh=8GN5WL0Ghtkgnpnn93Cn849+5qJGtH1+zXTKACZsHZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H4N5tKbtKNTQfAMBlmwVqeTMXiyPfXkcXqRfYuPakedlrCw672zBXiLt5TU2RO8GyjElqTqkq/rNG8feTyI3fXz4BpJrKaHQXHHFEIRz7183PMZZ+Rtdx+G7mImAgKLvi/OUv1HS4dR88a7NqlfLKSDUG2+ZrUetxmjuWo1vuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H/qwa6jw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Al4QTOwA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H/qwa6jw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Al4QTOwA"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718932610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GN5WL0Ghtkgnpnn93Cn849+5qJGtH1+zXTKACZsHZQ=;
	b=H/qwa6jwQhGVIS3k9qUP54s+gWNLTYRkWXWco+WX4VM4e4rBjPuGT/GambK8BgBsTfd020
	b9reogKhVS/DfZi7nxZgzxI2cB1QymvA+rDH5uCopQtNekP3DBZo9gNK7oyqdJI9Feg+lG
	EYrIv1wxo9AfzQJHOzQ5cNZhOocWwRgFhnRv+P9AGYL/i0qtdPNMu/voOWzp1Tr5JZqjFZ
	UmXkQUodTRBc9chuntoYM66tAsqDKAR12uQepwXRalH3S9q8BmKd8ktF7hbBz4UYAB1LR2
	RDSWjUc+EYxipUV9jVeDFnqMPZ5S/7sY2GuqDQPO+bm1G4NN34VRnt16XfCzhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718932610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GN5WL0Ghtkgnpnn93Cn849+5qJGtH1+zXTKACZsHZQ=;
	b=Al4QTOwAfqOPJ42p5VOFBI9fzHnbjYsWyRbYodTJbsp4FtgF4TLfMDMFGUAqX8l8AQUHsO
	i2WRTlvP5/eDoICQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Derek Barbosa
 <debarbos@redhat.com>
Cc: pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com, ahalaney@redhat.com,
 lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [PATCH] prinkt/nbcon: Add a scheduling point to
 nbcon_kthread_func().
In-Reply-To: <20240620094300.YJlW043f@linutronix.de>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240620071545.Es9LoyJY@linutronix.de>
 <20240620093246.HE9XDWSZ@linutronix.de>
 <20240620094300.YJlW043f@linutronix.de>
Date: Fri, 21 Jun 2024 03:22:49 +0206
Message-ID: <874j9n5c3i.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-20, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> Constant printing can lead to a CPU hog in nbcon_kthread_func(). The
> context is preemptible but on !PREEMPT kernels there is no explicit
> preemption point which leads softlockup warnings.
>
> Add an explicit preemption point in nbcon_kthread_func().
>
> Reported-by: Derek Barbosa <debarbos@redhat.com>
> Link: https://lore.kernel.org/ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
