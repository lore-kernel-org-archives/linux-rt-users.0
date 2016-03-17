From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH 2/4] rt-migrate-test: fix return code
Date: Thu, 17 Mar 2016 09:25:36 -0400
Message-ID: <20160317092536.4d0d7e09@redhat.com>
References: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
	<1456346981-24032-3-git-send-email-lcapitulino@redhat.com>
	<alpine.LFD.2.20.1603162312320.16977@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60236 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932614AbcCQNZj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 09:25:39 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 60D7E8050D
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 13:25:39 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603162312320.16977@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 16 Mar 2016 23:14:10 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> 
> 
> On Wed, 24 Feb 2016, Luiz Capitulino wrote:
> 
> > Change both return codes for the stop == true case:
> > 
> >  * For failures, use exit(1) as exit(-1) is wrong
> >    (it actually becomes 255 in the shell)
> > 
> >  * For success, use exit(2) instead of exit(1) as
> >    exit(1) is usually used for errors
> > 
> > This should preserve the requirement of allowing
> > shell script while loops to break when Ctrl-C is hit.
> > 
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > ---
> >  src/rt-migrate-test/rt-migrate-test.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> > index fc6fd81..6e8acc2 100644
> > --- a/src/rt-migrate-test/rt-migrate-test.c
> > +++ b/src/rt-migrate-test/rt-migrate-test.c
> > @@ -594,9 +594,9 @@ int main (int argc, char **argv)
> >  		 * loop know to break.
> >  		 */
> >  		if (check < 0)
> > -			exit(-1);
> > -		else
> >  			exit(1);
> > +		else
> > +			exit(2);
> >  	}
> >  	if (check < 0)
> >  		exit(-1);
> > -- 
> > 2.1.0
> > 
> > --
> 
> You can change the failure status from -1 to 1 if you wish, this is the 
> normal value for EXIT_FAILURE
> 
> However the normal value for EXIT_SUCCESS is 0, so please do not change 
> that.

I'm not changing it. I'm maintaining the protocol used by rt-migrate-test:

        /*
         * We use this test in bash while loops
         * So if we hit Ctrl-C then let the while
         * loop know to break.
         */
