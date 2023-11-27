Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dctH7EH8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE8B137
	for <linux-rt-users@vger.kernel.org>; Sun, 26 Nov 2023 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701071576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNsULkBTyJ5WinZhzsvOg91hI5wE43lISu6l1s3upf0=;
	b=dctH7EH8xo9phMgbQ/3/4K41lsTw/r1QrTip6Ti7WJyMbPkt4JNWO1noAHUZPytK91QNvq
	GS5Nq+QZs1TI2xI2P8WMeCAvXbrNLtM8QBkBwE5+PoI8Ken21s/kpY2zlWtrY+WOK/NOsW
	8qRGqHQRP/dhLUG7eufFzl5zSSll+dw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-J6cxwcNCN7We392zLASUgw-1; Mon, 27 Nov 2023 02:52:54 -0500
X-MC-Unique: J6cxwcNCN7We392zLASUgw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a01a0032b19so269586966b.2
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Nov 2023 23:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701071573; x=1701676373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNsULkBTyJ5WinZhzsvOg91hI5wE43lISu6l1s3upf0=;
        b=mK5uRY8APse561euCd3oTmmiWxs2iDp94E99uGYGiVnzpQYh6Vdht1CFBQWsedyhCL
         izM61Srd1qR/Im7rfj80povLyM4Y2rQviHiZd6fJN0ircdb3SkGltStQhqvEZoP+uYaU
         75VjnkzQFh5UU8ZuqgNjnxJyJpY88mXVCxLJ5UhIlHCFx8O2B9A92G0Uxg8eis5xmfiH
         0Kuuw4yvKaJ1tZUp//FPx9QOn8aiuKxlZohaJuD1p3+u/zd+q3VwIViRG7fTPz8yo5s9
         8Yjqj0O9cOndUhdIP6s5Roz9sjR4zJLIFxpT0KVYAn1vzWYiJOYDm74X1C5xU6duzr4W
         pJRw==
X-Gm-Message-State: AOJu0Ywl/J12iFGidmDk3LR08gxaS5zqgJqevWSNvafURW/GnVL1kJGD
	L+hXRZBIL9PkQ2SGNxGMGZJ+3pSg1xoQUym92gM3zT2UaVo6/t5pIR/1YTG1dfZvN009n0ytXZ9
	4/yZV7OlG2T/Jx8wfat7Y6VXJsCGzwFPs53ufMx1Ujnw=
X-Received: by 2002:a17:906:209c:b0:a0c:46b4:a705 with SMTP id 28-20020a170906209c00b00a0c46b4a705mr4608331ejq.56.1701071573721;
        Sun, 26 Nov 2023 23:52:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbWxAIIldDqCjuZCvMMsI0xWfikTeVIDOaUdn+6EA1mlwPrCnycvHKJrsdB0RKtNQzJjUmMxBG9pCv6cb225E=
X-Received: by 2002:a17:906:209c:b0:a0c:46b4:a705 with SMTP id
 28-20020a170906209c00b00a0c46b4a705mr4608322ejq.56.1701071573484; Sun, 26 Nov
 2023 23:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123072436.270267-1-tglozar@redhat.com> <20231123072436.270267-3-tglozar@redhat.com>
 <7b393164-b0fa-5c2f-45f9-6289ad8813fc@redhat.com> <CAP4=nvQ3cQU+8XwxsHkNckj87EpkyrJeNPA+T71-XqswNJaRuQ@mail.gmail.com>
 <b0becd53-9629-51de-4f88-776d2b59f4f5@redhat.com> <CAP4=nvTpOYvLoDMFpDcxHuFTMcyr5tdmuPM0W0pvZxrXkOHVPQ@mail.gmail.com>
 <7f7f3c57-8c38-6b89-8988-071e3d16a1ee@redhat.com>
In-Reply-To: <7f7f3c57-8c38-6b89-8988-071e3d16a1ee@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 27 Nov 2023 08:52:42 +0100
Message-ID: <CAP4=nvS3PtubfoOt1MKkZ-WGA_reczyEVZNT-arB0R56ufTY_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rteval: Minor improvements to CpuList class
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 24. 11. 2023 v 21:06 odes=C3=ADlatel John Kacur <jkacur@redhat.com>=
 napsal:
>
> Sure it will, because if a machine only has one CPU we assume that it is
> online. :)
>

You are right, I thought I had an error when I run rteval in QEMU with
only one CPU (which I set for testing some unrelated issue originally)
but looking at it now I cannot reproduce it, maybe I remember it
wrong.

Thanks for review.

Tomas

