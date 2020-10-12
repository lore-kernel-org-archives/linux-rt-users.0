Return-Path: <SRS0=LljW=DT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144FBC433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 08:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF18D2145D
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 08:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AaPfabCd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1x2dRRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgJLIVd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgJLIVc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 04:21:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF06EC0613CE;
        Mon, 12 Oct 2020 01:21:32 -0700 (PDT)
Date:   Mon, 12 Oct 2020 10:21:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602490891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oc6GxNvZyhzVd+sRQ9Lj/+rIXB/pm2oFr0J0wwuGklo=;
        b=AaPfabCd3W3r8sV3ghr//kbp8XY3foRNl/BjtxKdUcSW/7jKk5x3dwXzPzn/N2QevJ5FAr
        j4KmUq9KnbAmzve34Uolyp8WyejFF2t1oHtMbQt+WuFbxGD7LURYct+3p4hKquDgS4XLrr
        +FfJrP5PtLXIiCdq9scAwVG6j++nOs1Cro8YaRK1HeMgsU1DG+A3XQE3lXJwsRGSYXq+qT
        p0oqrUeQuRCkPbEQaVvhuoAnJ/iisoHh8kXuuJY43PlJQtGchTbmfSDW9/aJHdEPYVKRlD
        mKTDX75kZFboQrnAowFAMXtohQ2fENix9sCKNC7OL1EiZ7+0I7CIaABh+UtbyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602490891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oc6GxNvZyhzVd+sRQ9Lj/+rIXB/pm2oFr0J0wwuGklo=;
        b=U1x2dRRGH0h9hNdzp5x/VIgX+WDIWaZ6rACrBk1Ekkn0UzNwaCjOA/SOXkEvP/aO2rrhd3
        OSm00B2OiAt/+PAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Eelco Chaudron <echaudro@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com, atheurer@redhat.com
Subject: Re: [PATCH 5.9 RT] net: openvswitch: Fix using smp_processor_id() in
 preemptible code
Message-ID: <20201012082129.ocod2dlftwais65a@linutronix.de>
References: <20201009124759.592550-1-juri.lelli@redhat.com>
 <20201009154116.a4fcrrm7flxonidd@linutronix.de>
 <65BBD0B4-2A74-421A-BF81-357CD5F84747@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65BBD0B4-2A74-421A-BF81-357CD5F84747@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-12 10:14:42 [+0200], Eelco Chaudron wrote:
>=20
>=20
> On 9 Oct 2020, at 17:41, Sebastian Andrzej Siewior wrote:
>=20
> > On 2020-10-09 14:47:59 [+0200], Juri Lelli wrote:
> > > This happens because openvswitch/flow_table::flow_lookup() accesses
> > > per-cpu data while being preemptible (and migratable).
> > >=20
> > > Fix it by adding get/put_cpu_light(), so that, even if preempted, the
> > > task executing this code is not migrated (operation is also guarded
> > > by
> > > ovs_mutex mutex).
> >=20
> > This warning is not limited to PREEMPT_RT it also present upstream since
> > commit
> >    eac87c413bf97 ("net: openvswitch: reorder masks array based on
> > usage")
> >=20
> > You should be able to reproduce it there, too.
> > The path ovs_flow_tbl_lookup() -> flow_lookup() is guarded by ovs_lock()
> > I can't say that this true for
> >    ovs_vport_receive() -> ovs_dp_process_packet() ->
> >    ovs_flow_tbl_lookup_stats() -> flow_lookup()
> >=20
> > (means I don't know but it looks like coming from NAPI).
> >=20
> > Which means u64_stats_update_begin() could have two writers. This must
> > not happen.
> > There are two reader which do u64_stats_fetch_begin_irq(). Disabling
> > interrupts makes no sense since they perform cross-CPU access.
> >=20
> > -> You need to ensure that there is only one writer at a time.
> >=20
> > If mask_array gains a spinlock_t for writer protection then you can
> > acquire the lock prio grabbing ->masks_usage_cntr. But as of now there
> > is one `ma->syncp'.
>=20
> I=E2=80=99m not too familiar with the RT kernel, but in the none RT kerne=
l, this
> function is called in run to completion parts only, hence does not need a
> lock. Actually, this was designed in such a way that it does not need a l=
ock
> at all.

_no_ As explained above, this is not RT specific.
What guaranties that you don't have two flow_lookup() invocations on the
same CPU? You are using u64_stats_update_begin() which must not be
preempted. This means even if preemption is disabled you must not have
another invocation in BH context. This is due to the
write_seqcount_begin() in u64_stats_update_begin().
If preemption / CPU migration is not a problem in the above part, you
can use annotation to disable the warning that led to the warning. But
the u64_stats invocation looks still problematic.

> So maybe this needs a get_cpu() instead of the light variant in the RT ca=
se?

> //Eelco

Sebastian
