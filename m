Return-Path: <SRS0=SXCv=EB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2310BC388F9
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06662085B
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 19:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EnJhxJKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783358AbgJZTQF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:16:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:57401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783221AbgJZTQF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Oct 2020 15:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603739725;
        bh=52jZV+hgar8meUv7frV/fyzM7mQ0U5DFY1NWKhPggTQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=EnJhxJKQPuSXh7lixi6X/UKhi/ht13Zg5v/rvuQFKhT56Nszc4mAS1UO7zgxv70WK
         JVso3d7xEUvaBLwKFml4GbfIOqCRVQM2PGDcrtZheQfmXCoUG3jt9dXm/4F9QVGKKr
         ta81Gjfohbb+Cn/mQLdzzJaX90+1mbYTx+pMaP1E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.51.69]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1kRNKz2wPl-005s9Y; Mon, 26
 Oct 2020 20:15:24 +0100
Message-ID: <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
Subject: Re: kvm+nouveau induced lockdep  gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Mon, 26 Oct 2020 20:15:23 +0100
In-Reply-To: <20201026173107.quylcy6fgjvrqat6@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
         <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
         <20201023090108.5lunh4vqfpkllmap@linutronix.de>
         <20201024022236.19608-1-hdanton@sina.com>
         <20201024050000.8104-1-hdanton@sina.com>
         <20201026173107.quylcy6fgjvrqat6@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h2fpWdnodak2evkUSoMLFaQ15SXdRAny+od2n1CA1xkjjRMcDde
 7GApg72QlnT62qxt8dqau5208wtkgEoGeAPjPKNL3jv841rd8yV5HZrVFbFdOeK8k3uqE2l
 OWrkCTQ5bG02PlV9giTDVEhqzU5QXwUWXBLT1BSVnFi41O0Nl5ES7sLXydYkodXqHNE4sz2
 0OhtLV/NCR9redRqPEwUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PSU3dTUT/rA=:1zs+7DbJK461en5dlqbANA
 jntzxMsoQzmeWRPXQoKL3IiBTE4aIQWS6RKoASKv5quoW09Z7ELx++Blsi9zzp4NLECg8+0qS
 7LI317rjQeV//rneB5lXGZHrZoYVjGI1j+90TAxIrhrItN5SgoKuAkmlavwxYnS2wK/IayXJu
 4ocndhEHhNa0tqZyo00wP3b+hP/55QjIeCZhdNFGxrUhdWCWxT4YC6wSAXwXyJEmy+FkOfhuq
 Cxuq9pToB6xBeOtnwx0i0kyNqUEnx8LTiqOc4TwTCTQmJZBTb+4Ew2mcIRVSaxHG0IZZgAWr4
 YvjgM34WyhJ0zfDaliT3Xtuj6yZfWNu8bDKIfym0rwsaqB67ASENsIcKRQE+m4zOYXMkj2Bfx
 4NbcWT8mJ4x95t9UHDmsb1HtD6EUENki5t+JcVlgB6xTJbEbXYXR7+xcFMaIw2WAiHEJwjl13
 RhvcSKmq+hc/Scy+yvr+XQ1yOORCsCgWBMdbwla6Inv9DIp/P981V01SZ0esr1Kn2Qb5OQf3Y
 UaBu541YCWhFUPMwbgT1zVnB3b6AQD4DtHH6r0Xzi8yE0Yw7d3I2dI7p/LRMeNRXAyV9gywye
 /m7msqEiT1fvGE0wlCfro3K6oY+5GXG/+Y3K/bBhwPHMPL/Cixlg51T9JlGLur0atP9lQoEZW
 05r+dsZgzHqCyw3E5g3XKQN9iu2qyEnDDd66AZ5SrdayhxNLTYPe5pzqervZNAYIsKDMOBBd/
 0iTdS9MdQeJCGM7FhMdMq4bbSOx9abLHxtUA47lInTDKCEj5XTU3RBdEljBeE0ql+2G+J98dH
 aO9BXdVD+CiNSXCYsYHt1LxKokn2NqeSZzMEDqq/muepdkRqL19CuSUSxh39uxmtH2mn2jwuT
 TDxGX+I+eaXa+rQ8RL8Q==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-10-26 at 18:31 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-24 13:00:00 [+0800], Hillf Danton wrote:
> >
> > Hmm...curious how that word went into your mind. And when?
> > > [   30.457363]
> > >                other info that might help us debug this:
> > > [   30.457369]  Possible unsafe locking scenario:
> > >
> > > [   30.457375]        CPU0
> > > [   30.457378]        ----
> > > [   30.457381]   lock(&mgr->vm_lock);
> > > [   30.457386]   <Interrupt>
> > > [   30.457389]     lock(&mgr->vm_lock);
> > > [   30.457394]
> > >                 *** DEADLOCK ***
> > >
> > > <snips 999 lockdep lines and zillion ATOMIC_SLEEP gripes>
>
> The backtrace contained the "normal" vm_lock. What should follow is the
> backtrace of the in-softirq usage.
>
> >
> > Dunno if blocking softint is a right cure.
> >
> > --- a/drivers/gpu/drm/drm_vma_manager.c
> > +++ b/drivers/gpu/drm/drm_vma_manager.c
> > @@ -229,6 +229,7 @@ EXPORT_SYMBOL(drm_vma_offset_add);
> >  void drm_vma_offset_remove(struct drm_vma_offset_manager *mgr,
> >  			   struct drm_vma_offset_node *node)
> >  {
> > +	local_bh_disable();
>
> There is write_lock_bh(). However changing only one will produce the
> same backtrace somewhere else unless all other users already run BH
> disabled region.

Since there doesn't _seems_ to be a genuine deadlock lurking, I just
asked lockdep to please not log the annoying initialization time
chain.

=2D-- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
@@ -116,7 +116,17 @@ nvkm_pci_oneinit(struct nvkm_subdev *sub
 			return ret;
 	}

+	/*
+	 * Scheduler code taking cpuset_rwsem during irq thread initialization s=
ets
+	 * up a cpuset_rwsem vs mm->mmap_lock circular dependency gripe upon lat=
er
+	 * cpuset usage. It's harmless, tell lockdep there's nothing to see here=
.
+	 */
+	if (force_irqthreads)
+		lockdep_off();
 	ret =3D request_irq(pdev->irq, nvkm_pci_intr, IRQF_SHARED, "nvkm", pci);
+	if (force_irqthreads)
+		lockdep_on();
+
 	if (ret)
 		return ret;


