Return-Path: <SRS0=kQBB=2D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4932DC00454
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 23:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107AC214D8
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 23:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaPuX1mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLMXDV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:03:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57286 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbfLMXDU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Dec 2019 18:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576278198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+s6UwVq0DdmtVohz1L5zRylWMNVheQu2YU+51jYczKA=;
        b=FaPuX1mDB4t+n6hSFCc+ioi61ut9h127AOiVSW7O6ad+Tv2D7iseOsNcjspMTykM7iRogA
        xmvDjtSJe455GZkk2KQaqNrx5ybhhEt6fpBJd9SxTUK/0NDI3E0XD22TguvuLzDkkkISP5
        cQkb564QAnAOumWTHR0Yr53o5V04NdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-bXPUBW-xO92yTSOPLMw3UQ-1; Fri, 13 Dec 2019 18:03:16 -0500
X-MC-Unique: bXPUBW-xO92yTSOPLMw3UQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C415E800D4E;
        Fri, 13 Dec 2019 23:03:15 +0000 (UTC)
Received: from amt.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A7CC10013A7;
        Fri, 13 Dec 2019 23:03:15 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 7799C100F3B;
        Fri, 13 Dec 2019 21:02:59 -0200 (BRST)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id xBDN2u1u022686;
        Fri, 13 Dec 2019 21:02:56 -0200
Date:   Fri, 13 Dec 2019 21:02:56 -0200
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
        Clark Williams <williams@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick
 also for all !x86 archs
Message-ID: <20191213230256.GA20494@amt.cnet>
References: <20191208210625.5999-1-ukleinek@debian.org>
 <20191212174604.xa6p46zhhii7qrhw@linutronix.de>
 <alpine.LFD.2.21.1912131550270.7507@planxty>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1912131550270.7507@planxty>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Dec 13, 2019 at 03:54:48PM +0100, John Kacur wrote:
>=20
>=20
> On Thu, 12 Dec 2019, Sebastian Andrzej Siewior wrote:
>=20
> > On 2019-12-08 22:06:25 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> > > This fixes a build error on arm64, mips*, ppc and several others
> > > ---
> > >  src/queuelat/queuelat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> > > index cccb50ef0cc4..98346f346f82 100644
> > > --- a/src/queuelat/queuelat.c
> > > +++ b/src/queuelat/queuelat.c
> > > @@ -283,7 +283,7 @@ static inline unsigned long long __rdtscll(void=
)
> > > =20
> > >  #define gettick(val) do { (val) =3D __rdtscll(); } while (0)
> > > =20
> > > -#elif defined __arm__
> > > +#else
> >=20
> > Did actually anyone look at the code? I somehow missed the queuelat
> > thingy completely. Now that I look I think I need further assistance=E2=
=80=A6
> >=20
> > So what I select as frequency for the !x86 case? And why.
> >=20
> > That freq. script reports here:
> > |1555.184 1566.269 1566.498 1560.055 1593.149 1568.185 1583.807 1599.=
096 2574.546 2572.408 2573.849 2583.862 2619.402 1825.680 1847.264 1870.3=
18 2552.102 1570.552 1589.650 1595.813 1590.253 1573.834 1589.438 1599.43=
9 1770.963 1786.370 1814.918 1811.936 1828.277 1850.905 1861.976 1792.809
> >=20
> > I guess I pick one=E2=80=A6
> >=20
> > Could someone please figure out the actual difference of clock_gettim=
e()
> > vs rdtsc() so we know how important it is. Based on its current
> > implementation, if memmove() takes >1sec then it ends up undetected
> > because only the ns of the timestamp are considered for.

/* Program parameters:
 * max_queue_len: maximum latency allowed, in nanoseconds (int).
 * cycles_per_packet: number of cycles to process one packet (int).
 * mpps(million-packet-per-sec): million packets per second (float).
 * tsc_freq_mhz: TSC frequency in MHz, as measured by TSC PIT
 * calibration=20
 * (search for "Detected XXX MHz processor" in dmesg, and use the
 * integer part).
 */

So you have to pass it "processor frequency" (you can change the names,=20
its TSC but thats x86 specific). The script grabs the processor
frequency (so you have to adjust that the script to ARM).

And thats it. Please replace tsc_mhz -> processor_freq.



