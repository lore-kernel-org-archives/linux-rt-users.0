Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048743ADB
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450708; cv=none; b=HzE7Rz3PxqYFC9gLXOQPvm+HAgNP3fkFXTwsY8b2hiIToOpMCYaCf98766XFUOoYSAS+IepydTyi5oI8MYEd2SmPt0yW42rn2cqlIUR9W4tlRT4/Ra9RbeMEwMID3rB9KlirnleujXxEtlwyNkPMjJKLjBrrhWGApnTDN1ps9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450708; c=relaxed/simple;
	bh=zUJsJOJwU+9vWXinj1PCgD7j7+9VeRB+NDrCeSHsh1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpvRSgs7v27bbIO0kPUl5Esxr7uWtgYQxFqxEQ84fHj6TecmS292Rnfl5iYK3Jz0wKTZYowOABV0kOHcz1wCeo3+OjnJJtrsOBJA2so2dC4ZJlYGtfZbxVv/3uOyFQax3GZOmPAWNva5KKzuPFGIzLjOzDTnVNKAT4WOpjr8hK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVNAc9JX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVNAc9JX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708450705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pf6j+i6h2iPgXMeO4/kpzSp22DRqb12CU6kjm37WMmQ=;
	b=fVNAc9JXjOHOele13Xk2VAcGao4xpaHKSpHgnATUr6w1tzNGjaclWDx0m2tZmw2OgSPQ2p
	oThmw8lzy4O6Samr3nUL6TOW6nj1/uw6C7JkyTEDDudzcVZwz6DCBbA6DWerVUQxPBcH+/
	+/RxdraTyWc4T+jtyW1pG+wU7BG2u3U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-LRem83DHO4y1x-DdpKftNQ-1; Tue, 20 Feb 2024 12:38:24 -0500
X-MC-Unique: LRem83DHO4y1x-DdpKftNQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42c70b8e409so118712371cf.0
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 09:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450702; x=1709055502;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf6j+i6h2iPgXMeO4/kpzSp22DRqb12CU6kjm37WMmQ=;
        b=rVt6hLxaFYMzNami9T2q96P+mH9ZStlBLWg0ul+KnkZh/cGMtvvEfIGSvQTrcCn7uF
         ypJLK8AJek/2Rj+gU3S5V9Ba/IVR2jkhUyscTRnuBIAK7niDRugNtTYQ/4PzlPUJA7Qw
         8BXtl8ZUPwV//fjBzhjKLsQY9AyClufx1+p0jjJzTU1IlhGuubr3r83ialrWTuPRsEdS
         QytRTg6OZLsf79UcJiqYzpdb+vfyJyxJYEHD2JQ57W6oBzQT10Fnet8T1gt6D/lnD7cW
         /3Hl1C7aPmyLB73jYUWK0xu7BQOExIBuBSOp0jphVkdvS3HJ7lJi9YhSCoTvKXS08WkH
         SIrg==
X-Forwarded-Encrypted: i=1; AJvYcCWqkXJBOYbiZv7Xu6+lUAFrfwThoOaJhQ8XVPNXYxyTZEu9F/wJIRGXe1Wk5bhNdfHV4Fk7PP7WJz5n5xRmVyvR2TnnnC1oSvD3Qej8ENo=
X-Gm-Message-State: AOJu0YxpYa2OxMVza9W7ATyUbnfAjipKU7Lc8p7G+Np3K4izPfEYkqrz
	CWZG/w44Ue0b6V1gQ8yGJlZuVzXW3qzWb4+60ovSw8eYwr2KZnxvgWSo3eKr9iEOJyi7l5zkHzv
	taUaZS66Gnkb/Xi9aGpsJbnQqli6IPoyfTso3vECzwoY2XET5yv5AuPMuN28DPlJvtElGoc3b
X-Received: by 2002:ac8:5e4a:0:b0:42d:bf56:89b5 with SMTP id i10-20020ac85e4a000000b0042dbf5689b5mr23713086qtx.2.1708450702687;
        Tue, 20 Feb 2024 09:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeTTqdWsD2ryQ/kvJUPCPUdscvF51pfdUzMyfl8GGrTtsY+R1PNuGVQ+5MrI0u/bBA+53tNA==
X-Received: by 2002:ac8:5e4a:0:b0:42d:bf56:89b5 with SMTP id i10-20020ac85e4a000000b0042dbf5689b5mr23713056qtx.2.1708450702397;
        Tue, 20 Feb 2024 09:38:22 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id cx17-20020a05620a51d100b00785a64ba095sm3586336qkb.85.2024.02.20.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:38:21 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, mleitner@redhat.com, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
References: <20240219095729.2339914-1-vschneid@redhat.com>
 <20240219095729.2339914-2-vschneid@redhat.com>
 <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
Date: Tue, 20 Feb 2024 18:38:17 +0100
Message-ID: <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/02/24 15:42, Eric Dumazet wrote:
> On Mon, Feb 19, 2024 at 10:57=E2=80=AFAM Valentin Schneider <vschneid@red=
hat.com> wrote:
>>
>> The TCP timewait timer is proving to be problematic for setups where sch=
eduler
>> CPU isolation is achieved at runtime via cpusets (as opposed to statical=
ly via
>> isolcpus=3Ddomains).
>>
>
> ...
>
>>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
>>  {
>> +       /* This can race with tcp_time_wait() and dccp_time_wait(), as t=
he timer
>> +        * is armed /after/ adding it to the hashtables.
>> +        *
>> +        * If this is interleaved between inet_twsk_hashdance() and inet=
_twsk_put(),
>> +        * then this is a no-op: the timer will still end up armed.
>> +        *
>> +        * Conversely, if this successfully deletes the timer, then we k=
now we
>> +        * have already gone through {tcp,dcpp}_time_wait(), and we can =
safely
>> +        * call inet_twsk_kill().
>> +        */
>>         if (del_timer_sync(&tw->tw_timer))
>>                 inet_twsk_kill(tw);
>
> I really do not think adding a comment will prevent races at netns disman=
tle.
>
> We need to make sure the timer is not rearmed, we want to be absolutely
> sure that after inet_twsk_purge() we have no pending timewait sockets,
> otherwise UAF will happen on the netns structures.
>
> I _think_ that you need timer_shutdown_sync() here, instead of del_timer_=
sync()

Hm so that would indeed prevent a concurrent inet_twsk_schedule() from
re-arming the timer, but in case the calls are interleaved like so:

                             tcp_time_wait()
                               inet_twsk_hashdance()
  inet_twsk_deschedule_put()
    timer_shutdown_sync()
                               inet_twsk_schedule()

inet_twsk_hashdance() will have left the refcounts including a count for
the timer, and we won't arm the timer to clear it via the timer callback
(via inet_twsk_kill()) - the patch in its current form relies on the timer
being re-armed for that.

I don't know if there's a cleaner way to do this, but we could catch that
in inet_twsk_schedule() and issue the inet_twsk_kill() directly if we can
tell the timer has been shutdown:
---
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 61a053fbd329c..c272da5046bb4 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -227,7 +227,7 @@ void inet_twsk_deschedule_put(struct inet_timewait_sock=
 *tw)
 	 * have already gone through {tcp,dcpp}_time_wait(), and we can safely
 	 * call inet_twsk_kill().
 	 */
-	if (del_timer_sync(&tw->tw_timer))
+	if (timer_shutdown_sync(&tw->tw_timer))
 		inet_twsk_kill(tw);
 	inet_twsk_put(tw);
 }
@@ -267,6 +267,10 @@ void __inet_twsk_schedule(struct inet_timewait_sock *t=
w, int timeo, bool rearm)
 						     LINUX_MIB_TIMEWAITED);
 		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
 		refcount_inc(&tw->tw_dr->tw_refcount);
+
+		/* XXX timer got shutdown */
+		if (!tw->tw_timer.function)
+			inet_twsk_kill(tw);
 	} else {
 		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
 	}

