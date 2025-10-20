Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73D274FC1
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Oct 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979274; cv=none; b=hvNZwNZIQtD4igbpkm+YIoPaymlI1PkU8khyO2j8oOb6YjbhsF9Vz6DlJUBdm8wNA3vTHSmKheYRZ1Hc9WDxa9REXz5bjaT5tLDSgKk9tPd0NPcGqIwTU85Zz2c1W8e7faOC6XCk3A+pVJbV6TMR2gDTLNLGU52jPqKY0U2cOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979274; c=relaxed/simple;
	bh=Jz0baFqFiWKIPqaBnzJKzJNcAiPJ7QZaRFJ74r3U+0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=de5dIUz9j3a1q5zHtHfuRjRash1rQ8NRsgeU5tn2VPS0pqIuAqOu+w0/2WRwTJgX4Mkz/u3YNHzmfpC7SuHDl9gWbRTbhfkQxyef0xjw5GIBoPSh7PSth4BE1TvpdNdiJNL31DX8rLL5ks6xqkk48NIfaG/BROlrqar1lF4WZSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMA+igBy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMA+igBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760979271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtNiq+0DMzS67x+Z2XhCdPdrIGRMKKCvNH4lfvpH2iY=;
	b=dMA+igByA9F5FAiGSQFitB6uJ24zP04CDHSzxiVfi80IoGnQ34fM7c5Gz0rrgcU29je7zj
	NeoL3gZILDNfCxgVY4yyhCKHti+fY0YKpvP0iO9lu+fz1GqSRmH6QQJo92rgF3/lbDkMzo
	3wj/xyVoK5y6tSkNYK8G60DMxn/WZ1A=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-qKsQh8-GM2etZYKNgL0clg-1; Mon, 20 Oct 2025 12:54:30 -0400
X-MC-Unique: qKsQh8-GM2etZYKNgL0clg-1
X-Mimecast-MFC-AGG-ID: qKsQh8-GM2etZYKNgL0clg_1760979269
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430e1a4a129so13631445ab.1
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Oct 2025 09:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979269; x=1761584069;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtNiq+0DMzS67x+Z2XhCdPdrIGRMKKCvNH4lfvpH2iY=;
        b=RRSV7xy/fEmzTsPU1KGa0mlLXXq85+MTppQPmREKp9j60GdsGx9oYnbEHtymk42Heu
         uWLYjU9h8SdLB+sykFgK0vhhZGIhX4/vJ14mAeUQiJEWEmqlLe/DtFkM4j2zchTeQJVe
         B60zmq/MCHN37Qy2SRiXq4J4OyU5+RB8//lvpF1VMp38jBIWUy5kzGSCVNBhUmPBEHPr
         yFfvPie7GonqZAkdAkyIBryzsUKIusti8ykLPnYgFaMRCBlyOQtFx3LCoeT0rT3XJcyl
         fl3Qwo4FxUzBj0Lxo1VoogpfGXffo9KaVz+qwGl0WaaZ5E4QUZly/7qBw1Q2Y2C0xe9k
         7i9A==
X-Gm-Message-State: AOJu0YwtgVPD7ahjedhwMLWPRC3PnI1NYV0C6PwC5GOnDM9F6YqQ14jF
	cPTay82oWBkVdWx0VODln0IdmR/dObbMVSRrmJ6Xv0NGPWag5Ztb2RbFWXvp0yQNxKmUsLxnkX1
	lIIwoQa323CV8iNMGGloWIVEIfxfmZ/zHsY0rOpfUz7oy4AqvSqtfIumHnJM+WFraQ3rM
X-Gm-Gg: ASbGncsDBYxsgT1VwhI4QsKv9iFzI4Lgte7UBhN2GxYWTsN9wsW4WSeX8N/LpABJNWw
	uhUzrfbSfsryImwWaMfPuadPM6y6+c+gkL6WdGN/K/gKv22/DcfwVt7EksIx3jdpTEZdr4pa96q
	yxsZK6TSQoFRjHU0+0vvxZToFcL9t/47MYCN71GjJbClup3NY8UFgqxsDSieDmRRHO36JQVjvbv
	C2oMtKQIJg6d+myg/YWxF5JkRkOhXv4GZRs5Q6xRg7pHG+hE4MSA94fIYKa9n/04WVncwVIhl0m
	WTj1bM1OKYf7m4XVv2tWcYl3mgYvn8GV7SYn6mtCGfolrtBWT8bHFqeSLaLEEa04nAV/L4dElMp
	k94PHlbMbFL5ifooXEhb9m2d9Kf/H
X-Received: by 2002:a05:6e02:3e06:b0:42f:94f5:4662 with SMTP id e9e14a558f8ab-430c527d356mr188331535ab.18.1760979269361;
        Mon, 20 Oct 2025 09:54:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwGBPqM2yOijQjzejYn+0KCUEhjkeo/BW/SlWtt8ghhCUOvowWM/xK9isgU44xdFvJgaxIwA==
X-Received: by 2002:a05:6e02:3e06:b0:42f:94f5:4662 with SMTP id e9e14a558f8ab-430c527d356mr188331175ab.18.1760979268953;
        Mon, 20 Oct 2025 09:54:28 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a976a58csm3076706173.47.2025.10.20.09.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:54:28 -0700 (PDT)
Message-ID: <8d049c27440410a0ac0922d5e48da7824af57db8.camel@redhat.com>
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
From: Crystal Wood <crwood@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>, Derek Barbosa
 <debarbos@redhat.com>
Cc: linux-rt-users@vger.kernel.org, wander@redhat.com
Date: Mon, 20 Oct 2025 11:54:28 -0500
In-Reply-To: <aPJBkImjwb_Ze6dX@lysander>
References: <20251002205515.1299816-1-debarbos@redhat.com>
	 <20251002205515.1299816-3-debarbos@redhat.com>
	 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
	 <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
	 <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
	 <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>
	 <aPJBkImjwb_Ze6dX@lysander>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 08:16 -0500, Clark Williams wrote:
> On Wed, Oct 08, 2025 at 02:41:11PM -0400, Derek Barbosa wrote:
> >=20
> > Of course, we could always go the direction of just dropping the functi=
onality
> > of parsing said "old" sched_debug files. Clark said that this may make =
some
> > people upset though :P
> >=20
>=20
> I agree that's the "easiest" path, but I think we may want to poll the
> community to see if there's someone running an application on a 3.x or
> earlier kernel and has a need for stalld.=20
>=20
> We can bump this around a bit and if no one raises their hand, we'll
> drop the old format.

s/3.x/pre-4.14/

But is the task format really the issue here?  This patch is addressing
issues with BPF and compiler flags.

-Crystal

