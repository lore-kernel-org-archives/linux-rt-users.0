From: Michael Mueller <ss7box@gmail.com>
Subject: Re: RT_PREEMPT autodetection from user program
Date: Sun, 20 Jan 2013 07:43:45 -0500
Message-ID: <CA+zZMHFztDdHcbGxU4oUH1JwcWioYU3Q1ZawmrfBA9x8VszDDw@mail.gmail.com>
References: <97041258-E312-4163-96B2-9077EED68E0B@mah.priv.at>
	<50FBBDA8.5060605@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:49022 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3ATMtu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Jan 2013 07:49:50 -0500
Received: by mail-la0-f43.google.com with SMTP id ed20so728651lab.30
        for <linux-rt-users@vger.kernel.org>; Sun, 20 Jan 2013 04:49:48 -0800 (PST)
In-Reply-To: <50FBBDA8.5060605@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jan 20, 2013 at 4:49 AM, Stanislav Meduna <stano@meduna.org> wrote:
>
> On 20.01.2013 01:13, John Morris wrote:
>
> > LCNC drives machines that weigh many tons and spins
> > spindles at 24k RPM, so this is important!

> On 20.01.2013 01:49, Michael Haberler wrote:
>
> > A false positive on a vanilla kernel could be a safety hazard.
>
> If we are speaking safety here I'd say that you have to support
> specific version of kernel on specific hardware that _you_ have
> quality assured. Anything else is a recipe for

catastrophic failure.
