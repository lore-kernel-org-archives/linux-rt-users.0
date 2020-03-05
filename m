Return-Path: <SRS0=I6ff=4W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F77C3F2CD
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267FA21556
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 13:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCENix convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:38:53 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55509 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgCENix (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Mar 2020 08:38:53 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-8-FRg9kPztOJKu46TlEY-bkw-1;
 Thu, 05 Mar 2020 13:38:49 +0000
X-MC-Unique: FRg9kPztOJKu46TlEY-bkw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 5 Mar 2020 13:38:48 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 5 Mar 2020 13:38:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'zanussi@kernel.org'" <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        "John Kacur" <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>
Subject: RE: [PATCH RT 21/23] sched: migrate_enable: Busy loop until the
 migration request is completed
Thread-Topic: [PATCH RT 21/23] sched: migrate_enable: Busy loop until the
 migration request is completed
Thread-Index: AQHV7XsS7F52Pb7Mok2qp7hxLysRG6g57Grw
Date:   Thu, 5 Mar 2020 13:38:48 +0000
Message-ID: <9003e4a9e5774ecfa377d218c71c2ad2@AcuMS.aculab.com>
References: <cover.1582814004.git.zanussi@kernel.org>
 <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
In-Reply-To: <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: zanussi@kernel.org
> Sent: 27 February 2020 14:34
> [ Upstream commit 140d7f54a5fff02898d2ca9802b39548bf7455f1 ]
> 
> If user task changes the CPU affinity mask of a running task it will
> dispatch migration request if the current CPU is no longer allowed. This
> might happen shortly before a task enters a migrate_disable() section.
> Upon leaving the migrate_disable() section, the task will notice that
> the current CPU is no longer allowed and will will dispatch its own
> migration request to move it off the current CPU.
> While invoking __schedule() the first migration request will be
> processed and the task returns on the "new" CPU with "arg.done = 0". Its
> own migration request will be processed shortly after and will result in
> memory corruption if the stack memory, designed for request, was used
> otherwise in the meantime.
> 
> Spin until the migration request has been processed if it was accepted.

What happens if the process changing the affinity mask is running
at a higher RT priority than that of the task being changed and
the new mask requires it run on the same cpu?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

