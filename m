Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413717109F;
	Thu, 20 Jun 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875971; cv=none; b=qfMy8RYpayy2tNc0N44bx4q+naOSgFA9AnbbQ2fCUW+LQsP19n9RAVMj/ufFx1CMFLcUF8X6m8JU6+nIpkBWYTFWmV0x/vrE38VCbdL5O5UArBGeDxnf371NQ2ZhSM/vilf6QnGfkmWMfHNsO82cINmeJ6qKkjTTd5zFPl4RfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875971; c=relaxed/simple;
	bh=u6jfOiJoRXi8Yt+IZr/RX5Wh9PD4NKswuMEdG0Y2VA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJT77w1/R9gwSD2o9CG/5OnTJTwFXJkxoeZevScYlTaKgrUI97UXa93bPGZ3otbt4UeaRDhyJzIwxwnhw1I6+1+OT9p2AHu5oOCnwvf7ydbxh19VNgSQ/qqMT/TFRYMAzX8Ypixh7/0otPXTH+PHR4kL9AL9P9lHoI6StXDymQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQpXuen2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7MUQNnz+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQpXuen2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7MUQNnz+"
Date: Thu, 20 Jun 2024 11:32:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718875968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrkRjG59mwSd/P6A8Mp3VbPnMUiS0Se+Hyy+KUOHJMs=;
	b=GQpXuen28H3icBd5N/vrxH3rpXO6wT+XduoGsTLpIHOx7MzKiTUly5l5SKKB48YpO5D1g+
	MTsIRiSYuGFBdymmX3t+QXB76uAYNKbrxl4KpEN12fz3gX0twXclWcdW9tDZzoYVg8S4YS
	WPUVT6EPGxHpKNIfsJHbyoKgPgZZm/mesoT4zvfJ/A+HuZvZbJ9KSY0dqK18wmPdGt7CGG
	E5WeimOtWlXRee7iezJZc1c1dRbKGzf9T1LcNkDm4+6i5MepjNa4dVok6cWyubpGQIkZ5h
	xLcCv2Cjxf5tKml41cYzp0hlLbCBkh95u/QL4f6CZCJ1cYcxofxcWXpd1N0Z4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718875968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrkRjG59mwSd/P6A8Mp3VbPnMUiS0Se+Hyy+KUOHJMs=;
	b=7MUQNnz+hD/Xp8+ZtaymTkmHeqp7kwAy3Iw2z9jRBGnhs98vEZTr/jvb6cSlCbm16lgI5m
	tRNMN/pBpKjZBDBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, williams@redhat.com,
	jlelli@redhat.com, ahalaney@redhat.com, lgoncalv@redhat.com,
	jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck for
 78s
Message-ID: <20240620093246.HE9XDWSZ@linutronix.de>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240620071545.Es9LoyJY@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620071545.Es9LoyJY@linutronix.de>

On 2024-06-20 09:15:45 [+0200], To Derek Barbosa wrote:
> On 2024-06-18 13:37:42 [-0400], Derek Barbosa wrote:
> > Hi,
> Hi,
> 
> > We have a modicum of reasonable suspicion to believe that nbcon_reacquire, or
> > some other nbcon mechanism *may* be causing such behavior.
> 
> Does this help?
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index bb9689f94d302..0813ce88a49c5 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1119,6 +1119,7 @@ static int nbcon_kthread_func(void *__console)
>  		}
>  
>  		console_srcu_read_unlock(cookie);
> +		cond_resched();
>  
>  	} while (backlog);
>  

Okay. Works here on a 144 CPU box without CONFIG_PREEMPT.

Sebastian
