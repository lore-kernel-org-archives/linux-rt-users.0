Return-Path: <SRS0=ZIbK=ZE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46630C17441
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 11:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732F22469
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 11:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQxqDKXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKLLWH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:22:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727401AbfKLLWH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Nov 2019 06:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573557726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtYnGMr5u72FmNd1yn+nI6SaAcFK0v77+NDq7abNWcs=;
        b=EQxqDKXGHPF1UmC81X+x6PDPXK4vPHbWmYMCqgP+//TYtziqQ80PI53lXUz+tIXVkR0kqM
        TAUZmt3qDdPawiA2aPrU2FKpyN+5t/v76pXtIddbSCcYuVpR9E9LYcvjY95FqngbNgTNWq
        J41y+IWGXIdBiJzkK7qZxXufn4e7glY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-cUd-53U_ONOGSvs_zXHVfg-1; Tue, 12 Nov 2019 06:22:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 159411800D63;
        Tue, 12 Nov 2019 11:22:02 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF8B561F58;
        Tue, 12 Nov 2019 11:21:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id xACBLwIp017787;
        Tue, 12 Nov 2019 06:21:58 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id xACBLwbZ017783;
        Tue, 12 Nov 2019 06:21:58 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Nov 2019 06:21:57 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Daniel Wagner <dwagner@suse.de>
cc:     Mike Snitzer <msnitzer@redhat.com>, Scott Wood <swood@redhat.com>,
        dm-devel@redhat.com, Nikos Tsironis <ntsironis@arrikto.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: Re: [dm-devel] [PATCH 2/2] realtime: avoid BUG when the list is not
 locked
In-Reply-To: <20191112091044.lf7okijocx2wajhk@beryllium.lan>
Message-ID: <alpine.LRH.2.02.1911120621030.17732@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1911110853100.30532@file01.intranet.prod.int.rdu2.redhat.com> <20191112091044.lf7okijocx2wajhk@beryllium.lan>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: cUd-53U_ONOGSvs_zXHVfg-1
X-Mimecast-Spam-Score: 0
Content-Type: TEXT/PLAIN; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 12 Nov 2019, Daniel Wagner wrote:

> [cc: linux-user-rt, Thomas and Sebastian]
>=20
> On Mon, Nov 11, 2019 at 08:59:44AM -0500, Mikulas Patocka wrote:
> > list_bl.h would crash with BUG() if we used it without locking.=20
> > dm-snapshot uses its own locking on readltime kernels, so to avoid this=
=20
> > BUG, we must set LIST_BL_LOCKMASK =3D 0.
> >=20
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >=20
> > Index: linux-rt-devel/include/linux/list_bl.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-rt-devel.orig/include/linux/list_bl.h=092019-11-07 14:01:51.0=
00000000 +0100
> > +++ linux-rt-devel/include/linux/list_bl.h=092019-11-08 10:12:49.000000=
000 +0100
> > @@ -19,7 +19,7 @@
> >   * some fast and compact auxiliary data.
> >   */
> > =20
> > -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> > +#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !define=
d(CONFIG_PREEMPT_RT_BASE)
>=20
> CONFIG_PREEMPT_RT_BASE is only available in the out of tree -rt patch
> set, therefore I assume it's not for mainline, right?

Yes - this is intended to be applied to the realtime patchset.

Mikulas

> >  #define LIST_BL_LOCKMASK=091UL
> >  #else
> >  #define LIST_BL_LOCKMASK=090UL
> > @@ -161,9 +161,6 @@ static inline void hlist_bl_lock(struct
> >  =09bit_spin_lock(0, (unsigned long *)b);
> >  #else
> >  =09raw_spin_lock(&b->lock);
> > -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> > -=09__set_bit(0, (unsigned long *)b);
> > -#endif
> >  #endif
> >  }
> > =20
> > @@ -172,9 +169,6 @@ static inline void hlist_bl_unlock(struc
> >  #ifndef CONFIG_PREEMPT_RT_BASE
> >  =09__bit_spin_unlock(0, (unsigned long *)b);
> >  #else
> > -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> > -=09__clear_bit(0, (unsigned long *)b);
> > -#endif
> >  =09raw_spin_unlock(&b->lock);
> >  #endif
> >  }
> >=20
> > --
> > dm-devel mailing list
> > dm-devel@redhat.com
> > https://www.redhat.com/mailman/listinfo/dm-devel
> >=20
>=20
> Thanks,
> Daniel
>=20

