Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739BDC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50270610F8
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhHXLdr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:33:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:45671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235125AbhHXLdq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629804772;
        bh=j8/IO64BRHarBVkhsRI5BMN1oL+5kPRdCo5bmhyZcyA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=CAvIusrkPAqYR96NMnY761h6kQ9r4DCrfnsaQI4kTsbvi3g8wlb6yWClqo87WbRXV
         JdT5C7rYR++D52xK4v9sXnW5wMlcrpPrL9RzOLkcw1ENmP+Y3p9Ty+azp9SN3Thu7u
         uQcM+iGfK/uMdLcV+S19DS930RvKyypg+BdNkbh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDXz-1nASGv0ond-00ub67; Tue, 24
 Aug 2021 13:32:52 +0200
Message-ID: <62d6644affcc24daa5c39fdde582a2cc76a7cc2c.camel@gmx.de>
Subject: Re: [patch] mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 24 Aug 2021 13:32:45 +0200
In-Reply-To: <b8a39e05-696a-d459-c651-a3415bc09886@suse.cz>
References: <70cc66840bbd9446061fc40088575565d8d98e37.camel@gmx.de>
         <b8a39e05-696a-d459-c651-a3415bc09886@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TRqYh5SjR7NMJkTPYUtSBRuNCLe2nQf9Zu8fGpKwQDXlSzjC/DK
 Q0QAz8BdUD7OWD/6x9SG4tMSv0U88jCZsqdiuX5biASFkLdL7bsSmuiKclnvAFSpeAP8Pca
 97lbrrmJgDf9V8TZFOlaRyiIXpbv/Tjnr0ge0rTmkbrhDnNt4zRob1H2J9Bk56ymlomTtBF
 KVOF5HsbEAdduMv5QtI8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5n0JVTukwu8=:3WzWD7viyU3Ocg5pIJ0RGE
 rll2TFesFAZ8vtBgWQR3QOVizZ+57fqQfEP2nEDsX2F3u8+q+zR+2VCx/RF8Ck73rVoDS+jRF
 dRY1mZFyj4JcOHQd+fPEkl1fYindQ5iXtZBtU7EnqovLu/QsFTnwapD+OosOFaCN7ovhVj095
 X8UPI9w7wcLbexX7E9yKFtGsvJIrdZeB39RNNy/2a/lbVWWy25qivOwBLxYOk/ll7SBzMtDsZ
 SCp6H5yPYSWC9Z8blq3uZ1xZJc7LVc2N7PTFHtUQCwc89otLXBZXx3IhdDaE83s2lZTKL3h+L
 5WvzcA8at6z+2YluwHmRXRNQDS57ZVoS3VjF/z+p3jbo6je2fB0+dWZzEO4wryxhw9oIE5nfa
 iMy7YN+P/2XCESvTtWrzITcZoHHArskSTnLoemr3ybpJZ2ariDbp6HmHrMzksoBygWiMYjCCK
 i/gON7C5oBXRNd7DLkpLJppJARxLQeKazTaPVCpHGYP4Xfj2IOiFkt/8SYUc/Ye5MmC1otg4L
 K+mA14FtanTSSd1WedeCpZGsM2caaytnI0RbTXTeuI0M3VzOPLVrna/yf3yeKkHa5xTfKPm04
 CpgzDeCvBWvpBunRpzcJp/M6Dxy5kZyPUpvkxYGtB9xQAoQaQEmJ8GaBiN6JTY7VmPqmfPiED
 IPamM8PpK5m0TxUUt+IjX0fA2qp4YMNFIAHkNj/B1R0mXvFzkAbP7FR6/rtxHyrd4dvNov+Tq
 olUoTU1jvahpg4BJ3Zppu9+jIfEPc1oRYiKDcgnNhN4KouhKoudGjBlBObapqfzGO4gQrr3/+
 gtY0oA/fumw1cc019kqKmVbtD7cOtCFDuCNnf+nnQ2wVMwjYurHc0cw6xgzvZGFCTgK3b/At/
 vcCH/zxTQ+NkGTfFS5ZsWBdDWSq6YfyBzpaFEcqeUxo050jiSMhggkfwfIhN3zsEtSGWLsqa8
 PXkq2aoXJoiJXpEgIbItHxh9bnK9Taly5V80vpP3ryvsp0DYyQuWb7a9Dr1NGJWm2v1DK+kAc
 HEmuLG70o/5A4yfp/VUCJhApgpMJoRTo+gjdrr8djkNi7okvQCmpKZelkpJvi0cJ6aUOdt4U+
 wOR8bv00uN8eL+74KqR3vnpTGKRaliblzvy
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2021-08-24 at 13:14 +0200, Vlastimil Babka wrote:
> On 8/24/21 13:08, Mike Galbraith wrote:
> >
> > local_lock_t becoming a synonym of spinlock_t had consequences for
> > the RT
> > mods to zsmalloc, which were taking a mutex while holding a
> > local_lock,
> > inspiring a lockdep "BUG: Invalid wait context" gripe.
> >
> > Converting zsmalloc_handle.lock to a spinlock_t restored lockdep
> > silence.
> >
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
>
> BTW, does anyone really run zswap on a RT system?

(eek, oh hell no;) I only run ltp's zram tests to give box something
non-routine to do.

	-Mike

