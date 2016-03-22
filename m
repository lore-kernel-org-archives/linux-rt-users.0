From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH 1/3] rt-migrate-test: fix return code
Date: Tue, 22 Mar 2016 11:30:16 -0400
Message-ID: <20160322113016.185954e5@redhat.com>
References: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com>
	<1458239345-30892-2-git-send-email-lcapitulino@redhat.com>
	<alpine.LFD.2.20.1603221522050.10687@riemann>
	<20160322104737.1f09c4d8@redhat.com>
	<alpine.LFD.2.20.1603221559260.10687@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40625 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbcCVPaV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 11:30:21 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id E05CB711D0
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 15:30:19 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603221559260.10687@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 22 Mar 2016 15:59:50 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> 
> 
> On Tue, 22 Mar 2016, Luiz Capitulino wrote:
> 
> > On Tue, 22 Mar 2016 15:22:57 +0100 (CET)
> > John Kacur <jkacur@redhat.com> wrote:
> > 
> > > 
> > > 
> > > On Thu, 17 Mar 2016, Luiz Capitulino wrote:
> > > 
> > > > Change both return codes for the stop == true case:
> > > > 
> > > >  * For failures, use exit(1) as exit(-1) is wrong
> > > >    (it actually becomes 255 in the shell)
> > > > 
> > > >  * For success, use exit(2) instead of exit(1) as
> > > >    exit(1) is usually used for errors
> > > > 
> > > > This should preserve the requirement of allowing
> > > > shell script while loops to break when Ctrl-C is hit.
> > > > 
> > > > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > > > ---
> > > >  src/rt-migrate-test/rt-migrate-test.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> > > > index d7b68dd..1362404 100644
> > > > --- a/src/rt-migrate-test/rt-migrate-test.c
> > > > +++ b/src/rt-migrate-test/rt-migrate-test.c
> > > > @@ -599,9 +599,9 @@ int main (int argc, char **argv)
> > > >  		 * loop know to break.
> > > >  		 */
> > > >  		if (check < 0)
> > > > -			exit(-1);
> > > > -		else
> > > >  			exit(1);
> > > > +		else
> > > > +			exit(2);
> > > >  	}
> > > >  	if (check < 0)
> > > >  		exit(-1);
> > > > -- 
> > > > 2.1.0
> > > > 
> > > > --
> > > 
> > > NAK - I've already told you this is wrong
> > 
> > Right and wrong can be subjective concepts :)
> > 
> > > 0 is the normal value for exit_success, not 2
> > > you can change the failure from -1 to 1 if you wish
> > 
> > rt-migrate-test uses a different protocol as documented
> > in the code. If we change success to 0, we'll break this
> > protocol. Does it matter? I don't know, but I chose to
> > keep it.
> > 
> > Now, if this is a complicated matter, we can just skip this
> > patch.
> > --
> 
> Really not sure what you're talking about
> update your git repo and read the code again.

I'm looking at a638701a1899. Unless I grabbed the wrong branch
again, the code looks the same.

This is the block I'm referring to:

    if (stop) {
        /*
         * We use this test in bash while loops
         * So if we hit Ctrl-C then let the while
         * loop know to break.
         */
        if (check < 0)
            exit(-1);
        else
            exit(1);
    }

So, when Ctrl-C is hit by the user, stop=1 and we get here. Then,
two things may happen:

 1. check < 0: my understanding is that, this is the failure
    case. We do exit(-1). On Linux (and maybe most Unixes), this
    actually becomes 255 in the shell

 2. check >= 0: we do exit(1). This is the success case. According
    to the protocol, we return 1 to the shell to allow shell loops
    from breaking free
