Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5929ACF7
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847633; cv=none; b=uM2ARi+T3uQd+1j2dYxpUrZ9OyCkfX8z0rn34wCkJbjgSOyZsxIJiqL6UxfW4SB+zs9WpWB+3BD8f85d1WcXkZg+3llO//B7SciGsCncQamCqCUmNEzptaCPaEgCMJ7Bs5YuzToAZLoXgxZ/He2MMpWl776Inw4PNBVxedYJG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847633; c=relaxed/simple;
	bh=FjfRMoDUgWs/GYwbAtOdjdRnLh8n0qCqUSazBpPeUjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1M7YPASse+entxceOvBuXdeRvxf7DNZnxaa4sRCH9hlWlUnbXfRt8TXpdHfEczdEiAR+2WrycbO+mw1X3nMEdHrudLHO02yborz+zAxGCXC+XSs7rvi+DF7VS/XOk/Qa3C6iQTnVJ21415js65Tjxo7q+JdCyC431FFZm5xWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsOySssB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=By99x93L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsOySssB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="By99x93L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762847630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKNn6Md5FvQ9CF9tzFeqMlp7GW7YGyeIJVczUyhW6SU=;
	b=JsOySssBD9oXSVM+plUWdOgJFcS0dmX7g6z6kfBeNlTA+YUOpI1y3t3zCZbjvIF+m55I/j
	Rl0VdUxydw5mhcQqI1azW2caFOfKf3y6CAyHk1wPQuwgJT5fXofDTU7/kbCqeSq3ngR5+C
	LRyefDBz1IrmJ/aMPp6hkjo1LvJWslo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-ZN5B0sW7MHSWj0nEiIQsUA-1; Tue, 11 Nov 2025 02:53:48 -0500
X-MC-Unique: ZN5B0sW7MHSWj0nEiIQsUA-1
X-Mimecast-MFC-AGG-ID: ZN5B0sW7MHSWj0nEiIQsUA_1762847628
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b6d35430f56so314126966b.0
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 23:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762847627; x=1763452427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKNn6Md5FvQ9CF9tzFeqMlp7GW7YGyeIJVczUyhW6SU=;
        b=By99x93LT+OETLO/nMwFmgEJzdYlwZ0OCzWZ8QyHrODe5/lxwTt3S0RKWePhb/Dqt1
         mENXHvK5A4buairdKjXp77nr7lIXyd3hCJKKGiWE5lCpfsrnE2AkJzHAlzm4aj2jY4PA
         539xasjtYWvDYs4vrSIZg1p/eJA1JaMrWHCnHZGd8SKU/RAewQXqw6Dn/MA2Xw1Ibgb/
         rWwXcbehmCOpadNnMsu35c79sCbaSGjgOZsJh2kCY/Ed5dZ41z/DofirvrYfqxBJvjnH
         0vjLSQ58ZHaPHbKs0foXQ+5Hphbd9XgDVdcBjZXbrbjWO2O3RGRdn0oYh+6zX5wh/gOC
         1oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762847627; x=1763452427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKNn6Md5FvQ9CF9tzFeqMlp7GW7YGyeIJVczUyhW6SU=;
        b=sZnDTOUN7njVjzJmwrbJpoy4ssHfdoy3sENhhf3SQZIK8b/7nmDCpN25cYxtTBzR27
         yN0tJNFdRVF925xP3TH2Z3UvXD/0i31b6dpmIAhiLp9C57YrNcUPimJj5joJySSqD+2l
         OxIwI0m6jkkeSfxgdy8pKCX7m1NESa5UBAjYdnunmcWmt7yGIuJ7EhqPoBNL2xP9Duxo
         BfaOsPcuV9tBi5263H6qq1KTqh+IERuxZYqo/WXKxs2qQZ6x7/9Li0HAoxRsD+fxmlP9
         x2h99cmh2b1KzUovr3n/6iMN+FtFS6773riiliRJyngnF5YqT35q8MHq92CYQ51Rn1Lf
         7ycg==
X-Forwarded-Encrypted: i=1; AJvYcCVzgGGLczeKzKyAclXF2bgPvZz78237gwhGP6zJCnhb21moOyCUmYwnCrgQZUixWtH7eKxdBabSZImOCuWYtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZpQfGS/88sjBh0s15Aicc1e9I5pSTSAXzG9bdtCZB/Ye8iiL
	+It3dsr2fEr7MOQOiBv7wzlxcJ98GZoMmHzeXoKjRvbn7cDInJZHchNvFTgOui2Bx4Nv7cKjehp
	Vlmc6YIOC4R6F2+nBNywL1M6Y/u2d/oKMBxZ8l/agfsufnUFa3DjJSL3EmqY/Yhy6dwj516YmFc
	G/JwWjHByP4aK3J1aY0SGVyxOQ+6r7izKOJKFQy0IFHPs=
X-Gm-Gg: ASbGnctt2y3DkzyPKlVeGJjrULCpn92UroYLDSWvxis+HMfWY/svbRO9ZSfF57Ja4W/
	f5ZTVBJr7MvL4JRf9yP5332IY8WuUl8FLRKpOs8711dXdGECKXVFxFJyjrH2I2CEs5xS9UEwJ6b
	jS/ZDrdfZT0WloptYuA0U8BFbpNR1F7ts35vJanms/DW3+sqEhUCPAdg==
X-Received: by 2002:a17:907:1b0b:b0:b72:dd55:3da1 with SMTP id a640c23a62f3a-b72e0547eb0mr1060583466b.65.1762847627542;
        Mon, 10 Nov 2025 23:53:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9Vd7Y7DN8pTqtKwWCPUmoj9zmBZIZzGB8TPl2YRHFb3G4xyBFN9u6BbwBAGmc8gc9CnfirEpouvBTs1xA59U=
X-Received: by 2002:a17:907:1b0b:b0:b72:dd55:3da1 with SMTP id
 a640c23a62f3a-b72e0547eb0mr1060581166b.65.1762847627145; Mon, 10 Nov 2025
 23:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107134749.257350-1-tglozar@redhat.com> <20251107134749.257350-3-tglozar@redhat.com>
 <a0569c19-f4e8-e818-4dd3-d955bc6c8db6@redhat.com>
In-Reply-To: <a0569c19-f4e8-e818-4dd3-d955bc6c8db6@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 11 Nov 2025 08:53:35 +0100
X-Gm-Features: AWmQ_blZFUk443FDIQbngB3iUNCJNvDuXQRfC9fZuDc5inUXPuz7g15lWrcl4fk
Message-ID: <CAP4=nvRfhGOtL-woMz6SEMvpTTfoe1iEkMSESiLzcajkkT_83A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rteval: Add README-tests
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 10. 11. 2025 v 20:13 odes=C3=ADlatel John Kacur <jkacur@redhat.com> naps=
al:
>     Signed-off-by: John Kacur <jkacur@redhat.com>

Note that the readme doesn't make sense without my previous commit,
since it includes instructions to run the unit tests from the new
directory. I guess we can resolve that offline, none of the patches
have been pushed yet.

Tomas

