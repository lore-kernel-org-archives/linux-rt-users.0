Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D37FDDAB
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Oct 2024 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549711; cv=none; b=c27HsqFbtrB4SqF6JDw6mE443UVBl8FF//1p0mVuMB3JUT+wu180K8CPrrbdc9wqDV5g0ZlUgGRJ4zPH6310hjk3uYcTLU4H75BLgYNNA60i7dONWJC6f3tMqx9W0Zsrx1cCW82o9hz22Uwd5mnVdMTqJtwe1v+lWHu7QwrBBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549711; c=relaxed/simple;
	bh=nso0siATFBA5jSSdZrniItwQPBj2HsMADFAqAEYYkUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gw9tamvuIzVzwdfLYFb6iFVNvrefTe+4jEcYxHoOEuMQSPSLT/UmDBrMXN/sHm1jjSK9cd1NvMFfQyNGmewZeA3bEnyJbygUE0ZR5aX3zHVhC4uy4/STMGBEaL7htoZ1/l+5PHKT8nRldGAMvEPlirL17jTOw/h57C8H3n1n3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8pMuiAa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8pMuiAa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729549707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7xUpRwu0Kyy3Sve0V27TkSzMsaJbn6oJSQNx9UJeWE=;
	b=N8pMuiAaYLq0ujkvJlIUDXaauCrNkWRPI2HHrcLS7KAO5d699uvYa2xylXHvvgrF6hbwfY
	A35GAQibyZMwU5xLu1yn+vqt1eSKD+r9t6lSiJMGILps8/m7T1rfSFZMg+bMqVwy8fGuvE
	m1FftrHtbKdai936D/NQQeXQIhE/YDY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-0NpNog18PBeGOnkQbDa7sw-1; Mon, 21 Oct 2024 18:28:25 -0400
X-MC-Unique: 0NpNog18PBeGOnkQbDa7sw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4af408dcso2869187f8f.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Oct 2024 15:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549704; x=1730154504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7xUpRwu0Kyy3Sve0V27TkSzMsaJbn6oJSQNx9UJeWE=;
        b=G5Sz4Toc8vD2C1CEs4I1xMk5rS/yWcfxeVb5+6SDwb/mpCOXfvwG0jW4yXUrCym2H9
         +Hj6Ox9P+k/DRN/4oKsY+wuiQhZjvi0epxVPlesk+MjsxLKJ5GcX8GO6RmKZRWD14QSY
         kWx0ksWA5SAtWfw/uv8SG+Vkyz2UJEG2Zd4TfQxpzDR5h+cvF5cVO0Ob5Ez27/bCGU92
         XcSwYoMU0NYMop1283nSTE4OKQyAHHz9by9D7I1Kfu55bqmMLUWJPLx2UfoWHd0xGJG9
         PdncFjfH6qWuOYYupstO1aoQY9sUHHzuPDuKJ4CG0LwNLiO0w2f3/rpKvkVLMxte1WX6
         T2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWlNjlnD1ryoLAlJgi8ZRbvMen1Z7Z9fWYCygo9VjorF+oRBOBk9peNERd26blDb/qsW3jotk8XZbUm+nkV1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvOmjKj369CAJt/+cLgF5jUMKBa7cQasabTQNgxH9hcQiErtP
	PuHe894lbOsPGTyVfrIBhYcsxbVSPukmSp9rOVlHtMD07dY0tDmM6e4hRr2FWnnBrGyZqqHYg6v
	KAMFY/NKNF1RqXB+sTqdoN806/IWpcVbfgQV3gwYWbsAbPb/PvDEAMnegGz8y5Y5hTtxbGxxqyW
	KGi3mYcEfyxgilnSzABmC65SW3UETsGXjv81cZEe9Qx/1NZmw=
X-Received: by 2002:a5d:6506:0:b0:37c:ccad:733a with SMTP id ffacd0b85a97d-37eb48a9df9mr7615435f8f.59.1729549704429;
        Mon, 21 Oct 2024 15:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRKLX24+UFrV54HZoTLPYjmZfBfAe1JWM3dqWuZ9h6AkvCCIaPd0Usb36LLb6R/Dl9SGvnEXur0BHnnY19Sks=
X-Received: by 2002:a5d:6506:0:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-37eb48a9df9mr7615430f8f.59.1729549704126; Mon, 21 Oct 2024
 15:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ5WXV6umbL9XG9@debarbos-thinkpadt14sgen2i.remote.csb> <84msix5g5p.fsf@jogness.linutronix.de>
In-Reply-To: <84msix5g5p.fsf@jogness.linutronix.de>
From: Clark Williams <williams@redhat.com>
Date: Mon, 21 Oct 2024 22:28:13 +0000
Message-ID: <CAMLffL8nx9JxUO1TW1bnLXAh=u+QQ-BMtgsppMVhepGt3Bp8Qw@mail.gmail.com>
Subject: Re: [PATCH] v6.6-rt-stable: printk/nbcon: Fix Illegal RCU Usage
To: John Ogness <john.ogness@linutronix.de>
Cc: debarbos@redhat.com, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll queue this up for an upcoming v6.6-rt release

On Mon, Oct 21, 2024 at 8:56=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2024-10-21, Derek Barbosa <debarbos@redhat.com> wrote:
> > From 1188b21c357dcb750a6851d7e5fd2d1f70ca9690 Mon Sep 17 00:00:00 2001
> > From: Derek Barbosa <debarbos@redhat.com>
> > Date: Mon, 21 Oct 2024 11:30:30 -0400
> > Subject: [PATCH 1/1] [PATCH] printk: nbcon: Fix illegal RCU usage on th=
read
> >  wakeup
> >
> > In debug kernels, printk'ing during the SMP startup of a secondary CPU
> > results in a splat [0] on boot that details illegal RCU usage from
> > offline CPUs.
> >
> > This patch aligns rcuwait_has_sleeper() with what currently exists in
> > Torvalds' tree, at commit 76f258bf3f2aa, and will avoid the
> > aforementioned splat.
> >
> > Furthermore, this patch makes it so that we avoid the use of hacky
> > rcu_derefrencing through the waiter's task struct,and instead leverages
> > the correct RCU API with the rcuwait_active() function.
> >
> > [0] https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuai=
tuq77zc3tkkojvawcuvmml@thwg65fdb3vn/
> >
> > Signed-off-by: Derek Barbosa <debarbos@redhat.com>
>
> Thanks!
>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
>

