From: Henrik Austad <haustad@cisco.com>
Subject: Re: [PATCH 5/6] Makefile: add librttest to rt-migrate-test
Date: Tue, 22 Sep 2015 12:06:26 +0200
Message-ID: <20150922100626.GA6938@laethe.rd.cisco.com>
References: <1442849248-573-1-git-send-email-haustad@cisco.com>
 <1442849248-573-6-git-send-email-haustad@cisco.com>
 <alpine.LFD.2.20.1509212151560.12009@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org, Josh Cartwright <joshc@ni.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:32070 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529AbbIVKSQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Sep 2015 06:18:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1509212151560.12009@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 21, 2015 at 09:52:55PM +0200, John Kacur wrote:
> 
> 
> On Mon, 21 Sep 2015, Henrik Austad wrote:
> 
> > linker must be able to resolve reference to err_msg_n properly
> > 
> >    rt-migrate-test.c:(.text+0x1ff): undefined reference to `err_msg_n'
> > 
> > Signed-off-by: Henrik Austad <haustad@cisco.com>
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index fcf20ce..66de743 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -87,8 +87,8 @@ hwlatdetect:  src/hwlatdetect/hwlatdetect.py
> >  	chmod +x src/hwlatdetect/hwlatdetect.py
> >  	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
> >  
> > -rt-migrate-test: rt-migrate-test.o
> > -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
> > +rt-migrate-test: rt-migrate-test.o librttest.a
> > +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> >  
> >  ptsematest: ptsematest.o librttest.a
> >  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
> > -- 
> 
> Ah, I see, this patch fixes the compile error that the previous patch 
> introduces. So, you at least need to reorder them.
> 
> I'm accepting this patch for now, but I think some time is necessary to 
> review the previous patch.

Yep, I'll see if I can clean it up and make sure I catch all instances of 
warnings etc. It should have been applied *before* the "remove 
warnings"-patch.

> Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks though!

-- 
Henrik Austad
TIPBU Eng
Cisco Systems Norway
