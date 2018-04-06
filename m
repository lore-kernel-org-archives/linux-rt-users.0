Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756347AbeDFOYe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Apr 2018 10:24:34 -0400
Date: Fri, 6 Apr 2018 09:24:32 -0500
From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest: duration flag not working with refresh on max
Message-ID: <20180406092432.112d53e2@tagon>
In-Reply-To: <TY1PR01MB1769F86BBD60A56D6F52D2B1F5BA0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <TY1PR01MB17696559983A8DBC77E83D59F5BB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
        <20180405125915.53222b0f@tagon>
        <TY1PR01MB1769F86BBD60A56D6F52D2B1F5BA0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@gmail.com>

On Fri, 6 Apr 2018 06:24:02 +0000
Phil Edworthy <phil.edworthy@renesas.com> wrote:

> Hi Clark,
> 
> On 05 April 2018 18:59 Clark Williams wrote:
> > On Thu, 5 Apr 2018 08:44:56 +0000 Phil Edworthy wrote:
> >   
> > > Hi,
> > >
> > > If I set the duration flag (e.g. -D 1h) and the refresh on max flag
> > > (-M), cyclictest doesn't stop after the specified duration. It doesn't
> > > matter how long the duration is.
> > >
> > > Does anyone else see this behaviour?
> > >
> > > Thanks
> > > Phil  
> > 
> > I tried with --duration == 2m, 10m and 1h with refresh_on_max set and it
> > worked for me.
> > 
> > What is your full command line?  
> cyclictest -m -S -p98 -i400 -M -D10s
> 
> I also tried this and it also doesn't stop:
> cyclictest -m -S -p98 -i400 -M --duration 10s
> 
> Thanks
> Phil

Ugh, both of those worked for me on a RHEL7 and a Fedora box. 

What version of cyclictest are you running?

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
