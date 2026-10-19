Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441230;
	b=0G3fK+XTqMlZDKB4dIxPTfTrwmqdcmZveT47ibgGxOikB0PbOb9EJxJxmZuBNs8FI63t
	 FvOAvSogCPyJuFkRB+9r6t4WPRuYDqmNUvYMyCKVk5+Rt9FF5864FSvEyW2udtfHPouK4
	 JX218w9BA1FO22zVI2MAX1N93rGpKkmcCmQGJ/qyst/Klxc7INOrjTvsX13bh0rLf3ofn
	 Vsxe45I5LfkmaaXM9OHX8VyPfrcVWBoRes+8eDuZVQdSZnZCbVk25Wf4GDaLKSOfAiPim
	 bO1irQ6YtMijdBEIpebbGNWws6v6IUFe9eC7NQ+WyZLlpcVdoQEZaIK4W7S6JIdyzJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441230;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=egY8aXoYUqLerkUG+cz/c3yIfOvIfJOmeCo0llp4TbA=;
	b=r4dcphwP8vd7rKrwam2FIvKRsTCDL4A0pXhrfRuUeqwlBg2e3U4lEKLW1W/pDoUHQJ5f
	 UsQKuF0LrKsN/7rmOuCFPdLCHcprUvnOavbLZw3RWaNn0QMi2kErk51BiOsqZ1EZK7ao/
	 yeYzlTucvoKYBFFsTZ6+s08By6P/oPjiloz/u0zuLq4s9UpPPBIy6YfUvvH/wv0TWBaKr
	 gyBJ89uxZb0LpEUEkqe4QTK1JDzp510XVGM3WIFA7UUeVm+niMZ/gJbZTpkHZjmDom8ui
	 pD5iYlRvJev94KmYsx2gJScOKNqQN7FilIgZ56AS8XjWrdWoN0CULe1azmn7NH+6Sxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wb0awvLa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kcvFFyjA;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB08606A31A
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 20:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DB08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wb0awvLa;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kcvFFyjA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792441229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egY8aXoYUqLerkUG+cz/c3yIfOvIfJOmeCo0llp4TbA=;
	b=Wb0awvLa0vLTLeMYygN6pLw0EjLQUo1A3VOJbv3Ys0Fg9fTeoZ0Fiw6URArBhvEdye12La
	0xVAL0kh0X2oJf3KsZe9ncweTG4ot6AlVi64I/1eQqt+R2wNxfX2TaXF30nmHOSw+r9Kci
	Fp5V6/Gr/Ispga8d3+VwwWCr9ZpLB+c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-dz6Y3G-cN0eLczyzuQq7rA-1; Mon, 19 Oct 2026 20:20:27 +0000
X-MC-Unique: dz6Y3G-cN0eLczyzuQq7rA-1
X-Mimecast-MFC-AGG-ID: dz6Y3G-cN0eLczyzuQq7rA_1792441227
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917a7fffbe0so49845996d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792441227; x=1793046027; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=egY8aXoYUqLerkUG+cz/c3yIfOvIfJOmeCo0llp4TbA=;
        b=kcvFFyjAkP1XVZhPdjaypRLD4E+PE3xpwWJQ/Bpmu/YvtZ651INiD15kToSuHHHFpx
         wHg5snEF7YAHhOGOejdSuCd8xRk13Wft5VP83l3XrP23ezYqycBZa/hkxw7BtGT0Nrwi
         x+8pcac95Jl6Z5pGCCtqpnMJ9L1jkvjec6ieYn1jqewMtQgpjptsO+/jRzZFyWmk/o58
         2Chal7XsxWDsUB4ghFDyAbokSAyn0ywv1JsB4MTwTXRdgY2z+KA4mOrz22bjoda8lFJ0
         iuUWAgUkHmjIN+Zkby3AqkSb8/vhy8tt1o+ebGcYCnbC3WDkXrCbgqN9qxVWdkJYRcv8
         rZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441227; x=1793046027;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=egY8aXoYUqLerkUG+cz/c3yIfOvIfJOmeCo0llp4TbA=;
        b=LAr8mZ8XwFQWgSFmIZUEtok4qrArZDQNjtPqAUQu3DDnPtuG9pnOfFNKGp3iGowTLU
         YuMgtOQQu5IRe2hj7lI2cc4d/i0femkQFaugNGIqtnU2V/PUAqXQKiJttSQ/YWN8Kjyj
         4O8fa9BX1Aw7X06zDShxHUPYm7ApaiuMrlT/ead7LCvMrqqeNZu+3SQiJIuRYgpzI4/g
         UUzq8+ntrgOFkJ1va75L4mbj4Uh3zXsCeeXC6et5xA+nrR1PH/HKeLgbymjPi486cSHK
         J2bUt8E3k/RxdZcvHVvZIrxd2PGQMxN9vOh+zEu0n8N6u94vdizkyoOL12Ns1aJDXlVg
         Uggg==
X-Forwarded-Encrypted: i=1; AKwUvBy4dvlrKOSMwUjSrYR4MUt2PPDWaGcqXHlXjlKzc923ZyFHjLDXEMl0XTzKGZGoYLbQiAeI7y4rsVwFTlTbTw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLeFWtqhcA9M6rZ5bvbwMVXz3lHc4qf4nAhZsAOjqlnKoT6lgvp
	qZivakbJm7t/9Ot94dcqDqC6tmqGaim5Ilt1WQTAhpYOvCnMKBZ0beHoJ80qfP6v24FBCC3VOCO
	9kVtCZ1KjuFhnEgr0G/VMT6tHEyhCIWFNk0ty3TRPR7QQAuMo7HaR3Mb44mUxaGbnNhW2
X-Gm-Gg: AYBFou1qpn69zykynoRX7qI4AfaGHAQUTbAM2JZvG8R41RLkKTpvBLbWyxpymV4Lcr+
	vAuJ9EZta5L0htiwMNXGvB7EySssDUwuvnjAUCSGbIUi2XvcRaAUGyRCpP70I2QsP/RGRSxMKXR
	ANDKWteTCEUxMgXTp8Jfhe58klcRMlZrOCfSQn9aQU08RcTxhFtsfDumC2xVsG1jv0C1gY8xVi8
	j9UDzK5ZmVvRfLVVmZ8ULDJHinuKWPImEJ0v+SQk2yAshosxaBMPgt5PA+pkRRoKlghfsgSNJ2m
	VZ1PVrypgS7sOhNsY4/bg6DNiVhWJXP2clFMbsQWnUePrupf/6EeLz8dgXQ3sVv5N4JjPLWAaHT
	MgTtNMlLRoUSBGyQWE0EyuBEExPGxIPM=
X-Received: by 2002:a05:6214:33c4:b0:91b:d5d7:8c90 with SMTP id 6a1803df08f44-91bdec2d7fbmr153181796d6.5.1792441226963;
        Mon, 19 Oct 2026 13:20:26 -0700 (PDT)
X-Received: by 2002:a05:6214:33c4:b0:91b:d5d7:8c90 with SMTP id 6a1803df08f44-91bdec2d7fbmr153181296d6.5.1792441226358;
        Mon, 19 Oct 2026 13:20:26 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc00:985:7b12:3d75:e5c0:6b9c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040d4cedsm5152556d6.34.2026.10.19.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:20:26 -0700 (PDT)
Message-ID: <98115d4661519c32e54faf26e086895562ea1383.camel@redhat.com>
Subject: Re: [PATCH v1] rt-tests: hwlatdetect: Restore tracing parameters on
 request
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves"
	 <lgoncalv@redhat.com>, linux-rt-users <linux-rt-users@vger.kernel.org>
Date: Mon, 19 Oct 2026 15:20:25 -0500
In-Reply-To: <CADDUTFxXf+3sB-kbnbTiRQZ6r7FQzdQRKYqxDVYobzQJh4bFFg@mail.gmail.com>
References: <20261011192959.2122274-1-costa.shul@redhat.com>
	 <b922c748910362ecdfaf90e79ac8bcb18d45dfa7.camel@redhat.com>
	 <CADDUTFxXf+3sB-kbnbTiRQZ6r7FQzdQRKYqxDVYobzQJh4bFFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 13:23 +0300, Costa Shulyupin wrote:
> On Mon, 12 Oct 2026 at 20:46, Crystal Wood <crwood@redhat.com> wrote:
> > Is there a use case for *not* restoring?  Though I'm curious which test=
s
> > are just using the default parameters.
> Backward compatibility results in awkward code.

Why do we need to be "backwards compatible" with this particular
behavior?  Who and what would we be depending on hwlatdetect permanently
changing settings?

On the other hand, what are these "later tests" that are relying on the
default values?

>=20
> > Why only SIGTERM?  I'd think SIGINT would be more likely.  And why only
> > when --restore is used, given that there is other cleanup that is done
> > unconditionally?
>=20
> SIGINT is already covered. Python turns it into KeyboardInterrupt.

OK.  Why are the SIGTERM handling and atexit call gated by --restore?=20
Are you claiming "backwards compatibility" for not calling the existing
cleanup on an abnormal exit?

-Crystal

