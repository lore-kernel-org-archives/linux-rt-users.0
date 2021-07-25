Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3283CC4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 14:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF3360F39
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 14:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhGYN32 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 25 Jul 2021 09:29:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:53405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhGYN31 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 25 Jul 2021 09:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627222180;
        bh=mmtim8/hK95f4sW8me9LDCQ9SJOFR+pZxkZgqOm5BG8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=EFbAoT2H99gbs77j3ImjW1ztF6AOUmSvOiB65llW41WFSnYtfoKPRS5+Znlis19aF
         jCQdQx9D9WjTC+F/IbOFHhKejejLnJp8s/n632SopGnOCVTcNQWpR2xvVipljYcYue
         dlKld7OlKgFL40aB51VdxEYaHhvKKsBDpaY7I+dk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.136]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1ltJLM2iN2-00ELR8; Sun, 25
 Jul 2021 16:09:40 +0200
Message-ID: <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sun, 25 Jul 2021 16:09:39 +0200
In-Reply-To: <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
         <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
         <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
         <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
         <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
         <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YGGJLcKzpeJGaHWuDqQP3yCibcxjWlw9+ZWLo0/CAjpQtXO34LB
 oN4jgkvV6+w+wf1L+aCha/ntjoP5YebvYomgq0CU49Paop2Tai7JrXQ+pi6bu3koi7+uyaB
 47N8s5QtAr9ryR4We8/ZFuGyAWvt7rI2ZP3/P3ueLaTHM8d2aJPkiUZ2QYQXo5jp2FmqPgd
 TfvL9pkEJQ6OawzZczqrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2QJtQw+reLQ=:9v72PLUZTy37s9DytyylmT
 7Ns3Y2zCtI/RCJIW0RAcLF0fpsu8sTOJDYsh8a8MLdsh/KDzWAooVEoNXYMjAhdefpXSVYjOK
 0Ctjh9Inej1nKFuXc/xx6dA9tNTeBC2mL3fLzTE1Ef91RWFoXlN7ZH9UHasa1UJrgkJoKy8fJ
 EK7E3f511fDEULiVR+0irOv8T/3pzCY96F/k0/UAiPBMXDWCRXgKd+HNs+mNaiqzSGwj6T2Gm
 e0wnMxPZn90HxU3eBBxjXxczp24DQktpIq/h/4F/jEMyreGKCuJB57N+1WSAAlVS5YYgXlLh0
 b+uCJ37dzNIbp4cCKuhenh+wt9HxsH9ghtbHyja54JjrsEAAVptRL30r7NFyEf4DV+eNAfTVe
 FPSB8lrvm3wgjW+dO3z+anCaVOrNnIR3Oewa0yEhg+QX+CHiLKc3yz51uLH2OX73IvRiMNg0j
 ekDIp83O7OAdAcwRgRJ7h3gPQDz9QVasQOx9axlhTcIGOyXpwraj7V+k3hHJNGkYiNovFwpQu
 pnxMKMBPHG2fTcN8Q3fAC/TQDeJpXVjbiUrvPG4b59ZTpruAxXNlksnHUJAwGXFQTZcDzuKua
 L/pv4k0/0lMXxiCBbHy7nAj1xlfAqevcDzQ7MgJyKn+Hz0k9QTH/8xHommxnomth9X41Algtt
 /1uwubMI3j5PyZMbSHd02k8piBk62wWoJXJ1UDDgSKLB2Yy7OFAP9jzdyQ9242+/ztOBaIoSJ
 p89DfOn9rSpaVXkATy/KByFu4O1Ib9HsDdGtW3uNVsgB8r6IEh2Zwi/yHzSYs6KGIsb8UxvdM
 +Vop8VrYtPkcIKuYrf/YbXOlBmqqYHqKe9usw4FPojwMKsRS6Zg8x7AQIF8P3uj6RorNW14cB
 Mpt7JGS9rDLqPqO70Kq5beLHxciWvP3W+X9K5izetF8hGhgzyU86ZjmuUQgbmk4d1xNbALqMu
 vvDUrwomnUMcUzHpSixNSDVPCSjgI/as51HWILEdq8S3e2i+PgLILKK0MJxEqX09kaEuZK6wd
 c4nrtMxU+12Vqui2/YBouJORBU9FQimI3BRHPX0IPusN3LciD/xARfTknQM8hEj/v+9myCdOu
 TVeuDp0HUQ6oC3DfbAKE0SSdscNM38zF0qA
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-07-24 at 00:39 +0200, Vlastimil Babka wrote:
>
> If not, then I would expect this to work (I don't think they ever nest
> in the opposite order, also lockdep should tell us instead of
> -ENOBOOT?), but might be missing something...

Yeah, like #ifndef CONFIG_PREMPT_RT at the bottom of the loop that our
useless damn eyeballs auto-correct instead of reporting :)

	-Mike

