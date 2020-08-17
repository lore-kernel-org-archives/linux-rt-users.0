Return-Path: <SRS0=mgec=B3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CBC433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 13:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C36220786
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 13:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPV8zIH7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XrcVTgUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHQNmF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgHQNlp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Aug 2020 09:41:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786BDC061359;
        Mon, 17 Aug 2020 06:41:15 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:41:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597671670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3bPb+Be6pafKwEQBFvSpZWJceorkqDy/T/jpI/cYYc=;
        b=LPV8zIH7ojDEvlwh4FItD/FhOn+ITBTQl8BS00MO2pmoWjvhq0HeIXJD27igEfDhRA0gU6
        tYcJYLc2S8tKvAVPJORsH7FCdoIKK735/G7ZDMgTbfYRtJpMKVLwkixVv8lqd8eBEzRrRU
        UfG6ZB1eq1rBUQQrblKC/sCNWWKTfwPAaiI7omBgFKdZmasVVqLdRT/3c+m7snLtBKwZeA
        UoaMbgwUSqZt471hfrY+uS0si9kdSqcZAEYT27PM7VxBWuBP0k/58R+7LgL3Zjz1IHB0Hi
        mRWYiGeixmjgNN8uNvGDpFdsqWBeHiu6PZ/BqhM3QZN7GyBJg68zvw5OC7KxmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597671670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3bPb+Be6pafKwEQBFvSpZWJceorkqDy/T/jpI/cYYc=;
        b=XrcVTgUcnRvwNtPs8ZqOYuE3QRHNg1fW3dkB11UwWhMm4+8DFZKdQW6KcfCyYVlilzupQq
        MtOkhNpeHlmJyHAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: Question on 5.4.55 merge into 5.4-rt
Message-ID: <20200817134109.hu73gjafbdb2n3rz@linutronix.de>
References: <20200814185421.74b1ddc8@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200814185421.74b1ddc8@oasis.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-14 18:54:21 [-0400], Steven Rostedt wrote:
>=20
> When merging 5.4.55 into 5.4-rt I hit the following conflict:
=E2=80=A6
>=20
> Where we are doing something slightly different. Placing the skb on the
> sd->tofree_queue and raising NET_RX_SOFTIQ instead.
>=20
> Now that the vanilla stable 5.4 kernel doesn't call kfree_skb() from
> irqs_disabled, can I safely revert this entire change?

Not if you mean dropping skbufhead-raw-lock.patch.

We can drop `tofree_queue' and everything related to it. We need to
keep the `raw_lock' and the `rps_lock()' hunks for
`sd->input_pkt_queue'. The other queue, `sd->process_queue', is
protected by local_bh_disable() so these hunks can be dropped in the
more recent RT versions with the re-written softirq code
(v5.0.19-rt10+).

> Is it safe to call kfree_skb() from local_bh_disable()?

of course it is.

> I'm assuming it is, but just want to clarify. I'll be continuing
> merging latest stable (with this revert), but please yell if you think
> it will break?
>
> Thanks!
>=20
> -- Steve

Sebastian
