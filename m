From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 24/34] signaltest: remove unused ARRAY_SIZE macro
Date: Thu, 8 Jun 2017 16:28:55 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1706081628290.5309@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-25-tommi.t.rantala@nokia.com> <alpine.LFD.2.20.1705221843320.7915@riemann> <ced54112-4dc0-5f27-ff5c-be27609087d0@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33085 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdFHO25 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2017 10:28:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id x3so7592977wme.0
        for <linux-rt-users@vger.kernel.org>; Thu, 08 Jun 2017 07:28:57 -0700 (PDT)
In-Reply-To: <ced54112-4dc0-5f27-ff5c-be27609087d0@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 5 Jun 2017, Tommi Rantala wrote:

> On 22.05.2017 19:44, John Kacur wrote:
> > On Mon, 22 May 2017, Tommi Rantala wrote:
> > 
> > > --- a/src/signaltest/signaltest.c
> > > +++ b/src/signaltest/signaltest.c
> > > @@ -30,8 +30,6 @@
> > >   #include "error.h"
> > >   #include "rt-utils.h"
> > >   
> > > -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > > -
> > >   /* Ugly, but .... */
> > >   #define gettid() syscall(__NR_gettid)
> > >   
> > > -- 
> > 
> > NAK
> > 
> > You're right, it could be removed, but it's not really causing in harm
> > either. I'm going to leave it in for now.
> > 
> > Thanks
> > 
> > John
> 
> Hi John,
> 
> OK, dropped the patch also from the github repo.
> 
> Any comments to the rest of the patches?
> 

There're coming, give me a little more time to parse them.

Thanks

John
