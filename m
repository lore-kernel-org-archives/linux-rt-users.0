Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E8258EE9
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Aug 2025 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721104; cv=none; b=XyUCSYzW4TTrjV4WA1Rjz8+JOH5E3ntIZ7W4bdn1GDv9xPfC3ziPsGTFMj8yyoMnlQFlvmFXUcEx2fpDU/7d4BG38+Ot/PMZN0NCB3yENJkFWco9Xv7xAEYEA4U2ASJ6vWqxZmkBiG73H5NV7ZjiQ7xi/rWMF8F+RCxSigv+V6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721104; c=relaxed/simple;
	bh=ifEoC8Iv5idyoKxhxESrAZsda6jFydG9oJFf6TTHPhw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHixrJG1vpC0ASzQg142u+fDf2hW6lDM/cTXQ06xFXD0rYj95QDHbx9582+9Jjg9qoQozFS0VtqjrY2d7IYnjIg1xYhbinJfxn+rgqRPeUhYxDuWgnsh3Y+us2spIiDNPuLJ5eCsumxwfsRTV0jCHi2BCr9dSlwiAOKY2xlNeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBi49o/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBi49o/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755721101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXrhNkeed2OUqijKD4JEmzkqsVdin6VC0AcBs5m78MM=;
	b=hBi49o/ScxCHV9K4tNzeGW0p8/4v5PxNB9FiViYx3TOrGeABRa6LZeeeyjv6glncXtXqWQ
	yxhFrqm/3KWvaP/O1cfX34haS9zBSlkDRIwgFFpIakEmX9EKDoutIpJKC3dzvpdLYZd2qU
	UaIGYeHj8QMK7KoYeK+iodrq9Y5eozw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288--mwdi7jiMIy1wNlyb945dw-1; Wed, 20 Aug 2025 16:18:20 -0400
X-MC-Unique: -mwdi7jiMIy1wNlyb945dw-1
X-Mimecast-MFC-AGG-ID: -mwdi7jiMIy1wNlyb945dw_1755721100
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e94de07bbb7so548251276.1
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Aug 2025 13:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755721099; x=1756325899;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXrhNkeed2OUqijKD4JEmzkqsVdin6VC0AcBs5m78MM=;
        b=XnyoOMCRa9jnH+SmXT32xKGmlGq5RRRVSAMXTLWjMPQ8YO+uEBiD38Rm4GWcP/KDmb
         Uj6frgR2Oxb/qVG4Nb2ujnhKGqdrwh++5AgS6jpmaNABBSybz1VVvtom+p9oFr6y0SMt
         jTumXSbMPcA0gqVEY8wZjKe6SQzzSGru+4KBT8vOsFvlZcZYRMazK4korMv0Oux2wkXU
         ESs0umug+GuiDQUknOA0PU/ceWe6RW6ZDIMQen9tS/DENt857exlXYw4sTlCMRONVdeU
         FqCXNYE6I/8TUIteMJXVJq7sbD60V84LlbMg5CFUkmrpUm+pik2/6GKRFU4TUDZG3Qu3
         bFCw==
X-Gm-Message-State: AOJu0YwWbYFnhIBtzzp4bwL2nPoRdi3SkglgLiREQmEF4VR7DSfH+b9N
	3XrEVHYrrxdDY9NP8mvbcmPP1EeAtq+83vng0SJQlSV9uIWsBDJyQfzTZTzSi5iuFghpFsr2C4o
	bD3CAI2rmCYHqC8HgsRcb2mmlpdxGTu3xR8V8LYXIv1SrezC/32+XRRBuUJ4f+iYF4e6q+JNkxN
	/X
X-Gm-Gg: ASbGncvmmn9EmjGf4uUY2Oy7EZFDn4da2204JamHP+41w5QXy0cNTglP4wfmis4IaM2
	4qvuKn/O1RA52FTslDjeIN3GaVgv1YN17/o6V296w+0FQafRYTzf3RfJh+TToow+JLoz28htsjt
	ulbrxfWTJg8GoS0PLUDjDzMctI5CeUK3mEXVU8oNXNas7/6saccY3Ej7wrifLrGk06Lq6Ak2HJE
	rTLMWMy0NRF5GwMSSJ9t265UU4bgJKANiqyhXvFsreKtzL370bxlJfhnwAvZkeWRjYX9wPGsJRU
	/2C0JkHOqqs2xEahuaFmieZCoYf8n8sYUQrNHP9xtJLjKYdfxW51gNoK2ON0Ryjjq20yZ4s=
X-Received: by 2002:a05:6902:2743:b0:e95:33c:ea83 with SMTP id 3f1490d57ef6-e9504937ad2mr1088799276.12.1755721099595;
        Wed, 20 Aug 2025 13:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPGNVqZ81QUlXgPICsnXAXc+bnIfyKFiLrqKp7jNm1lC66LyQr4edQXIpdY7XoxHqB1DqsEg==
X-Received: by 2002:a05:6902:2743:b0:e95:33c:ea83 with SMTP id 3f1490d57ef6-e9504937ad2mr1088769276.12.1755721099234;
        Wed, 20 Aug 2025 13:18:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f805c56fsm955784276.3.2025.08.20.13.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:18:18 -0700 (PDT)
Message-ID: <915bb279b1614baf860134e122de48ea6a5e2777.camel@redhat.com>
Subject: Re: [PATCH] ssdd: mitigate tracee starvation
From: Crystal Wood <crwood@redhat.com>
To: debarbos@redhat.com, williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, oleg@redhat.com, shichen@redhat.com
Date: Wed, 20 Aug 2025 15:18:17 -0500
In-Reply-To: <wljofbc7n4h6pav3tnvjgl6if7mdkkwep3uvja3etew2dyptbx@tyxiungtvg4r>
References: 
	<wljofbc7n4h6pav3tnvjgl6if7mdkkwep3uvja3etew2dyptbx@tyxiungtvg4r>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-20 at 12:18 -0400, Derek Barbosa wrote:
> When ssdd is invoked with nforks > 100 && niters =3D=3D 10000 on a tuned,
> realtime kernel, the following error messages can be seen:
>=20
> forktest#4/8719: EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCH=
LD seen (signal count =3D=3D 0), signo 5
> forktest#1/8716: EXITING, ERROR: wait on PTRACE_SINGLESTEP #398: no SIGCH=
LD seen (signal count =3D=3D 0), signo 5
> forktest#6/8721: EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCH=
LD seen (signal count =3D=3D 0), signo 5
> forktest#10/8725: EXITING, ERROR: wait on PTRACE_SINGLESTEP #388: no SIGC=
HLD seen (signal count =3D=3D 0), signo 5
> forktest#11/8726: EXITING, ERROR: wait on PTRACE_SINGLESTEP #388: no SIGC=
HLD seen (signal count =3D=3D 0), signo 5
> forktest#12/8727: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGC=
HLD seen (signal count =3D=3D 0), signo 5
> forktest#14/8729: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGC=
HLD seen (signal count =3D=3D 0), signo 5
> forktest#15/8730: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGC=
HLD seen (signal count =3D=3D 0), signo 5
>=20
> This behavior is caused by ptrace_stop() being unable to sleep after taki=
ng
> tasklist_lock().
>=20
> As forktest() generates "niter" PTRACE_SINGLESTEP's for nforks, in the ev=
ent
> where nforks >=3D 100, the sporadic test failures caused by missing SIGCH=
LDs
> indicates that the tracees are unable to effectively wait for their async=
hronous
> signals to arrive --as denoted in the previous sleeps for check_sigchld()=
.
>=20
> Therefore, by performing an addtional sleep() in check_sigchld(), we give=
 the
> tracee enough CPU time to call do_notify_parent_cldstop()->send_signal_lo=
cked().
>=20
> The observed behavior after appling this patch mitigates the aforemention=
ed
> issue in scenarios with a high number of nforks.
>=20
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> ---
>  src/ssdd/ssdd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index 50f7424..7fdb039 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -145,6 +145,15 @@ static int check_sigchld(void)
>  	for (i =3D 0; i < 10 && !got_sigchld; i++)
>  		usleep(16000); /* 160 + 150 =3D 310 msecs */
> =20
> +        /*
> +         * In the _worst case scenario_ where the signal still
> +         * has not arrived: the tracee is starved or
> +	 * preempted, and needs more CPU time.
> +         */
> +        if(!got_sigchld){
> +		sleep(1);
> +	}

And then down the road we'll hit a load high enough that an extra second
isn't enough...

How about replacing this whole thing with a call to sigtimedwait()?=20
Especially if the goal is to do the steps "as fast as possible".

-Crystal

