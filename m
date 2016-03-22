From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/3] rt-migrate-test: fix return code
Date: Tue, 22 Mar 2016 16:05:35 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603221605090.10687@riemann>
References: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com> <1458239345-30892-2-git-send-email-lcapitulino@redhat.com> <alpine.LFD.2.20.1603221522050.10687@riemann> <20160322104737.1f09c4d8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36097 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbcCVPFi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 11:05:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so30361301wml.3
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 08:05:38 -0700 (PDT)
In-Reply-To: <20160322104737.1f09c4d8@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 22 Mar 2016, Luiz Capitulino wrote:

> On Tue, 22 Mar 2016 15:22:57 +0100 (CET)
> John Kacur <jkacur@redhat.com> wrote:
> 
> > 
> > 
> > On Thu, 17 Mar 2016, Luiz Capitulino wrote:
> > 
> > > Change both return codes for the stop == true case:
> > > 
> > >  * For failures, use exit(1) as exit(-1) is wrong
> > >    (it actually becomes 255 in the shell)
> > > 
> > >  * For success, use exit(2) instead of exit(1) as
> > >    exit(1) is usually used for errors
> > > 
> > > This should preserve the requirement of allowing
> > > shell script while loops to break when Ctrl-C is hit.
> > > 
> > > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > > ---
> > >  src/rt-migrate-test/rt-migrate-test.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> > > index d7b68dd..1362404 100644
> > > --- a/src/rt-migrate-test/rt-migrate-test.c
> > > +++ b/src/rt-migrate-test/rt-migrate-test.c
> > > @@ -599,9 +599,9 @@ int main (int argc, char **argv)
> > >  		 * loop know to break.
> > >  		 */
> > >  		if (check < 0)
> > > -			exit(-1);
> > > -		else
> > >  			exit(1);
> > > +		else
> > > +			exit(2);
> > >  	}
> > >  	if (check < 0)
> > >  		exit(-1);
> > > -- 
> > > 2.1.0
> > > 
> > > --
> > 
> > NAK - I've already told you this is wrong
> 
> Right and wrong can be subjective concepts :)
> 

or they can be defined by POSIX> 
