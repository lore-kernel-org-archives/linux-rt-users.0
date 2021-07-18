Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA1C636CA
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Jul 2021 08:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24897610CB
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Jul 2021 08:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhGRIPD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:15:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:35335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhGRIPD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Jul 2021 04:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626595914;
        bh=KV34qVRDRX4HzUGJlfF/hgIY5lowDhF96SMQf1+Mm08=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=idCSCnf/ub1eZxKKucRvicU10txuYZf3/3mZuihzKsZlB8APLrJ8NXnjWaTvD/g68
         HehBJVGaKBhKWW/Sheei185N9Ww5AvOOhdgz+9cARCECOt8juBBDxyitvSKWR1Dpzi
         D3SMCUEWs0Xq70cHR6GW+ElVXx2elTPKDMlNKwvU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1m6gam1QZm-002qXJ; Sun, 18
 Jul 2021 10:11:54 +0200
Message-ID: <f15287cff6a212029bdf603e51892b2d295736f2.camel@gmx.de>
Subject: Re: [patch] v2 mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sun, 18 Jul 2021 10:11:53 +0200
In-Reply-To: <725fe90b-4918-321e-ca88-6166bec0c131@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
         <725fe90b-4918-321e-ca88-6166bec0c131@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:anPAfTyiWoxwHinUd+8Y9MBiMVv4AZmtbHgVZnc69YUIVPh8GRC
 qC8svcEpfxPmzEbE948h3OV8JefJo92wypvbdt7V5Q5q9gahF9PRASQIji+57hStV4ESFgX
 8zS1a5MJM3NJiSpcxti4+5XCpiofqdbBe5xBwNOth4EfzpYBaNp0uOIEAmTAJlcfvA9VmXW
 tIOQzgiE4lMxw4XyZvxtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SsdtYme0vY4=:yhuUJp+gz/yTGxYSOfA1us
 LVt7CzSm9emZmMbDXcmWzM8JsUKoBO37CmJVd+pDrgDR8cAOwV7/18U4bJz8l/IGust9qUt7E
 bi3AZLhz8TdiGVSCrFmEZRH30ouRaXjJbPJd9vJrkBn8jo1PYIqaLme6ImT1ukAjSDSSzh0GV
 ADTSbdI3SUlaANlYiOyNmo5TIAbbc9jjy/qBpzb6SyNnu8f2PROF1Pe5eJREG8e3/gJMIsGlE
 oC01AcFMdPwkLMCFmE+jWhPos0j86az1Otf9oaevU2oUlpqTM/JkMXxMnblEceSH4kn8+ReLV
 Vd6f9SJXGnGnnh3vzNlgzJgTWFGMMBLB35wp83ndD7r9Ghm5eReSn77YahkAGLKq8HIV+dQoC
 7KeW1tUhqCxY3VsG/2+yyfWy6nWRx0GEouCSfCLLibSctdwUudjzJPMYywRzaqorne4F9OCvP
 9oOfX/f73ECxKbct9ZUK50oexWB/Alta0iIvv5F9SihtZp0NBanm27U5yeyrT+zAhdIXImRwP
 o3AmjKPssIyp0GQW0OOorWgGNpx3gd9L0dSvjpyaRpm0RtjTESHuzdFKsTybkIHujcIjL2XEn
 teSPm3SXH6CT9BLJpTHUSTtBKUhxnkyiXT/tDESoxzwl84VifmAOQoa7PSnZLRqNSlmxLDjFf
 sCRRrgez72pFD3qfJsM4wOvKhBAD7w7MS0lKZv3GvXbEZfNXM+7Q34cqvL4JEk7A7f1GH98IQ
 u/B9aJlQ9IKwkU1nhSSjJ7iwnuj06I9bVHUR52tcN3/NcWG4mTWqp3lkln2Hyp/X9ZN/XQFEH
 oDb3F0YfJtiN+p1Kqg8VnrkzRKkfzGM5U6XzqswhnPQDWnNvi2knsqPd9ZMyLySj7d/OBe5n2
 nmaHQ6F+nCFGoQcg1apExy4ONdWjYKTMYWVkKuRSXuCqY+ixJQHEt4rrL+tttm2dWJVBPUXNl
 dt8nUKwPKeD9/gXvR1rX8TZ3Knwha/qG3cZqVQlyMz0+RHE8+Pr+iAfe3L9XiPavVLQh/zwWJ
 NIpoD1eeKXmQLi4vP6x9dbVE6V8YVuHAX/oKqtFs9wUQyx52aKavA+GK712OhF6Niou/3gMzr
 ooxxdJZuZID79FjccuP3hfGiKU2+f1ecYMS
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2021-07-18 at 09:58 +0200, Vlastimil Babka wrote:
> On 7/17/21 4:58 PM, Mike Galbraith wrote:
> > On Thu, 2021-07-15 at 18:34 +0200, Mike Galbraith wrote:
> > > Greetings crickets,
> > >
> > > Methinks he problem is the hole these patches opened only for RT.
> > >
> > > static void put_cpu_partial(struct kmem_cache *s, struct page
> > > *page,
> > > int drain)
> > > {
> > > #ifdef CONFIG_SLUB_CPU_PARTIAL
> > > 	struct page *oldpage;
> > > 	int pages;
> > > 	int pobjects;
> > >
> > > 	slub_get_cpu_ptr(s->cpu_slab);
> > >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > Bah, I'm tired of waiting to see what if anything mm folks do about
> > this little bugger, so I'm gonna step on it my damn self and be
> > done
> > with it.  Fly or die little patchlet.
>
> Sorry, Mike. Got some badly timed sickness. Will check ASAP.

Hey, no apology necessary.  I have no way of knowing what's going on
behind the scenes, but I also didn't like the notion of just walking
away from a busted thing, so given the silence, figured it's better to
post the working something I've got (wart and all) than to let the bug
go unchallenged.  (take that damn bug.. pokes it with sharp stick;)

	-Mike

