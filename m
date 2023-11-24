Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhOA4Oe1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2011733
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Nov 2023 08:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700844727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIfxIV6yx6QYW7rDq33ZP6L8mKDyWDUIapgcGRgvNeY=;
	b=MhOA4Oe1KmaGCcUNpLu75z/SkgdfSgz3dmb+gfta/icvXMtbXBJb+ehUCHGWlQ6FTgb4oZ
	uj+7aWn/w4icMxNpPC5W1mryH5A3fZu+ikjae01UxeLn9XVZ8lF7xO7zI2/64OGU3wqFsN
	9piW8Mx/080A4cyczMZ+J2LkeenLUYs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-gWQwZrIyORuypQQnoIGV-A-1; Fri, 24 Nov 2023 11:52:05 -0500
X-MC-Unique: gWQwZrIyORuypQQnoIGV-A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a02baf72f5dso149459366b.3
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Nov 2023 08:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700844724; x=1701449524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIfxIV6yx6QYW7rDq33ZP6L8mKDyWDUIapgcGRgvNeY=;
        b=OLEfsw0DJYRFlCSPCfTPrgqDWgGnEsPLc5dyKS4SCG4CnifoB3g1DxZ/1JgZsLEfn5
         15HrA8dqa6qHlkodq8NC9+ohKjdMC1iTBE2wIEbQT9IGwo4CVUhExr7UaYL0/Gl0cGxh
         YMRwufsaxC/5ry7vqtA8ICb5QOgyIafKc4IxLswSAT0X0WlO1K1mwNO6Liiy28mm64Vy
         XpOaVxtxCignDQ2DJaFOhF5c1xxlCSB2FD0gOxg8BX3b+yetWChcFq7TUXLqUbxZoEU0
         zS6j2VfGzDtGVUFKjWtr42u9X8u2Ae5PByDWzKKroja8Q9gU3kMb4nRZ5hT3MaJBew+j
         Q4ig==
X-Gm-Message-State: AOJu0YzwlVF98H1kPqiN5L5kmhpy9Wkat8FqEurpbLMnhdPsoU+UGI50
	/E0jieAD/tIzkoz4KFkFwEW5ZBFhOmgCy4K/7AKAaBoZ6DusiHYHH1pphd0/G6zwe7vUtboq07V
	L5cRpaTocfuGl5IdE8gUp2DwU+mAcUzxBhPV9PSEfe5Y=
X-Received: by 2002:a17:906:40d9:b0:a02:54fa:4f31 with SMTP id a25-20020a17090640d900b00a0254fa4f31mr2134987ejk.59.1700844724547;
        Fri, 24 Nov 2023 08:52:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiGyXRmJweqnhsbI8+ZCYZUDSN0FNDpE2O6fiYTOx+wroVyN+EBoB/VqdEBWjgd7FZtPmckgcKMQZyZ+7Cu88=
X-Received: by 2002:a17:906:40d9:b0:a02:54fa:4f31 with SMTP id
 a25-20020a17090640d900b00a0254fa4f31mr2134980ejk.59.1700844724189; Fri, 24
 Nov 2023 08:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123072436.270267-1-tglozar@redhat.com> <20231123072436.270267-3-tglozar@redhat.com>
 <7b393164-b0fa-5c2f-45f9-6289ad8813fc@redhat.com> <CAP4=nvQ3cQU+8XwxsHkNckj87EpkyrJeNPA+T71-XqswNJaRuQ@mail.gmail.com>
 <b0becd53-9629-51de-4f88-776d2b59f4f5@redhat.com>
In-Reply-To: <b0becd53-9629-51de-4f88-776d2b59f4f5@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 24 Nov 2023 17:51:53 +0100
Message-ID: <CAP4=nvTpOYvLoDMFpDcxHuFTMcyr5tdmuPM0W0pvZxrXkOHVPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rteval: Minor improvements to CpuList class
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 24. 11. 2023 v 16:27 odes=C3=ADlatel John Kacur <jkacur@redhat.com>=
 napsal:
> Or just check cpu1 like we already do!
>
> John

That won't work on machines that have only one CPU though.

