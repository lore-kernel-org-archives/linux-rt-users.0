Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3343C4741F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 07:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748392080D
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 07:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aaSBXC8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbgKDHm6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:42:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:42385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDHm6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 02:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604475758;
        bh=BVK0qslWs4eh+9VxmukAHWfu/UJGdfJZRyuedwiAwrY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aaSBXC8bQHgF3Hb6U3FWYjZwDkz6UsKIr3sAxcSV4eRPFS8zXVs+YRYgTJiwiywsq
         HdRYLUaG4WV2UtoiquNs2HK9SeQ4niYyRGguWtgdI3XMaQfkJSsBajDnPRnDqCY9Vo
         3jYs7gqQJf7CifjMZlafNgn3PgwWBNOWaX8q+yRM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.80]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1kgVld1flT-007UXA; Wed, 04
 Nov 2020 08:42:38 +0100
Message-ID: <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de>
Subject: Re: BUG_ON(!newowner) in fixup_pi_state_owner()
From:   Mike Galbraith <efault@gmx.de>
To:     Gratian Crisan <gratian.crisan@ni.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed, 04 Nov 2020 08:42:36 +0100
In-Reply-To: <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com>
         <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iU4vDL9MUhMTGUXWJ4e1rT7hD5VTd8KbKyZcJZz7OqA1HI4i9ZX
 CsKoK1o5aL9K/22h4mx9sh945ITXt9dVX/FDsa+FhsODoymHOXfAXMTzzQ0wp2ccgIrYw08
 owOjB3Gj0ZvfpLAsBme5NzXZp9sijOe/UWw+lCkHDFlL4kWFtv4SRnEVC3crbPwhH6OSSC9
 qNy+Bsyxs89xdi1UL9VyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/BkHvbh99PQ=:xIJWas2soeUe8xa4m9uGtU
 dbC7CvA9E5jF6vyoE5lcmrVsAT3E6zJu2kmpq/HngYNN0kG3UazOMKxNiSu0nezH65SQQykWj
 Wbmg0VNivsQD2ZMCha4O9w9wcQ0Fyt7Pku2RIY0XFt+XU9lxp3ncs0TI3eEGttwO8cyoic0Aq
 5x9PyFVSmjpGSiGoRW1QoQhIQJBuePLiIzutPW1Exuo98qB9Y7ZJAZETpvROf2JKUcO+tL9q3
 9+nR8I+dmhzfprNocHPE/KlZutZcIfIoebojw0EYRBb5axr4dRg7gX0ygYsQ8c0BiHaKCYgML
 Thpw61TPXR1czLGqV9OTq4rh2Y5gPJFfIqbqTKECeEV8Wefmy4vb/MLoO1diC0p/RAJsRwMRE
 O++Qjxvn2+ZtAaqopgILDazWOSmd4EqyK7VfpCiCtpFbW9uzTmYYcO38+D72Yx1ktPnJhYlkN
 VuqCMiJgBVEj5JhR34cZKruDSX2CHFh+d8sguhr22ugWVGuSSpWhux6RSQXO7T7rwPMCQKGct
 pjbDCjbh9ZBOpXELyB1lTJcc4IJdSfprLlTAETmz0bvzHY0mGVrvZMAmRgQe9IUndh4yFgMru
 3g5KmZjAGHmd5ppzXfYsGoWZWUqAtrPRbdB9WTo/gEkxcbEZMxBRx7SLmgYDOKs4rU+oNZYhw
 WGFCH4QaqzD+qmvr6sAR2EuLZ2Dj18oE5HVtECAVfkqj4H43SzYMhFVHp3an+aZ7lRMxlg0PI
 hgKrftBhMEGXTnyS+g5FE2SpJfuqY8MuEFW1+XgiLirw/IJmhQB9CoiqoGAqSH4m2+uhxLmC5
 r3+sogjpoFFwrIOX/wAkYr8li/6hjIMRK4UlB24QzL5wFvJFQMy9h7DiZ8fDIGtA4XBD/ufjz
 YwonV3Mv1R3WRKLeEWFQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-11-04 at 01:56 +0100, Mike Galbraith wrote:
> On Tue, 2020-11-03 at 17:31 -0600, Gratian Crisan wrote:
> > Hi all,
> >
> > I apologize for waking up the futex demons (and replying to my own
> > email), but ...
> >
> > Gratian Crisan writes:
> > >
> > > Brandon and I have been debugging a nasty race that leads to
> > > BUG_ON(!newowner) in fixup_pi_state_owner() in futex.c. So far
> > > we've only been able to reproduce the issue on 4.9.y-rt kernels.
> > > We are still testing if this is a problem for later RT branches.
> >
> > I was able to reproduce the BUG_ON(!newowner) in fixup_pi_state_owner(=
)
> > with a 5.10.0-rc1-rt1 kernel (currently testing 5.10.0-rc2-rt4).
>
> My box says it's generic.

=2D--
 kernel/futex.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

=2D-- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2383,7 +2383,18 @@ static int fixup_pi_state_owner(u32 __us
 		 * Since we just failed the trylock; there must be an owner.
 		 */
 		newowner =3D rt_mutex_owner(&pi_state->pi_mutex);
-		BUG_ON(!newowner);
+
+		/*
+		 * Why? Because I know what I'm doing with these beasts?  Nope,
+		 * but what the hell, a busy restart loop let f_boosted become
+		 * owner, so go for it. Box still boots, works, no longer makes
+		 * boom with fbomb_v2, and as an added bonus, didn't even blow
+		 * futextests all up.  Maybe it'll help... or not, we'll see.
+		 */
+		if (unlikely(!newowner)) {
+			err =3D -EAGAIN;
+			goto handle_err;
+		}
 	} else {
 		WARN_ON_ONCE(argowner !=3D current);
 		if (oldowner =3D=3D current) {


