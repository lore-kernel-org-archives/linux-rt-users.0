Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07E134D9
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Nov 2023 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QytGcP1V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WymfWkbp"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C292811B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Nov 2023 02:20:45 -0800 (PST)
Date: Fri, 10 Nov 2023 11:20:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1699611643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BtSCWQMXCFyNCoKIe5O+0fmMDZuRW7t7nrO0GHmfYQk=;
	b=QytGcP1V9cvQZOqsWISBx+sdSR5z4nT2Neru5opopn0b8rIz1krLqFA2jVvnFHTsRDJ3bQ
	PLaFnZ8oJFt6hMydHWjGm1ckBXwI4EewtYbyWrEX6LnL3lY3oKsWjCRBPNRplVV7X4eC0p
	seehttxTgd4uxNXPceberOBZRC8nGrO/6/Jz/8TwFluw+DBruOClRFEswxMJg0XdARQtUG
	2FF0+b6jQJZoptWJbSh+lRe4e98F4YbpA+wAQ0Ygk/Qi2NmzDfQBGgAkJEwQqdjTTMbagD
	KZp1HpY4+eHJOJY7RBd5fXiGHSgTcA9N/xG7xQ4V4cB3T4rywD9r34w2GkYW+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1699611643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BtSCWQMXCFyNCoKIe5O+0fmMDZuRW7t7nrO0GHmfYQk=;
	b=WymfWkbpjbOQaK5KnWHoYFoleh8R6DAot3GDbLJxDkIGfYY78+AIUnmNJWhVrNWpu6TQVa
	Kq7ED37D8N8OQvDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Cc: RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rteval: Change the default kernel for kcompile to
 linux-6.6.1
Message-ID: <20231110102041.EN_qugjR@linutronix.de>
References: <20231109204554.98770-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109204554.98770-1-jkacur@redhat.com>

On 2023-11-09 15:45:54 [-0500], John Kacur wrote:
> diff --git a/Makefile b/Makefile
> index b73e8c13f3e5..14f74e087eff 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -18,7 +18,7 @@ PREFIX  :=      /usr
>  DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
>  LOADDIR	:=	loadsource
>  
> -KLOAD	:=	$(LOADDIR)/linux-6.1.8.tar.xz
> +KLOAD	:=	$(LOADDIR)/linux-6.6.1.tar.xz
>  BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
>  LOADS	:=	$(KLOAD) $(BLOAD)

Instead of doing this every now and then you could first limit it to one
place and then build the remaining version coding from that point.
Once that works, step two would be to grab the current version number
from
	https://www.kernel.org/finger_banner

\o/

Sebastian
