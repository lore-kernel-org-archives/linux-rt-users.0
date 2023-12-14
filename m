Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbPKkQOY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B39C
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 23:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702539761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5LF8xK5y+MgJRvWRMGVMsPq2E74SlQ2qQhzgs3jI9w=;
	b=DbPKkQOYBxoMXYPD6u7yQ5wseNaYmNPPj7XTnM8nfPpVAZ8IVHTQqnPJgBEtiZQxne6DLg
	lGWHv6l6Ttwe6vGs2NSCPbz/q8Tcv3BvKo96Zp9DoyEg6Bsaay2hgerMEdb75DRSAq++Ky
	Hvr8KyNmlq/iZzpnZ7OvNESW61gMGvU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-iY1Dn2mpOku_aXzgr4yocA-1; Thu, 14 Dec 2023 02:42:39 -0500
X-MC-Unique: iY1Dn2mpOku_aXzgr4yocA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1d72320a33so460083566b.2
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 23:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702539758; x=1703144558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5LF8xK5y+MgJRvWRMGVMsPq2E74SlQ2qQhzgs3jI9w=;
        b=u3jaFxCuxndmR1p89Vur8wy2PPWl5dCWFCXhJCOISPOGaLyq8iOtSaqsFR51oi4roj
         dlFderRQiCsBBBUwPdf3jgGLOkMVWUc8ACgq2pcH8GQw2PuRmFcDBC9ku35SE0s4vN8E
         8JvtSrXU1GspzhnTuHZWOWRM05Xt+kIIzCaKDLlWJHqMHIXxhVvYLpZOTdPj6Qufgi/N
         8VwhBdFO7WV8fSmqn1TlOLayUtz+NfIRL+I4Fv6zKGKIQ9wzffuFR4wLDTs1Uyt/B70/
         vZslHLiqRYZ4M53Kt4vx5MHclP0LQigOI3BpyiXzirK17KnMWfKkZK7BeP/7OGoE+li1
         aQgA==
X-Gm-Message-State: AOJu0YxyF1/w9SZtqwWtoPfS75EhagGRdmjrGn7eqnlAbQv0c5HX+hL2
	3dL/QM5PftEssGGTrPYbZRomREb08unbgJuhW7Of60tiHZYRcXJZArxaYNp290S21ls+YiitMBP
	m658NbSVA+eLokSoMjzu/yEO5nMFiHxAYLi+xQCOUdIMs70oBDPE=
X-Received: by 2002:a17:906:d8a5:b0:a1b:75fe:3ea6 with SMTP id qc5-20020a170906d8a500b00a1b75fe3ea6mr4492595ejb.99.1702539758292;
        Wed, 13 Dec 2023 23:42:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPUFvZZouBFFv5PoQj0ZxeLDN33md/rGf5vgTySj96XT1wONbg2DjhEQlGPN5akHrsMevgXYJ/Huj9zifLArQ=
X-Received: by 2002:a17:906:d8a5:b0:a1b:75fe:3ea6 with SMTP id
 qc5-20020a170906d8a500b00a1b75fe3ea6mr4492589ejb.99.1702539758020; Wed, 13
 Dec 2023 23:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129093457.17984-1-tglozar@redhat.com> <20231129093457.17984-3-tglozar@redhat.com>
 <28c8961f-fe4c-4ea2-7cba-55e1cde2f68e@redhat.com>
In-Reply-To: <28c8961f-fe4c-4ea2-7cba-55e1cde2f68e@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 14 Dec 2023 08:42:27 +0100
Message-ID: <CAP4=nvQ40NChnECdgLUJ7o4E_kwT3uTtfJ9kcxwEmuE_Dz5Hiw@mail.gmail.com>
Subject: Re: [PATCH 2/4] rteval: Minor improvements to CpuList class
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 12. 2023 v 22:23 odes=C3=ADlatel John Kacur <jkacur@redhat.com>=
 napsal:
> Oops, your code is correct but you left in the old wrong explanation
> you need to fix this up before I can apply this.
>

Yeah I completely missed that!

> Are you sure you want to remove this? We have three states,
> 1. cpu is online
> 2. cpu is offline
> 3. cpus is not legitimate, ie, we have 12 cpus and the code asks
> whether cpu number 1000 is online
> I think you're trying to write more elegant code than the original
> implementation, but is it safer? Should we maybe check if the path
> exists before calling sysread()?
>

What I didn't like about the original implementation was that checking
if a CPU is online has little to do with the CpuList object. Thus, I
made it static and removed the CpuList argument (self). I agree that
the proper solution is to check if the CPU exists in the system
(instead of in the cpulist), not removing the check altogether.

Tomas

