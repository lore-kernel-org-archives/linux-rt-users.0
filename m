Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4676C73
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450943; cv=none; b=kFwsdGUtXINLyQ0FvuSfIIxZarmCFGdcTO+VWdhgBOGP2GMS7Er2uoeREpkAqC66eWyAGd5m/Io5PiwyPOP4uaITsqtyRpqlb4OtLlhUcgD7Rqn3jWlivJLvoU6zrJt9Na01P6QsdEAgV6Yl3P3/Cx73ukj8cUAogtxBFjDi1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450943; c=relaxed/simple;
	bh=KsGetTIeNCwPy9T3TXvb79TqSxh6hZ5zwMqXPAhLBo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsimNdmND9IPWUse25pcWEQQRRgTTKAfP/HdUc1+x1rSZcH16D40wIP+vrjkI3TNo0sRBK5LjtFA74NsHs1Vn9ZPiN7hyvlrkR6pE5guSmL1mO25ihW6CcOZEfurglqyPISMO5bCRQ22P0Vw/n2qHIjjtMhO5Om5yBsQBsqGeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkw4TaiB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkw4TaiB"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so305a12.1
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708450940; x=1709055740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/lV2yT0XcPBxNziflgu8BgOBo4JwQg4+0+ip6n/qMc=;
        b=dkw4TaiBt0jTx1sScgE3CXdY0vZNZ66g0Le7xoIkWwNHAMnp+Zk01RzbVdqv0cvAPZ
         Uvi4K+JQ0p2/ZSoN1nvFoHJPkJsycW3rlLFsMCIG8LOEP+Ljl2pgD8ALGryG0PePhudN
         lw8/XD3xUndOsCLXMAE4tg8DNJCez0ao7PLRtG2lRxLMNCq7qaRsEzheq6Uot8jH6793
         6yDwUrbS6Ty38YokU1FHDf9PYjphoQCslaxnhNAhS7Ya1bb23KXKmydYpeN99DGoG6l1
         ACJ74NWBRPk+EEPHXWaXpK8YhEAJIZQK6cuMWHOx63OynvR7OoBaxDWAWs2yDE/JKqE7
         u3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450940; x=1709055740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/lV2yT0XcPBxNziflgu8BgOBo4JwQg4+0+ip6n/qMc=;
        b=PrbhJ6TIuUD6EVOopp1CYLaDk9IEbuiXS6gd26AZAYOohYfKXTwkg9S8BlAAQt7ccI
         dqyHExHDAzYCfXQXm2vWJ1b7jYb5LpMKy6idGVHuLafnCoJVysdr8x9vl0VV7vTHb3Kq
         9JBW9Xeaa+9RH4P3OcF+AZgVUoB6nCrDuNP7c2hRq/dX3LO2Fhs1Fw/Yibh7bBIL6l0e
         CrC15dOFKdzhONENEw/qPJe2Vvw0k1K6IpPhTUO7w1lIQ3uDs+3Ty17IJ70KiVWG3BFX
         iMs1CJ0Z1LM2L0RS0uGOd1GG/JnjqwdCixbYlYmARB1jrHnRAJAWz7lLDDr9knH6prN7
         QBSg==
X-Forwarded-Encrypted: i=1; AJvYcCWJKP7/qIRVsKgOiCgIjjzuFNej5uIW2tgrZ9LqUOr18qg3OUhz5bQRLmJOyi8OgKzvVzSvefNttJOvEl7VcgJad9UbJhvGSascqiMfz2M=
X-Gm-Message-State: AOJu0YyAeSBtVL045EUO53s1gVVfWUobW0+0Lo+LL1h9SpBPJfpA6q0/
	clkXQrrCnSqBgxJHUaaX2FkXtGcDoDua/zcftnh9ghV7LTTf6S0K2f2pffk6WSL57QyUnq20wNc
	K+vmLHBGgWo4Vp1RvbQi/Y0K5fnOrtV8/rr6yHY4QMSeZVxJ9KA==
X-Google-Smtp-Source: AGHT+IHGXwWT64hjLb9fg/atQAcjLhox7pc5R0CyDbDgdqq6PJR3HMNvD9Qc9cnsWlbpK/SaFamI+pKapmqHaukDwaA=
X-Received: by 2002:a50:cd57:0:b0:55f:8851:d03b with SMTP id
 d23-20020a50cd57000000b0055f8851d03bmr487118edj.5.1708450940072; Tue, 20 Feb
 2024 09:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219095729.2339914-1-vschneid@redhat.com> <20240219095729.2339914-2-vschneid@redhat.com>
 <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com> <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 18:42:06 +0100
Message-ID: <CANn89iJpwUpAROOq7+ttwTMCZu0=XhS4dgwcs44t-gb7-_ejRg@mail.gmail.com>
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

On Tue, Feb 20, 2024 at 6:38=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> On 19/02/24 15:42, Eric Dumazet wrote:
> > On Mon, Feb 19, 2024 at 10:57=E2=80=AFAM Valentin Schneider <vschneid@r=
edhat.com> wrote:
> >>
> >> The TCP timewait timer is proving to be problematic for setups where s=
cheduler
> >> CPU isolation is achieved at runtime via cpusets (as opposed to static=
ally via
> >> isolcpus=3Ddomains).
> >>
> >
> > ...
> >
> >>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
> >>  {
> >> +       /* This can race with tcp_time_wait() and dccp_time_wait(), as=
 the timer
> >> +        * is armed /after/ adding it to the hashtables.
> >> +        *
> >> +        * If this is interleaved between inet_twsk_hashdance() and in=
et_twsk_put(),
> >> +        * then this is a no-op: the timer will still end up armed.
> >> +        *
> >> +        * Conversely, if this successfully deletes the timer, then we=
 know we
> >> +        * have already gone through {tcp,dcpp}_time_wait(), and we ca=
n safely
> >> +        * call inet_twsk_kill().
> >> +        */
> >>         if (del_timer_sync(&tw->tw_timer))
> >>                 inet_twsk_kill(tw);
> >
> > I really do not think adding a comment will prevent races at netns dism=
antle.
> >
> > We need to make sure the timer is not rearmed, we want to be absolutely
> > sure that after inet_twsk_purge() we have no pending timewait sockets,
> > otherwise UAF will happen on the netns structures.
> >
> > I _think_ that you need timer_shutdown_sync() here, instead of del_time=
r_sync()
>
> Hm so that would indeed prevent a concurrent inet_twsk_schedule() from
> re-arming the timer, but in case the calls are interleaved like so:
>
>                              tcp_time_wait()
>                                inet_twsk_hashdance()
>   inet_twsk_deschedule_put()
>     timer_shutdown_sync()
>                                inet_twsk_schedule()
>
> inet_twsk_hashdance() will have left the refcounts including a count for
> the timer, and we won't arm the timer to clear it via the timer callback
> (via inet_twsk_kill()) - the patch in its current form relies on the time=
r
> being re-armed for that.
>
> I don't know if there's a cleaner way to do this, but we could catch that
> in inet_twsk_schedule() and issue the inet_twsk_kill() directly if we can
> tell the timer has been shutdown:
> ---
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 61a053fbd329c..c272da5046bb4 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -227,7 +227,7 @@ void inet_twsk_deschedule_put(struct inet_timewait_so=
ck *tw)
>          * have already gone through {tcp,dcpp}_time_wait(), and we can s=
afely
>          * call inet_twsk_kill().
>          */
> -       if (del_timer_sync(&tw->tw_timer))
> +       if (timer_shutdown_sync(&tw->tw_timer))
>                 inet_twsk_kill(tw);
>         inet_twsk_put(tw);
>  }
> @@ -267,6 +267,10 @@ void __inet_twsk_schedule(struct inet_timewait_sock =
*tw, int timeo, bool rearm)
>                                                      LINUX_MIB_TIMEWAITED=
);
>                 BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));

Would not a shutdown timer return a wrong mod_timer() value here ?

Instead of BUG_ON(), simply release the refcount ?


>                 refcount_inc(&tw->tw_dr->tw_refcount);
> +
> +               /* XXX timer got shutdown */
> +               if (!tw->tw_timer.function)
> +                       inet_twsk_kill(tw);
>         } else {
>                 mod_timer_pending(&tw->tw_timer, jiffies + timeo);
>         }
>
