Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A121EA71
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353772; cv=none; b=IB54IKg/fiit/GPfChwII78kByCAhtyGCE7IoudbnSAyeFIn2rl/Ab1TyFhkJlSEfE3Zuq77uuRY+MNu4baC7mI8YdphWedTvlZcclIXhT/Lom2LxNPzMF0UwlM/tl5YQjkp4E3bKqLLJ4pYJLAVhBbTBK9eaJlI3VUXDMGid/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353772; c=relaxed/simple;
	bh=pAQ36Mouu5LBU9w/qPkLQEX9p2kwmTFAJ2rFQbxWzyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8P/KpOi9MFoUdjDYaittWQR5dV/opeoBVCBJXnf3UCiYQfBdrubCD1tJILDLtJjNN/Ut84aMULOxpSfkyLRRk1w5iEXL8yt8uf98aYhQhAfl+aZSx3i4RIzInTWI0Ng8UIRCWu791QjNmW0J/tMzEfGpTShFCGKJgpVC4sH2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSE3iKHm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSE3iKHm"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso13743a12.0
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2024 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708353769; x=1708958569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK6TJ1NiFtkG4ibJWHZitNlZraEYM47hN7HesdXjSmk=;
        b=QSE3iKHmoGpXseBVKAYWaMMwr41vY9ifkCHKdzm5WGSeedcwHNIL1QSLMtyn6dyUkm
         SwYqRkY5iJU9X6PQnsQgQloOskR3MkfKDEJkRvWom61X34cVgH65ecqQ4HHUhVHHSteC
         9b7MU9htDrwUXtF0edX1FZzmwduIJyDE+xA8SuN8A1Cq61wZznvsNJMwzn4f/+g3RqLg
         KUHZY/hSeuWJjcX6jYzbQC3MLN0tzK9mrwV+wHTGHOxES9J6hOuUV92VIXGv2XRbFx+H
         7cM5D/TgmqOZH//tsrWNwHSTPIuBRx1xnykvLlKcNnMDZ4KJnkOr3FK9nJ+J/+81ASXH
         9jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708353769; x=1708958569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK6TJ1NiFtkG4ibJWHZitNlZraEYM47hN7HesdXjSmk=;
        b=M/PriuRw9MUxYJWf5eb0Hi8p5WaOtu1Hd82zrIas9eVbgMHX34CSSa+71/iWKjMzUe
         cXJixzCx6ZSOxAPM0im1a8u8uq6VrHhL0K67RAm3V5jeTn7+5yQepr+c7316SIe4pKbX
         J6rid8dX4UoxQ/ja4ZRVXxVmsBXr02s9X9H0jEDB+whtKt0Oiv3k3lh0Kv6zp2q661vl
         awc2ma3eMrrhpkcLzuje/OIt7F6VGBy2ZkDwDlnKjbKYJSTROjru/bMNGkD1f7DaZAIm
         yaoGpiMmsHJuSWOVsJKV6EbIFTOrIax4/Fg4cImpQIyEqWE464YGmwY9OxQOyrMNC+ba
         pSmg==
X-Forwarded-Encrypted: i=1; AJvYcCWWvL9c61DEYjP5VVxTeqp64a/VdthV9SagilNtKLSF+Fyu4Kgq13MTUwh7ssaoukvrIN5JazZE/NIZRUdC/ybc2ugjNc3vG1SzajS+TZ0=
X-Gm-Message-State: AOJu0YyuGcuqgUmw5UkM2o++cfKHMfk3Qnv9bWYXsaHzLyGuKNJvk+bn
	/20N89s47JTLSIRVI4EJC+jt6+gIB+CyE53b7FmWfRQrNXd/5gf9aobMLWWuwdNSpMrGapMvJAk
	lFVsr+ATuvWbjdRyaPdUc1zN8ez1ZK/7vJsWQ
X-Google-Smtp-Source: AGHT+IETr5Fg0KJAZlnaeDsbnQhKIQl70L4uyU1bEvQGzZr716e4ct6UKPj1TKwF25G19fVSf9HT3kKxRf0iELr+aGg=
X-Received: by 2002:a50:a697:0:b0:563:ff57:b7e8 with SMTP id
 e23-20020a50a697000000b00563ff57b7e8mr298755edc.1.1708353768955; Mon, 19 Feb
 2024 06:42:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219095729.2339914-1-vschneid@redhat.com> <20240219095729.2339914-2-vschneid@redhat.com>
In-Reply-To: <20240219095729.2339914-2-vschneid@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 15:42:37 +0100
Message-ID: <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mleitner@redhat.com, 
	David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 10:57=E2=80=AFAM Valentin Schneider <vschneid@redha=
t.com> wrote:
>
> The TCP timewait timer is proving to be problematic for setups where sche=
duler
> CPU isolation is achieved at runtime via cpusets (as opposed to staticall=
y via
> isolcpus=3Ddomains).
>

...

>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
>  {
> +       /* This can race with tcp_time_wait() and dccp_time_wait(), as th=
e timer
> +        * is armed /after/ adding it to the hashtables.
> +        *
> +        * If this is interleaved between inet_twsk_hashdance() and inet_=
twsk_put(),
> +        * then this is a no-op: the timer will still end up armed.
> +        *
> +        * Conversely, if this successfully deletes the timer, then we kn=
ow we
> +        * have already gone through {tcp,dcpp}_time_wait(), and we can s=
afely
> +        * call inet_twsk_kill().
> +        */
>         if (del_timer_sync(&tw->tw_timer))
>                 inet_twsk_kill(tw);

I really do not think adding a comment will prevent races at netns dismantl=
e.

We need to make sure the timer is not rearmed, we want to be absolutely
sure that after inet_twsk_purge() we have no pending timewait sockets,
otherwise UAF will happen on the netns structures.

I _think_ that you need timer_shutdown_sync() here, instead of del_timer_sy=
nc()
