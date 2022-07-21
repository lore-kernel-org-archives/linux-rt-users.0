Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4285EC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Jul 2022 13:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiGUNIS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiGUNHc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Jul 2022 09:07:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5EC85F83
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Jul 2022 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658408805;
        bh=aMGT4bQp+Yg2KFTtLto6zb+TYYYwJR/WgX5TxgQFdb0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=SolL+k7qgkdXYXHHXlBpXeW4CkCEjYI11S71LTOnqRRvc6smKot66UR4/t1oFzA6K
         AS8E6FMx8miMgrw7BZAx1EgDlhV9d+lHQHua+hPSZ3Z6IAOt19BpvtGHVwrqZw6FSi
         /3iR121z7rJrZfYbJg1sDl9syL7WXfveFW5XKPVc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.106]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79yG-1nR7l3358G-017SNI; Thu, 21
 Jul 2022 15:06:45 +0200
Message-ID: <daf9b4678af9a121ba85f30b04f1335b44639433.camel@gmx.de>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
From:   Mike Galbraith <efault@gmx.de>
To:     John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Date:   Thu, 21 Jul 2022 15:06:45 +0200
In-Reply-To: <87tu8a16bm.fsf@jogness.linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
         <YrV4795StT13AUC+@linutronix.de>
         <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
         <YrWPiwtk0kAWxXI9@linutronix.de> <87wnd616ds.fsf@jogness.linutronix.de>
         <87tu8a16bm.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hxNg/54lH8k3Xk2VWCE6s2ryl5nwXuLLADJGnFrueQK5hKqt0o5
 LHzBdD+FSU2KFeJHN1vcUgVxJlNeG0cWKcY2TkBqiqYsDZXLDnF8PNjPwk639G/eEERga1e
 QRl3CAyU+v7OAZzLCxZO4t5WYy8cixaFNH/TVGoff8bb4n9sIioLqP/A7NQiw6U12Dp9+CD
 +wOUI3db3dQHlf5lofBvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uhBIRgkFR6c=:DX58kzbmF/IsjOyEpIFy1/
 1Wo4AfbZMF4VVuZyB25MqNwtCdjm3wU2w2KEr25zXiZu+0cjTRQQ3a4Nh93LKICe6TmF4fj2B
 cXNgR7AAvNoc07K/7PWM/i7lkgw41lUwvRQ1d6mmDh7gqi1+oKHklJbDCCKk0Pm3kDKKiRIrf
 +jnDrSjzeYLUaWJdFedjQuZCZwMT0abqlX0da/iH85W4WnhM9bPOIySPtfti9+vR7ylOXgVnK
 HTYOZPaCepRpkm1TM+F2UZxhFFTj9p92mv1wHDTpXwzOhq21oQB7jFgHodYxUi97+eqErcDni
 +71aqoWWHCUZEsRYHBhLdl1FG8n9MRat6qcTUD7YKxxogWBPykodHwcdrNo/vrMqP2btCDsSl
 3H1Q4oIFvjt60STGoVMJfBPkCPzXIj7OD6xhjxHz/dv+OxUl12VyYHlEkeDfo4jmQ5QnyKkVb
 gy0NKzvZOdARWXIajhABbhzo5cl/Zk9XBSzUfnhXiahLPVCVxWFuvT11FyWIMm9qsWzF2Gj8u
 TkmxjInKTYBXJeWL7/3lMxitjB5F0JixT+porgYBNM4oWHsoAA8tTW1Ievsq7qPmDzyGvRCWN
 zeFbjg/hH3ak9q/Zfg9usYd2N0TPJt4h4LYsX4AerMydrgpuUY2vJBGLqdjb2iaPzRUQcWCCN
 DpaHxGrVuQqaL31tpMtttwOhRGiMgifgRxMbRFWziCDDUeteq170kE2EwZprTdMmtorUDsv78
 NZAxj5j3Uble+3xoYmM+rJ2ippyTz85FvkJjQoviZ0GDv3fA9y0Vud6TPngm2jUx/9q/GT/wO
 zfcQlNzSDCuo1+Sh7Zql/ycQ3cWKzSjgBOXsJqDLruDwRyYQQ8NZlMlTFNgGhAb13W3NkthV+
 UX176cjEFuZ9pJIIZyPO+IlDaK+nA4Z0Nw40KyMyOeEdwgjER0MmfPLi8PYkZfkprqgxly/TT
 X46da8ruNoioErwk29TW4922XSg0BhSToIDYKxQN2R0yRvmnaK5KHoo250wOiOq0cKnYYGA2n
 CHh62+GdYEkJ+IvCnDKQYSG7wBhkxzAveKGhExqEkqksZV4gFcB4vYZgf86eguYu+tJ2pc+EY
 QhKZq2PSfQH925cEVjCopgYhcLjcjD9W2mNCnCKQiPFALJx+V1eyL0LxA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2022-06-24 at 16:37 +0206, John Ogness wrote:
> On 2022-06-24, John Ogness <john.ogness@linutronix.de> wrote:
> > As to this the actual problem reported in this thread, I believe
> > this
> > patch solves it:
> >
> > https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com
>
> There was a cleaner v2 later in the thread:
>
> https://lore.kernel.org/lkml/20220609123319.17576-1-Jason@zx2c4.com

That's in tip, but pulling my bandaid off...

[    3.903338] BUG: sleeping function called from invalid context at kerne=
l/locking/spinlock_rt.c:46
[    3.903340] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 389,=
 name: systemd-udevd
[    3.903340] preempt_count: 0, expected: 0
[    3.903341] RCU nest depth: 1, expected: 1
[    3.903342] CPU: 0 PID: 389 Comm: systemd-udevd Tainted: G            E=
     5.19.0.g96ff3a1-tip-rt #8 3a0ec7519629dbce1c881d809a8600cfad8358ca
[    3.903344] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[    3.903345] Call Trace:
[    3.903346]  <TASK>
[    3.903347]  dump_stack_lvl+0x44/0x5c
[    3.903352]  ? migrate_disable+0x37/0xa0
[    3.903354]  __might_resched+0x171/0x1c0
[    3.903357]  rt_spin_lock+0x2d/0x70
[    3.903361]  crng_make_state+0x80/0x1d0
[    3.903364]  _get_random_bytes.part.15+0x4e/0x120
[    3.903366]  ? nvkm_vmm_iter.constprop.11+0x311/0x860 [nouveau 9c7d46b6=
4ad6b15f254390d4ef3bd03268a3030d]
[    3.903449]  ? nvkm_vmm_sparse_unref_ptes+0x80/0x80 [nouveau 9c7d46b64a=
d6b15f254390d4ef3bd03268a3030d]
[    3.903518]  ? gf100_vmm_pgt_sgl+0x230/0x230 [nouveau 9c7d46b64ad6b15f2=
54390d4ef3bd03268a3030d]
[    3.903588]  default_pointer+0x2a0/0x2d0
[    3.903591]  vsnprintf+0x35e/0x4c0
[    3.903593]  ? gf100_gr_object_new+0x2b/0x70 [nouveau 9c7d46b64ad6b15f2=
54390d4ef3bd03268a3030d]
[    3.903669]  va_format.isra.16+0x6e/0xa0
[    3.903670]  vsnprintf+0x35e/0x4c0
[    3.903673]  vprintk_store+0x140/0x540

Bandaid:

printk: fix RT vprintk_store() might sleep splat

RT can't call vsnprintf() with IRQs disabled, so disable migration
and move the printk_enter_irqsave() call down to where it's needed.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/printk/printk.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

=2D-- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2277,8 +2277,7 @@ int vprintk_store(int facility, int leve
 	int ret =3D 0;
 	u64 ts_nsec;

-	if (!printk_enter_irqsave(recursion_ptr, irqflags))
-		return 0;
+	migrate_disable();

 	/*
 	 * Since the duration of printk() can vary depending on the message
@@ -2313,6 +2312,11 @@ int vprintk_store(int facility, int leve
 	if (dev_info)
 		flags |=3D LOG_NEWLINE;

+	if (!printk_enter_irqsave(recursion_ptr, irqflags)) {
+		migrate_enable();
+		return 0;
+	}
+
 	if (flags & LOG_CONT) {
 		prb_rec_init_wr(&r, reserve_size);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
@@ -2369,6 +2373,7 @@ int vprintk_store(int facility, int leve
 	ret =3D text_len + trunc_msg_len;
 out:
 	printk_exit_irqrestore(recursion_ptr, irqflags);
+	migrate_enable();
 	return ret;
 }


