Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194608;
	b=QSe3iKIxY3AcO6s5mEiIzvzJrBwZ0E1hVLbiH6f7Xs7zmwW50DCrOxq4hYa2pzbnTEW6
	 U0NwkNWARw0M7u6q6TJ/z2g91t7LY1CZgJLzKklaHvw9+reOz/DrjuRkXH0c2UuPVsejl
	 BhZOIRnQdyHBr1oie8avGZTNyA58hbw5hrIj2hMTv+Dat8yeSpPXkByNVRfjeX+004VC4
	 Iv1xjM06XthSF7di9Pt58kclJdHIDfOO4gElR4qRCszdjajbqspwvA5/ztO7OZanxjkkm
	 OEQvIRM5zY4ZSqXKojuT8L8az0Rp7RhqTTtW87OOiSejbpZ0wCW0NyJudguMlMEdb2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194608;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=J6EcKPCt+KfAzvCKSl56m3Ot7NS7Ub9tU52adEj4q9U=;
	b=cvIWRkc3s6i5ZYjftl/E89skXSbMJlVL+Egl9hhvToYbCANRSXT/vzNbEZWEofO6FQJq
	 6VNBdiGqZ64+3+NH67IczD3IHj5s+rOmALcNgeKxpNuhqdyh9fP6Q01z6RhJLT7MLyKjV
	 8A8EdWVbmLjCtQOLTUQW6Py+SKTptxMmwunoC9drzgdQ1HNghvmMtn1PoEBhMZQu1ZvCW
	 YVfNtVMoIphnTjSnVwB+rNz+DZASdX4jzuxCr3Cl7AYwfTE/c9lw6q32T9qrIrzaMzrdb
	 /i1c42HQS80vwOffBKsTwRV5YH3cdprMLGV+hwCQvDlui/anXDjT6jan8vv85jn5q+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Jr/xybZ7";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=r9LlN0Uo;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3A606A336
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 17:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0F3A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jr/xybZ7;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=r9LlN0Uo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795194606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6EcKPCt+KfAzvCKSl56m3Ot7NS7Ub9tU52adEj4q9U=;
	b=Jr/xybZ7xq72VXbfolJrdfMuqnmYmP6RR2BbuvbrMI4w1pVsjm+fE0fwHNNkveDbRlOlg+
	yK4gjJXwa48v4xkwwNQRRWo4QxEshq3kszg0ex0VAI4yhhD+Z96AJbsmSlnvfjMtTInW8V
	+hZlD6XF76Lkvp3pJ2Tm6HZ/kcvrBx8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-KlwdQkfqP2SkO98HmYwWpw-1; Fri, 20 Nov 2026 17:10:02 +0000
X-MC-Unique: KlwdQkfqP2SkO98HmYwWpw-1
X-Mimecast-MFC-AGG-ID: KlwdQkfqP2SkO98HmYwWpw_1795194601
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so667316f8f.1
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795194601; x=1795799401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J6EcKPCt+KfAzvCKSl56m3Ot7NS7Ub9tU52adEj4q9U=;
        b=r9LlN0UoZvF9GDkpYCcqm6LjKUkYUPlIUhYbV+2nG23t13IitrM77sx9dR2h2ecVz+
         abNFMQY5z0ZWDmErm6eL2+in1XEOkKO0FD4aYLkemOPz01k0PlYEIcSVGh7syv73ecGc
         eoEVuYyHoOQAlBs5kajQeh9v3tGqnnyIr30p7h7H0hsqJ/cuh43bal8Xn5tviFjOjMtb
         W46DFR4ER8AsRUDkYOUqHXEpiiv8bwRPzs+NxeQJG2Icb5Blb6xFUWs0s6MAJ1M1htZL
         ABd28WOx+pTw4CL3/d6mNO9aTVj84dxenvj4CDZIUTu79di1S02UxbDs3aCxh1PFbCYZ
         1/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194601; x=1795799401;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J6EcKPCt+KfAzvCKSl56m3Ot7NS7Ub9tU52adEj4q9U=;
        b=IPPzDejxfMSUr+ZSYdgId4oLgBxPt0VNxRMILMtd1d/5goup18uyw/Gt6w9lu//lmc
         RzvBdioW9EneiRyDMiAXknclS1zp5JgHB9W358N/Jg+rQPHr/1JkjANFiWPrgnBSqHA0
         6m4FIfsltyROR/5J5DWbZNMm2iAsJmKLvRG6/H03y2PafP5pfMllE5DexTNGaP/X5tWV
         lGs/jpiq54e1VPCT+Q4FvE3pbuDKfDEZjigUkJY6u5mDy55wblklUBGr8+RNhtl0UxUI
         ntaLssOKWdV0BZd5RTFyB4Y4sjTitdY5YQxMwSs6DCJDwHVRdoJp3uMprrSbY/uE9h76
         MTug==
X-Forwarded-Encrypted: i=1; AL+hErFa5sQEhjtPI7Ku6849hSKperj9XLBaCnqd3mN6gpPYMbZhhA6ga5mCKMQ6eZs2VAECA6AKR4jmuKJLHnfa0w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+eIBK49lPpTYxT6VpaBz6DcSGX3dQz38E5hWVcswqLFj+bst+D
	Ztt1SedMK20bMjRclcoHAqY2xoOrnKSF/EBzS2puh9nZ3OH1QO3gL23+7Yc02qNNtP9sO/cuDRr
	/8fCf4t2NaxUh7ew++ocqgJ9zwxZrqfnrAlkuhKcoJxthq15JPVXoqH7DqxFiWghv2ZH0RGHtBN
	rw
X-Gm-Gg: AZFdTZfn3souPuRBCtltmM6klSZ3Z9PxxzahzjAMuOOs/IzeOJzqwjfhFti58wkrdS5
	ML12I8ZVhCxRuyuAzSyVTzGMgoV5eSC9ELI8P57PSQzuPclfHvuCyYdiH64PgPU0aS0uz22TjhI
	9NV6PQT+9Ifv8KUSAuipVaEGfjMAPAYAr+srA5guCXyb7gM2m4pxOoLygl2onmAxY82Rfsx7ptF
	xSGzQznHPtmVzc4kSZqQcqTv9nBow15diyoFhBAwUqSn9aCEQzsD18Idz8IVvW+o6Xw8qAc3k4z
	zQsnaFKsW4pcH8PLjwTg/cdapcQCR7MenefYACDuQGYDkutms9mCXfr0X1lO7oHU3G5/agfVWsN
	x3Kf5xXQtBTGkKuqwacBcB6SJoNAa3lHP/L+TDwFLX5zWEombyECQpbdUHYLawlSAeNlkxIzgB2
	d/FtE=
X-Received: by 2002:adf:e010:0:10b0:4a7:518f:bea6 with SMTP id ffacd0b85a97d-4abb3a4d2b1mr5619850f8f.28.1795194601124;
        Fri, 20 Nov 2026 09:10:01 -0800 (PST)
X-Received: by 2002:adf:e010:0:10b0:4a7:518f:bea6 with SMTP id ffacd0b85a97d-4abb3a4d2b1mr5619795f8f.28.1795194600653;
        Fri, 20 Nov 2026 09:10:00 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm6652201f8f.28.2026.11.20.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:10:00 -0800 (PST)
Date: Fri, 20 Nov 2026 18:09:58 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Florent Carli <fcarli@gmail.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-rt-users@vger.kernel.org
Subject: Re: [REGRESSION] 6.12.y, 6.18.y: fair server runs SCHED_OTHER ahead
 of SCHED_FIFO on an idle CPU (fixed in 6.19)
Message-ID: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
References: <CAJuRqcD2=42CTQk2PSHofSmt+=H=qKT-x-ZXD76TwVshaepBAw@mail.gmail.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuRqcD2=42CTQk2PSHofSmt+=H=qKT-x-ZXD76TwVshaepBAw@mail.gmail.com>

Hello,

On 20/11/26 16:09, Florent Carli wrote:

...

> On 6.12.y and 6.18.y, I see it run SCHED_OTHER tasks ahead of RT tasks
> on a CPU where nothing starves.

...

> The fix went into 6.19:
> 
>   e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
>   f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
>   1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
>   ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")
> 
> None of them carries a stable tag, and only 1e0a2ba7afb1 applies
> cleanly to 6.12.y or 6.18.y.

Thanks for the detailed report and the reproducer, much appreciated.

I had a look and I agree with your analysis. Comparing v6.19 with the
current stable heads (6.12.118 and 6.18.64), these four are the only
dl_server changes not yet in either branch. The other dl_server fixes
from that period (including 115135422562 "Fix 'stuck' dl_server" and
the two "revised wakeup rule" follow-ups) are already in stable.

On applying them: with git am (no -3) I get exactly what you report,
on both 6.18.15 and 6.18.64: only 1e0a2ba7afb1 applies on its own. The
rejects are context only, though (upstream refactors around the
sched_class callbacks that stable doesn't carry), and a 3-way merge
takes care of them. With git cherry-pick, applying them in order:

 - 6.18.y: all four apply cleanly, and the result matches upstream.

 - 6.12.y: e636ffb9e31b and f5a538c07df2 apply cleanly.
   ca1e8eede4fc only has a context conflict in dl_server_start() and
   1e0a2ba7afb1 needs a adaptation.

So I'm in favor of taking these for 6.18.y and 6.12.y. 6.18.y should
go first, so that 6.12.y never carries the fix without the newer
stable branch also having it.

For 6.18.y, since the commits cherry-pick cleanly, it might be enough
to ask the stable team to pick them by SHA.

For 6.12.y, could you then send your backport, rebased on the current
head? Please Cc Peter and Gabriele on both requests, since they authored
the commits and myself.

It would also help if you could rerun your numbers (latency and the
starvation check) on current 6.18.y (64), as 6.18.15 is quite a bit
older and a few dl_server fixes went in since. I tried to reproduce on a
local VM, but I think my system was too noisy to see what you reported.

Until then, setting fair_server runtime to 0 on the isolated CPUs is
a reasonable workaround. Just keep in mind that it removes starvation
protection for all fair tasks on those CPUs (kworkers included).

Thanks,
Juri

