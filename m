Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD7136988
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jan 2025 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287587; cv=none; b=DDmbwcQjyYhwePNOjxgaMW4ih5lI/hfqeIjRI5xrwpgrnpCGkkPVzzUHXEflOnImx6U4oOXl5Umqpkmg+JfGYn4Y01ZAzoFOO9pVRFCMOW3rRy/nl/F7C6wewPaKHEacsSmMtvNGfNUcDD2ILXYh7M2JKlfWlnd4P74A2yA5CZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287587; c=relaxed/simple;
	bh=QOZV3fc/eTyVYZnstslteMI47yDoyt/imY0bwJsIig0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UkK+gLhhHAuKYBR0yfrEpcFrLRCYNnmVJl8DR6IxJiC3Ui4iK6XvnN4O8Mmz6BQIglvpOjAv1sld5HO02c2psEkVImVpO4vxHhuUgbzmKWIZQTZtp3BaurloVW/0Exe+VvqE5rbWkkvCqbny84PFgtT61bGWRDJDwILBp+cZq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl0gkFhV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl0gkFhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736287584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOZV3fc/eTyVYZnstslteMI47yDoyt/imY0bwJsIig0=;
	b=cl0gkFhVIO+A4MH3RZpYMghdz0t//TNli/MRPFYvyWEf10DrcR+sldLC+x4Pqn3ONgzM9Z
	TTSKXqiUb+FL0KqE0SQpDEIBIgJ6b66NsKtxNPpqP+Qm4BA+VL9mfb7FOkR/9nLzVilenB
	rYVqOUTOoXdpi5MqaULZZT75vJmcRjI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Tr_3k7e_P-eIpPGv2aPtxw-1; Tue, 07 Jan 2025 17:06:23 -0500
X-MC-Unique: Tr_3k7e_P-eIpPGv2aPtxw-1
X-Mimecast-MFC-AGG-ID: Tr_3k7e_P-eIpPGv2aPtxw
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467944446a0so274816251cf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jan 2025 14:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287582; x=1736892382;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOZV3fc/eTyVYZnstslteMI47yDoyt/imY0bwJsIig0=;
        b=BhvkACl3vgN35l5y6UyAZleJKA+VNr45r22GCpBUOnQRDQ0QJ15k3ns9WXqX/wOS1Q
         ilPInP0GCfxVoP14LUahmCDj3zLCPZn332ZWFhU0irISWuDWbsXqWCAzWYXhfvkoBX43
         M7rg1UcZQmW78By1x7Kacaz9rkp/Bgn/r4KvZ0jqhSLu82YwumIJuQtrcgm2hF2PUbhS
         iOdh9Tcw5b+APFpMFhPVuQqOt3RfW2JdE/Rb/8Zni6GpfhwnWWBfOjhvA3hb/wMlQ08e
         fc9qT0aYDSXgN6j9Qpnio/T1zEJ49aJo4246sO0ctHMBI3o/NdGri4QS0LaU/qmOurAR
         P2yQ==
X-Gm-Message-State: AOJu0YxxfzOdhxwwRGko+WRY4PsKX6BH/oWb+R+y8Oxx2TrNvMZiJLj5
	UEyd5jmd9KvK/AWB4EyaDNg4DlzuYTsv1E0ocAETmy7TB8VRmjG32mO6bgitddzrfdHjxKnHi5z
	4gTmrB8rgV4wR0KoRYwqcGWYRP/bIuJMTaI5cKtcWvWw08hVaoXwgC8Ub+Ihlva5i1TOD3V7WeA
	THJg==
X-Gm-Gg: ASbGnct4a6UkjEse9HAjR82SNrreBE4ZBgdjkU/lm00pWKXzU+zIw1ZL8H/4xPX3o8M
	vucrvMsU+spo4q99TszCxHIPeAJntO/RVgrVcxUTzV3zsRparu/CGw+gSJ7RLuPGRZ+40EuxxJO
	jsdKLNwCx42XrqmU2HANMlUFc7ZzvEQUxMf3LuYWRodEeQuvF8xfKA2UbgxMPECYngFTVphM+C7
	3mOaozQAX+7iIwp3DId6AOCyUcfltVwn+x06knmPcC1/VGpA9NzRPYnNPk9vytRkxB+m0uab53B
	35iY/k8j+6e3xADg5h6KHqLG4qHqKSXAZgjHE6Heu1V80Q==
X-Received: by 2002:a05:622a:19a0:b0:467:6c18:9857 with SMTP id d75a77b69052e-46c7107a8ffmr9461681cf.37.1736287582284;
        Tue, 07 Jan 2025 14:06:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhnpkYaz1z2xOhvgHrrkarR+YgYYAwOylzmANT2No/NsxCsi5Pke6r/22FwSnJWCeK/s7zJQ==
X-Received: by 2002:a05:622a:19a0:b0:467:6c18:9857 with SMTP id d75a77b69052e-46c7107a8ffmr9461481cf.37.1736287582020;
        Tue, 07 Jan 2025 14:06:22 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6a9bf7sm190123751cf.48.2025.01.07.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:06:21 -0800 (PST)
Message-ID: <f6680377ad1cc88a8548f9834a5bcebb559411af.camel@redhat.com>
Subject: Re: [1/1] rt-tests: cyclictest: Suppress unused parameter warnings
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, Tan En De <ende.tan@starfivetech.com>
Cc: linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
 williams@redhat.com,  leyfoon.tan@starfivetech.com, endeneer@gmail.com
Date: Tue, 07 Jan 2025 17:06:20 -0500
In-Reply-To: <2536ec36-44e3-e88c-1333-678dc41c649c@redhat.com>
References: <20241212162453.2618945-1-ende.tan@starfivetech.com>
	 <2536ec36-44e3-e88c-1333-678dc41c649c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-20 at 13:07 -0500, John Kacur wrote:
>=20
> On Fri, 13 Dec 2024, ende.tan@starfivetech.com wrote:
>=20
> > From: Tan En De <ende.tan@starfivetech.com>
> >=20
> > Mark unused parameters with `__attribute__((unused))`.
>=20
> You were probably trying to be consistent with the rest of the programs i=
n=20
> rt-tests, however, according to checkpatch,=20
>=20
> WARNING: __always_unused or __maybe_unused is preferred over=20
> __attribute__((__unused__))
>=20
> __always_unused is slightly shorter, shall we try that instead?

Checkpatch isn't perfect even when used on kernel sources, but should be
taken with quite a few grains of salt when used with other projects.=20
Failing to use a macro that doesn't even exist in rt-tests is a bit more
than "trying to be consistent" :-P

-Crystal

