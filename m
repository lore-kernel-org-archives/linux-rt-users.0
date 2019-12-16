Return-Path: <SRS0=aCPW=2H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0E2C43603
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Dec 2019 03:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69F6206E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Dec 2019 03:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg/Bv0Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLQDf1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:35:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24290 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbfLQDf0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Dec 2019 22:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576553725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmMjkohQcr4zZA7rYlo+cdoxbamsa0pcjMglzLFiziY=;
        b=cg/Bv0Ac/LnM1vrj6oJMOSt9PLSrFnVS2zFXWL99vMnRpMZCZEQyU9cOzRLDkgGwDOnvTE
        y7SWZ12u+WmQxJ60c7jhonsGAvJF+0RmYqFxQInFwU/PSn05hNEYNoxmgNidUixBTD3l8p
        wB2LWCVjd0DuzGx7/WMF2RFkPaGoqbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-ofNXmEqlNFG1vQR4gwGkRA-1; Mon, 16 Dec 2019 22:35:22 -0500
X-MC-Unique: ofNXmEqlNFG1vQR4gwGkRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100BADBA3;
        Tue, 17 Dec 2019 03:35:21 +0000 (UTC)
Received: from amt.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C964710018FF;
        Tue, 17 Dec 2019 03:35:20 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id D0AB810266B;
        Mon, 16 Dec 2019 19:14:45 -0200 (BRST)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id xBGLEgqV003513;
        Mon, 16 Dec 2019 19:14:42 -0200
Date:   Mon, 16 Dec 2019 19:14:41 -0200
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Kacur <jkacur@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
        Clark Williams <williams@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick
 also for all !x86 archs
Message-ID: <20191216211440.GB778@amt.cnet>
References: <20191208210625.5999-1-ukleinek@debian.org>
 <20191212174604.xa6p46zhhii7qrhw@linutronix.de>
 <alpine.LFD.2.21.1912131550270.7507@planxty>
 <20191213230256.GA20494@amt.cnet>
 <20191216153449.sfxptmlyfthoianp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216153449.sfxptmlyfthoianp@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Dec 16, 2019 at 04:34:49PM +0100, Sebastian Andrzej Siewior wrote=
:
> On 2019-12-13 21:02:56 [-0200], Marcelo Tosatti wrote:
> > > > That freq. script reports here:
> > > > |1555.184 1566.269 1566.498 1560.055 1593.149 1568.185 1583.807 1=
599.096 2574.546 2572.408 2573.849 2583.862 2619.402 1825.680 1847.264 18=
70.318 2552.102 1570.552 1589.650 1595.813 1590.253 1573.834 1589.438 159=
9.439 1770.963 1786.370 1814.918 1811.936 1828.277 1850.905 1861.976 1792=
.809
> > > >=20
> > > > I guess I pick one=E2=80=A6
> > > >=20
> > > > Could someone please figure out the actual difference of clock_ge=
ttime()
> > > > vs rdtsc() so we know how important it is. Based on its current
> > > > implementation, if memmove() takes >1sec then it ends up undetect=
ed
> > > > because only the ns of the timestamp are considered for.
> >=20
> > /* Program parameters:
> >  * max_queue_len: maximum latency allowed, in nanoseconds (int).
> >  * cycles_per_packet: number of cycles to process one packet (int).
> >  * mpps(million-packet-per-sec): million packets per second (float).
> >  * tsc_freq_mhz: TSC frequency in MHz, as measured by TSC PIT
> >  * calibration=20
> >  * (search for "Detected XXX MHz processor" in dmesg, and use the
> >  * integer part).
> >  */
> >=20
> > So you have to pass it "processor frequency" (you can change the name=
s,=20
> > its TSC but thats x86 specific). The script grabs the processor
> > frequency (so you have to adjust that the script to ARM).
> >=20
> > And thats it. Please replace tsc_mhz -> processor_freq.
>=20
> So the script reports the freq. from 1555.184 Mhz to 2574.546 Mhz.
> And I doubt the numbers remain steady on today's x86 even with
> gov=3Dperformance.
> However, I asked for the frequency to be used on !x86 given the code we
> have. It was fixed in hurry and you would have to use 1000 so that the
> math keeps working.
> Then I asked how much benefit of this complicated TSC calculation vs
> clock_gettime() has.
> I tried to use it myself but after 30secs I saw no output, it just ate
> 100% and it seemed to do nothing. So I gave up.

Then the simulated queue size was not exceeded, accordingly to
the parameters you specified:

* max_queue_len: maximum latency allowed, in nanoseconds (int).
* cycles_per_packet: number of cycles to process one packet (int).
* mpps(million-packet-per-sec): million packets per second (float).

If you increase mpps or increase cycles_per_packet (or both),=20
or decrease max_queue_len, it should fail.

Do you see that?

