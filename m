Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE732E699
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Oct 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978902; cv=none; b=BP232nz/YWN2Lyw43Vy3Q0bSedn2izG2s0OgOXYl1V6AMumlDyCtOwpHrPMDImBv1ggItgw4COj3hL01mYKcEllWbNgnXtgw0bhKU7XPYNafeRtwtGgN9IaN+ZL8KB2xfNhY7cNadtAUCB1SS0i60JpE7KXOrPyr5ll6TsEvVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978902; c=relaxed/simple;
	bh=kK5e6X+yNV9kMI07srtB4TLiYnb4CXfG3Lw/gljMisw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/GpqAUdpxtqxY4AQQ9Ce3KF567UMxVXLlA1XPTPx61+HVp33990Q8buYHVaKw9KgcNWwlt6jm+E5hOvB5Rk7JIIaUWI900rfGIcBsSaIDyN9cdnZeo53q5qBwKBdiRs7zXr3tzDcepR/PlY2Y22Lom4xY8Gga+7IM6rzhBpZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqfFIOkF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqfFIOkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760978899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKX00ZcqitjGF24FjIrKvd4ZxRXevNwK7tBxWaWKSPQ=;
	b=TqfFIOkFqkCtsTeFt/lPtz6A/2mBSI5pXyffBcrxLfeYoRlMpUqD51l6IFEfnrCYnbhbP4
	0uhJycfYqEIJ6TLY21i5YmJveXx6jxgDo61UK/FQOlLTNsScxK1HMcu48voYqKA4cIp7K2
	APuQXjIZHtg0TnVd7dcQBUfZXp41nrI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-7qyneiPgOKaiR_V2we5fTg-1; Mon, 20 Oct 2025 12:48:18 -0400
X-MC-Unique: 7qyneiPgOKaiR_V2we5fTg-1
X-Mimecast-MFC-AGG-ID: 7qyneiPgOKaiR_V2we5fTg_1760978898
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430da49fcbbso19117335ab.3
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Oct 2025 09:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978898; x=1761583698;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKX00ZcqitjGF24FjIrKvd4ZxRXevNwK7tBxWaWKSPQ=;
        b=qKYMzkRuIUJeccIt/gpv/QGPmWryEzGzT2t7jTK55pCowX2w50xyP2nxBRNnGXl27y
         pK/ygKp1pg/al/QXaBqiaciIdyD0HHuK1skaZkn8zwv5r7qfE9fLZx16I6bIhGbENZaR
         LnJByXzZCv/DCsdPVzOK1fc1Hi1Ue51I9n68o6wzQy16Ut+4DfbjEWNcXRkLbnLU8x8W
         9oy6cNGDeV5WyOPzXNuRZ/EJ7Gt7l5jYUq8XHtVuSWWPn+4ZHq0lRGn+PMazt16fES9S
         K40eADA5TeoeN0//eqGMFSv3C1W5eKj0+6CBGGNJwePNOJxvrRnnGhWujeSMf+4nAHpa
         ixYg==
X-Forwarded-Encrypted: i=1; AJvYcCVtIzVJ6A4j0b2gY+nZvg1pDpjYkCPWKrwiKqq7I/CxxZWzjB2bBVKM92WiCUShLJJ28lFwYFXYpQKxZYIfDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kh8e8CRacKfEo5U9TMQkAbeT5NOXbdzyDeeX78BfkXDhK68N
	O5i5wBEbUAa9qVEH1NqDv1KbHVS2oQwKed0Gqa1P+YQ0yRLtupq88g193gex3SOkB7yg+KZ4Jcy
	0JhTyGzjcR+OcCX8e/R8iAP44J3KdTmNuGNcT/wKVLeXtb9Xg8XVKH/XJCR7I0QvafP8xf4nnsF
	Vy
X-Gm-Gg: ASbGncsrW+t9vLFVBDXpRhTLm+Xr6w9KGfBdThX5PU69pOSdmDmaiXNjxOIVtx4HY/+
	HwJKyb/f+6ytF0JRdkVVOAdFyBJM2rsKliWomJr2r45mrwywBWobKQs3WKronIotQLHYFIGBQEt
	zEACMq8RzV2v+aWpIM+vbVVpB2h1uYZZXR7ICbJmuFJ7lsuOaTeHLRHQVghmie05juso6NW2n5G
	9w9xrfv8PVQBoUCyo21lDB3YPXAsxZOxeNmzZsHG3LLKk1t1WCksRNXgarg1bBzZ8CdQG3zQcoS
	5ypxZavrmmXyU4vaNWGiV76xPdUaFgQ7PSnbNMdwcoWZVJJOjgEc0O/0Poje23WRhlVyEGFX6AX
	hn6SDYNOaCKo90rvOlRGrroI/z1A4
X-Received: by 2002:a05:6e02:2307:b0:42f:a60a:8538 with SMTP id e9e14a558f8ab-430c52b5afemr166066835ab.16.1760978897519;
        Mon, 20 Oct 2025 09:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuUlrrK/5aAbPSk1loC+r6sCVcJ+i4goM7bShWBDu7xr8KsYEry88fgpEoO4J9UFd7/zWJYQ==
X-Received: by 2002:a05:6e02:2307:b0:42f:a60a:8538 with SMTP id e9e14a558f8ab-430c52b5afemr166066535ab.16.1760978897081;
        Mon, 20 Oct 2025 09:48:17 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d071eb25sm32795295ab.16.2025.10.20.09.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:48:16 -0700 (PDT)
Message-ID: <84f6f9f25d0ecc7884e6a3f3f87c03f651545d27.camel@redhat.com>
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
From: Crystal Wood <crwood@redhat.com>
To: Clark Williams <williams@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, clrkwllms@kernel.org, 
	linux-rt-users@vger.kernel.org, wander@redhat.com
Date: Mon, 20 Oct 2025 11:48:16 -0500
In-Reply-To: <CAMLffL_a2-RkOJg8kXPZSKhzenu9aPDs4SBz-F97y9-wa_oHHQ@mail.gmail.com>
References: <20251002205515.1299816-1-debarbos@redhat.com>
	 <20251002205515.1299816-3-debarbos@redhat.com>
	 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
	 <CAMLffL_a2-RkOJg8kXPZSKhzenu9aPDs4SBz-F97y9-wa_oHHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 13:01 +0000, Clark Williams wrote:
> On Tue, Oct 7, 2025 at 6:51=E2=80=AFPM Crystal Wood <crwood@redhat.com> w=
rote:
> >=20
> > Speaking of SOPTS, is this tool intended to be Red Hat specific
> > (and require redhat-rpm-config even if no RPM building is intended)?
> >=20
> >=20
>=20
> No, I really don't like that we have it there in the main Makefile.=20
> Unfortunately we can't push it to the packaging phase since it
> affects things generated at compilation time.=C2=A0
>=20
> Perhaps we need to have a Makefile variable that identifies a
> "distro" and triggers inclusion of a Makefile.<distro> that modifies
> the appropriate flags?  I know it's ugly but I'd like to give other
> folks (suse, cannonical, etc) a way to tweak the build.  We could
> default the variable to "redhat" and have a block that includes
> Makefile.redhat to modify the CFLAGS appropriately.=C2=A0

Why can't the specfile build phase pass in the cflags it wants to add
(after fixing the makefile so that it appends to cflags rather than
replacing it)?

Ideally upstream shouldn't have to know about specific distros at all...

-Crystal

