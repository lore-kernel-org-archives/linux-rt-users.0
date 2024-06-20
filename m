Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6323A1DC;
	Thu, 20 Jun 2024 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718867751; cv=none; b=TIFJhDykjmHEtB+Rib08gJlcYp2hNhpMr/N/qgZc9mqYfX0AzwtCDB36TW5MooOvtbuEwikdWb/BfXNGuFroZ5RyRFhJwuDIni/5bv1A8VmUYTYNYLwuchmyKw8Wraf7vrjfJp9H7F0fPSp64yxDBCAiuiNhl8g2o8/pMlC9dFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718867751; c=relaxed/simple;
	bh=lbn4FLGscr+fbiLXKXbMLAz3L2zlwKi+hKt1xVgfVl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agOaqgR+qOLQYuklE1i9J5dG7ZUxp70EUeHwK0CByFcGZmvwyNaVfgbpdfbp6g8h/bgSDoRzEiLaQQJ13T86OdoJZbF9zJdpIuFdeMBrxgIXVQMnrdOZjkueB8QX3Kn5vABMBK6P7xehO7u4a2IdQBeyeEnUXOQZMGyRon7ds14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zjZoTC9R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ye/Di+dO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zjZoTC9R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ye/Di+dO"
Date: Thu, 20 Jun 2024 09:15:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718867747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmeBc7OVFRer6XQQDdHsI8Kg31Jrgx9zmrQ46Ts7lgI=;
	b=zjZoTC9RSbXH9x7LkUMNiH7LAXoR1ybUH3pzvFg4J28G+sJFjST8tEMOv67jkNnljXytnM
	rnp6JqIwG6UafkMpIATvPU8UxW6kL3CKiHMpLSR3WuoNQJ6Zrn3sVc9+rvBHlNIBJ9m9v3
	egk5ZICOAz654m7ZbK9rC4IlZeA86uWZPun+5+CNvz50PmTIuqV+8uDtdJoT2833L0QI3c
	ZAMxsguaoMGv7tqesXdmhp4/tYr8Ppgk92nw7opbDLZIHmmrF1QexXv9ERPtvnyUIzzqpb
	9+HdmmuUFmYtXb41DLyjbq8pkgV+v1bCi4mVA52k/FbvlG6a4sKX2Mh0CqirPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718867747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmeBc7OVFRer6XQQDdHsI8Kg31Jrgx9zmrQ46Ts7lgI=;
	b=ye/Di+dOJ9F4Y69q6h99NiIDrOqoo29ZArR+AQFLkylnxzfI9nvvExojMvkJbfZl+YDHq7
	4Y8VLTn8+QlNW5Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, williams@redhat.com,
	jlelli@redhat.com, ahalaney@redhat.com, lgoncalv@redhat.com,
	jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck for
 78s
Message-ID: <20240620071545.Es9LoyJY@linutronix.de>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>

On 2024-06-18 13:37:42 [-0400], Derek Barbosa wrote:
> Hi,
Hi,

> We have a modicum of reasonable suspicion to believe that nbcon_reacquire, or
> some other nbcon mechanism *may* be causing such behavior.

Does this help?

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index bb9689f94d302..0813ce88a49c5 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1119,6 +1119,7 @@ static int nbcon_kthread_func(void *__console)
 		}
 
 		console_srcu_read_unlock(cookie);
+		cond_resched();
 
 	} while (backlog);
 

Sebastian
