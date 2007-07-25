From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 08/15] use static libs for supportlibs
Date: Wed, 25 Jul 2007 08:49:59 -0700
Message-ID: <200707250849.59962.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <200707241359.05333.dvhltc@us.ibm.com> <20070724211419.GM1678@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:56922 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001AbXGYPuC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 11:50:02 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6PFpGNH010970
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 11:51:16 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6PFo1PK464556
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 11:50:01 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6PFo0rS016497
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 11:50:00 -0400
In-Reply-To: <20070724211419.GM1678@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 14:14:19 Robert Schwebel wrote:
> On Tue, Jul 24, 2007 at 01:59:05PM -0700, Darren Hart wrote:
> > We were trying to avoid libraries in a futile effort to keep the make
> > process simple.... ah well.  This doesn't complicate things at all
> > really it turns out, so I'm fine with it.
>
> That's why I made it static libs - that's simple and works without
> libtool.
>
> > > Note: the libs should really be renamed, because calling a local
> > > library "librt" is a very, very bad idea.
> >
> > Agreed.  We were thinking of changing it to librttest - any other
> > suggestions?
>
> Sounds good. You should also think about taking it out of include/ and
> put it into something like lib/ or libs/.

Agreed, they started out as just header files - but they evolved into the 
static libraries they are now - time to rename and move them indeed.

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
