Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448405;
	b=k9GpISbpQS7AHuozSoU35Jq6XnxaVH6fvIyxufFRDvcK7TtRx+HOMZvPjCZ63gVGdu4E
	 yFILXHEzQOeBG+ha1V9YWzlSTLkBKUroXXiE1Ik1ju8wkRxerbYeAts885BBPNYXfILf3
	 YgXcUBvmIOFRTlTRgy31JdxddeL33DPha+avffzsrphmmk6jaqKNaVEe1vorYEJRqgHBf
	 MvI83wIFaE/74WwLDqSGSM+j8eSaNP+03ZhLwn5Ea/6M2nCwCuVO5kZYi15bBnHC7djbv
	 s2PTtk5weycP9idbPotrLpYraUEJJu02btEhXoJKXi/Flbw3x5qxI4vRB5Uj+w7+ofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448405;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=I+1S7I+DIWnouAC5bYzzBExbEORkLO2zD+ZvpAAdWKs=;
	b=r4+7Hp7EO9op89BVj1+hZNUwf7a0pFUrfLDs9SLDK4u1dsl+ZK/GOaHAF5uBJKbY3hmV
	 o7hWCsyc232mJunUIP7TtiCc9XC1wDjN9hCOCYCWuHIEYLDCDSu6eea2urYMbmpPraZkI
	 dmoz7bC6C2Y+w4joFEDlroCjp+zYsTDQPBJYbL8bvAt8XMMHKPAWCAbT6RbOqt91k4tfu
	 OmIn2Gfk80GIOoWpYDBzPkM64y2Ln/67vdYjYVtjSPd3esUU94vbJbgegWh3/EfOsF+qH
	 f5fDOiSbNZuIzsdwh7ZrC07LkZBWRk61Qsgsjzl4J4HeSn6pF+B9CrLUE094fDJTD7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AU0JuYAA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=d0ISB+pw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77C606A31A
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 22:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF77C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AU0JuYAA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=d0ISB+pw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792448403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+1S7I+DIWnouAC5bYzzBExbEORkLO2zD+ZvpAAdWKs=;
	b=AU0JuYAAK74jHjxVgDqlPNmOBpIXt0jCaVNssUE3Rv9wUr/AtZJ+/0Cq4bSNLDzOE4SeEd
	461pR5rv3M0Su2XP1LFPIdXQWXpYgDtGLNqUaTd38Dz+Nw6Ozi8zsVH+XwckRn4FywQJqg
	JXG2VFCntdsaoqD42kr0uK1uhTISkCk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-oRp-z54oPbKev8A7kmef9A-1; Mon, 19 Oct 2026 22:20:02 +0000
X-MC-Unique: oRp-z54oPbKev8A7kmef9A-1
X-Mimecast-MFC-AGG-ID: oRp-z54oPbKev8A7kmef9A_1792448402
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934956beec8so562837885a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792448401; x=1793053201; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I+1S7I+DIWnouAC5bYzzBExbEORkLO2zD+ZvpAAdWKs=;
        b=d0ISB+pw1mn5p2xdw6+FweOFv7WIYMpYYbtjUJDCpxp9k01rCo3FUAyS/oZ2BKDt5L
         8GYexxH6OHDFGKGeBzPXN8mypIodqjMXhaY6JjWUF2aDZOBeJkTeqvd+k/aOUUdkKJqT
         79OjnSfMnQHB4xC+x9vQqM3VPJqFoS54f6qB/3ntHJwDV3Lvmt6zNcbsUFihU19sB81n
         389fotWHnv9dYmFxLEEtUYm4zBivXZkVXNk2mY/SiIoYUU1Eb4zsRtHBQKWvW18oWZO5
         jzywoyObPoiFafRcHNQpR9gBjTHObnzZJJG1Bs0tDFJqE3pZBPAf9rYhj+c1ZB4NY0/9
         E46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448401; x=1793053201;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I+1S7I+DIWnouAC5bYzzBExbEORkLO2zD+ZvpAAdWKs=;
        b=WghRhlK+5kj/4+fBdPgBGu5iezcoQaHQOyRn/pdw7Gjomxgt0RFixC/HlLsBbhBDLQ
         puESv2UaqP/g8Onw+2MvuA+pll+6yES4EzLh2Fiz37I/H2jkswWdQaTGZpEj92ggXNHR
         5ksDB0rS1iSQr4iufU5CMT6+nR3mYjvvUbqBjc+sHnjcd6Eu6Dm+PjQ3nYrjgpv4piSz
         +SGFe+e6vjYGOKDzax+N8birlIibsjxas9ZGq1BdzCG7TwcLE+Nn+qYTBlWddzAsnWtj
         yZhVNz3EVexb74tJqP9bCSgPwbql0QMKWM37NJHmF5XcBhWdGY6fOtdvpSLqd5WWhF17
         ltuA==
X-Gm-Message-State: AFq9FYLvMiMG+XMiODv9X2hyzvfHZ6D66OEeskSqforBZUyIYTUBrhJ1
	vp923eSd9AbdERazVYAnTxJuKT682YfjbxDX2ANELL5+1xkk7vSoOyZhh2iPrPMVAd6LEH4wtyu
	y4kyGEdj+iijgPi1Mx/zkjxx5a01ZkoSYndVNQMmnBoXnuyygShdxP8/HZKcp3e+NctcU
X-Gm-Gg: AYBFou3USvmDBL7N0IpyqW227lm1On8WbsSjjZ1jT8PxW9HTICyo+CLvYkVno3TzWuD
	ytqV4PABmH1clGAl1EKPuQmhrpR8uerVUAZImNQsZYDnow901kQK84AK/72uqT9XaI9xQb+t5ws
	pgVl7iSsb6BWzPdpzM48jhGPX+b+2T4GA6kXsfz6FruDsnd0pOFye8ueHFskEeklKb4Dinu4xKU
	LbwLyfqdhKXtds7mvVlYmJA0ANpEhgNOZ1mIgg7bsz9/SqobdiEGZf1j5uf1NiBl+wUUZO2wGWE
	cubf4ObJVavzwB8Oq+ayvK+utBM0sjb6Ui74CVfeIkTyXJwAJf2k37M8IPDyuhJXjVUzz/4povL
	RKIgIGj4cFbXiC3QWZoczP78iwS29uiM=
X-Received: by 2002:a05:620a:371f:b0:93f:16d4:3bf0 with SMTP id af79cd13be357-93f29d38655mr1547463985a.42.1792448401546;
        Mon, 19 Oct 2026 15:20:01 -0700 (PDT)
X-Received: by 2002:a05:620a:371f:b0:93f:16d4:3bf0 with SMTP id af79cd13be357-93f29d38655mr1547459985a.42.1792448401060;
        Mon, 19 Oct 2026 15:20:01 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc00:985:7b12:3d75:e5c0:6b9c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040cff98sm7776076d6.33.2026.10.19.15.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:20:00 -0700 (PDT)
Message-ID: <924299031193bf59590d6a6a9a751ec772642083.camel@redhat.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Restore tracing parameters
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>,
  "Luis Claudio R. Goncalves"	 <lgoncalv@redhat.com>, Bart Wensley
 <bartwensley@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Date: Mon, 19 Oct 2026 17:19:59 -0500
In-Reply-To: <20261019102909.3339372-1-costa.shul@redhat.com>
References: <20261019102909.3339372-1-costa.shul@redhat.com>
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

On Mon, 2026-10-19 at 13:29 +0300, Costa Shulyupin wrote:

> =20
> @@ -606,4 +621,5 @@     def cleanup(self):
>          detect.display()
> =20
>      detect.cleanup()
> +    atexit.unregister(detect.cleanup)
>      sys.exit(maxlatency > hardlimit)

It's not a huge deal, but you could just remove the explicit
detect.cleanup() at leave the atexit registered.  It'd be a bit simpler
and wouldn't leave a window where cleanup() could be executed twice.

-Crystal

