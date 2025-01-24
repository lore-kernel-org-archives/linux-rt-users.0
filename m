Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5584C91
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Jan 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680761; cv=none; b=cUWEUnfDGOIMX7VuHhIuZOpSP9J5TXcQbQH2jnHW1o0uu66hR5KtePbOquCsr9T+BtXCgBGUa0n7rSzshTC3yMFumLxE9NQ5/IhVWnKOAOonCkd+QY8tn7zIBKDZVjaRSmyJGWNmpZFwm17SUz/uIRhc4hsFkGffnSm76JSrP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680761; c=relaxed/simple;
	bh=/zvTmHPZcNGwcZU08RiTT6lemtemCJ++JlkPWHQBnok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6K9AXxG5+nrmR4094bp389mCTjim9Ft3bd7o3hLRZ6qU0gNR8lG17+iscwkP8ZDwytcm5V/rMp4pSM0ag+V1BNFYz/HbwUnALWlcnrpYhiCQLbALVMWCaeCD5KFcDDnaqHh3d71IYGS35CFUk4kK4A5iXtdvEjR1dWO5ydE4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJgKaPpW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJgKaPpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737680758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqgvFzxsg405QelU2oOgYSRKlqV3J9uMCR3CVNW3FBI=;
	b=ZJgKaPpW4ZILhk0f7aLNFxvcC4/zI1Hwu/U6euoEJFxggdYI00c5DfLvitlcy4L3Jm5MlR
	zFxA9BrF7UtFbzZ6eBbe7D+3yEagJFogTgMCiOkEWYK+I6wqt9QmTWOiZYq1heVnDA276p
	LSarmnfUfOX7i9aBXav4IXnIYWxcX6Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-VwaR9oyONMax4oHvKFoZWg-1; Thu, 23 Jan 2025 20:05:57 -0500
X-MC-Unique: VwaR9oyONMax4oHvKFoZWg-1
X-Mimecast-MFC-AGG-ID: VwaR9oyONMax4oHvKFoZWg
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e1b036e9so138631585a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2025 17:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737680756; x=1738285556;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqgvFzxsg405QelU2oOgYSRKlqV3J9uMCR3CVNW3FBI=;
        b=vJ5qS4ZQE4Z2a+oAWy4+iL3C5XJyPHu9aJ+PO1umIuFkHJy1XqNK0tXwc7FOyXTSbx
         Yezriypq8FB2CT3grD3eR9lIF2dwYL03uKleVKP5HPV3s4Ew7Ct0XpYInF67OG3PPLE7
         RAmUGE4b6/+xUsX0Nmu+F/bWf1sJhGpJnoh3I8EL1A/GcKEHnqlS862znnzxu3OkqVso
         FnS6h34CLoRlfXeYzUQ28BHN8eyeTiKLYl1vMceA/CJEd3clGW/ITHg0WMBMPO6Rs3t8
         HSolSkxGUApfT+Q/wT6OGi0UtvLv5AIFS0VIuRPovxShsYkuSPk0E+TQ1gNcWRhOzJs6
         +6jA==
X-Forwarded-Encrypted: i=1; AJvYcCVE8j9iRFiadOC3SRPgjXfcFZ/Xua62QZDLqEuyaZvUfx7M6TDU1hqzwLWNqldrEDght7vpylt0AVBezyMJMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnum7BRmyHwc/ULF/7rlLpcoC+aDHdnUSyNPEgGQHI3T/xGte
	yFffhTYic3ilNP8Y6e8eEYP4xr1arMjsEe+RGNM/k8mtkuQR90KjK1wbhiQUJ6M8ftmfO0VIu3O
	pfWKtKutSxLDLEJ7S9xe7H8Y2Zib+Qogkmaz+V8JpQ8lw/ZddkWkCfVpj5CJE/ebQ3dYs06shfs
	U=
X-Gm-Gg: ASbGncv0qhqCFLAClWceYV+17NHXwpbWw7Ixnh2gGTDysdgFSgppgs1Oy+ivfU5SxD8
	kNyAzcfqFEDGc+GTIHoU/eQN0JMJJ1HJ7H9NdhiO48OuFN2zP/V6uiMlrwTmm2qrexRTmV4ipH0
	IcSnI9vNtGO9b2i78r1VI/9X9Rt63LFypE4SOip+GJSpRqlV41NWx4tf4vmSeRbJQYbECA8SuUS
	tSYTc44o5HgcAkHVv/fCHbvD+D59DtLz3ZLclgHjKb6y+XHUymGVQikABBN5b1HZdItwvBVDeVc
	+3DKbV8UTMWA5skTFVDyYqUt7Q==
X-Received: by 2002:a05:620a:4713:b0:7b1:549b:b992 with SMTP id af79cd13be357-7be632024dcmr4590444185a.23.1737680756532;
        Thu, 23 Jan 2025 17:05:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFixlnjn1pbwO8FwZHk7KNFden2CO3VJ45n2VthdtEeY/bgQfZcwUaFRh4UDqmf/0ZYP89+bQ==
X-Received: by 2002:a05:620a:4713:b0:7b1:549b:b992 with SMTP id af79cd13be357-7be632024dcmr4590441785a.23.1737680756245;
        Thu, 23 Jan 2025 17:05:56 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af11a3dsm39921785a.109.2025.01.23.17.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:05:55 -0800 (PST)
Message-ID: <f26e28d358931624986dc304c5cb0bfce2dfd498.camel@redhat.com>
Subject: Re: [PATCH] rt-tests: pip_stress: Add option --usleep
From: Crystal Wood <crwood@redhat.com>
To: Shizhao Chen <shichen@redhat.com>, linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>, Clark Williams <williams@redhat.com>
Date: Thu, 23 Jan 2025 19:05:54 -0600
In-Reply-To: <20250123060443.31371-1-shichen@redhat.com>
References: <20250123060443.31371-1-shichen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-23 at 14:04 +0800, Shizhao Chen wrote:
> Different hardwares have different threasholds for usleep_val to
> reliably trigger an prio inversion, add option --usleep to allow
> specifying it at runtime, to facilitate testing of prio inheritance
> on different platforms.
>=20
> Signed-off-by: Shizhao Chen <shichen@redhat.com>
> ---
>  src/pi_tests/pip_stress.8 |  6 +++++-
>  src/pi_tests/pip_stress.c | 10 ++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)

Hmm, looks like there was an earlier attempt (53956b6712fef1,
"pip_stress: parameterize usleep value to work-around platform issues")
that was missing the actual call to getopt... and then another commit
(1325cb7e9e3af08e, "Daniel Wagner <dwagner@suse.de>") that added getopt
but removed usleep -- while also adding a "-s" option that does nothing.
:-P

Some minor nits:

> @@ -41,6 +42,9 @@ merely increase the time that the low priority process =
sleeps while
>  holding the lock. (usleep);
>  Also note that you have to run as a user with permission to change
>  scheduling priorities.
> +.SH OPTIONS
> +.IP "\-u TIME,\-\-usleep=3DTIME"
> +Specify the sleep time of the low priority process. Defaults to 500(us).

The unit should be part of the description, not the default:

Specify the sleep time in usec of the low priority process.  Defaults to
500.

> -	       "-h	--help                  Show this help menu.\n"
> +	       "-h       --help          Show this help menu.\n"\
> +	       "-u TIME  --usleep=3DTIME   Specify the sleep time of the low pr=
iority process.\n"\
> +	       "                         Defaults to 500(us).\n"
>  	       );

Likewise here

> +		case 'u':
> +			usleep_val =3D (useconds_t)strtoul(optarg, NULL, 10);
> +			break;

Why is this cast needed?

-Crystal

