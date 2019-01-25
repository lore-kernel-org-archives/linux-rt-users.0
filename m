Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45763 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXOa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Jan 2019 18:14:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so8080439lfa.12
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jan 2019 15:14:28 -0800 (PST)
MIME-Version: 1.0
References: <D5D6254030DBC644B6EE58B333BFBB1EA7C440AB@ORSMSX101.amr.corp.intel.com>
 <D5D6254030DBC644B6EE58B333BFBB1EA7C44112@ORSMSX101.amr.corp.intel.com> <D5D6254030DBC644B6EE58B333BFBB1EA86D6207@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <D5D6254030DBC644B6EE58B333BFBB1EA86D6207@ORSMSX122.amr.corp.intel.com>
From: Arve Barsnes <arve.barsnes@gmail.com>
Date: Sat, 26 Jan 2019 00:14:16 +0100
Message-ID: <CAJjrzcXsY87RVbcv0Nb-mzB0gX4mqD35uCr0H5Uk+PNnOzX_JQ@mail.gmail.com>
Subject: Re: ETA for 4.19rt-stable patch set?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Fri, 25 Jan 2019 at 22:03, Hindman, Gavin <gavin.hindman@intel.com> wrote:
>
> bump
>
> >-----Original Message-----
> >From: linux-rt-users-owner@vger.kernel.org <linux-rt-users-
> >owner@vger.kernel.org> On Behalf Of Hindman, Gavin
> >Sent: Wednesday, January 09, 2019 9:09 AM
> >To: 'linux-rt-users' <linux-rt-users@vger.kernel.org>
> >Subject: ETA for 4.19rt-stable patch set?
> >
> >We have a number of customers starting to productize on top of the 4.19LTS
> >for next-gen platforms, I'm sure others are in the same position - any
> >estimate on when we might see 4.19rt-stable?

I might be far off here, but I assume rt-stable is just a name put on
the rt-kernels older than the current that are still maintained. In
other words, nothing special about it, and it will probably appear
once a new kernel series gets rt patch sets. It's the 4.19-series that
is LTS, there is nothing special about rt patches on the older series
as far as I know.

Cheers,
Arve
