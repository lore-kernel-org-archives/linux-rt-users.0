From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/4] Android: clean up the bypass ifdeffery
Date: Wed, 7 Oct 2015 13:55:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510071355190.14006@riemann>
References: <1444122503-8112-1-git-send-email-haustad@cisco.com> <1444122503-8112-3-git-send-email-haustad@cisco.com> <alpine.LFD.2.20.1510071231260.14006@riemann> <20151007111424.GA21765@laethe.rd.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33365 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbJGLzx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2015 07:55:53 -0400
Received: by wiclk2 with SMTP id lk2so209500610wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Oct 2015 04:55:52 -0700 (PDT)
In-Reply-To: <20151007111424.GA21765@laethe.rd.cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 7 Oct 2015, Henrik Austad wrote:

> On Wed, Oct 07, 2015 at 12:34:11PM +0200, John Kacur wrote:
> > 
> > 
> > On Tue, 6 Oct 2015, Henrik Austad wrote:
> > 
> > > 88af643971b9 (android: adjust target for android) introduced some really
> > > ugly ifdefs to avoid calling into pthread_barrier_wait and
> > > pthread_barrier_init.
> > > 
> > > This patch attempts to coalesce this into a single place and let the
> > > compiler handle the linking so that cyclictest.c is untouched by evil
> > > ifdefs.
> > > 
> > > Compiled and tested on:
> > > - x86_64 (v3.13 kernel)
> > > - tilegx (v3.10 kernel)
> > > - arm64 android (v3.10 kernel)
> > > 
> > > Signed-off-by: Henrik Austad <haustad@cisco.com>
> > > Cc: Clark Williams <williams@redhat.com>
> > > Cc: John Kacur <jkacur@redhat.com>
> > > ---
> > >  Makefile                    |  2 +-
> > >  include/bionic.h            | 32 ++++++++++++++++++++++++++++++++
> > >  src/arch/bionic/Makefile    |  4 +---
> > >  src/cyclictest/cyclictest.c | 25 +++----------------------
> > >  4 files changed, 37 insertions(+), 26 deletions(-)
> > >  create mode 100644 include/bionic.h
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index 2d20ea4..24ef8fe 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -22,7 +22,7 @@ bindir  ?= $(prefix)/bin
> > >  mandir	?= $(prefix)/share/man
> > >  srcdir	?= $(prefix)/src
> > >  
> > > -CFLAGS ?= -Wall -Wno-nonnull
> > > +CFLAGS ?= -Wall -Wno-nonnull -Iinclude/
> > >  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
> > 
> > We already have an include dir. Why aren't you using it?
> > If you think it would be cleaner to create your own include dir, you at 
> > least have to put it some where in the src dir
> 
> You're right!
> 
> moving it to src/include/ now, do you want a new patch right away, or shall 
> I wait for v0.96-devel before submitting?
> 
> 
> -- 
> Henrik Austad
> TIPBU Eng

Let's take our time and get it right, so wait for v0.96-devel

Thanks

John
