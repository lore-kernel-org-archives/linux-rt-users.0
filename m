From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH 3/4] cyclictest: move tracemark_fd handling to its own
 function
Date: Tue, 22 Mar 2016 10:42:33 -0400
Message-ID: <20160322104233.2b0698ae@redhat.com>
References: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com>
	<1458239417-31089-4-git-send-email-lcapitulino@redhat.com>
	<alpine.LFD.2.20.1603221534380.10687@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757881AbcCVOmg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 10:42:36 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 6F69B8F22C
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 14:42:36 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603221534380.10687@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 22 Mar 2016 15:35:55 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> 
> 
> On Thu, 17 Mar 2016, Luiz Capitulino wrote:
> 
> > A function added by the next commit will want to call
> > this code too.
> > 
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 4e80831..65f2aec 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -532,6 +532,19 @@ static void debugfs_prepare(void)
> >  		fileprefix = procfileprefix;
> >  }
> >  
> > +static void open_tracemark_fd(void)
> > +{
> > +	char path[MAX_PATH];
> > +
> > +	if (tracemark_fd >= 0)
> > +		return;
> > +
> > +	sprintf(path, "%s/%s", fileprefix, "trace_marker");
> > +	tracemark_fd = open(path, O_WRONLY);
> > +	if (tracemark_fd < 0)
> > +		warn("unable to open trace_marker file: %s\n", path);
> > +}
> > +
> >  static void setup_tracer(void)
> >  {
> >  	if (!tracelimit || notrace)
> > @@ -647,14 +660,7 @@ static void setup_tracer(void)
> >  				fatal("unable to open %s for tracing", path);
> >  		}
> >  
> > -		/* open the tracemark file descriptor */
> > -		if (tracemark_fd == -1) {
> > -			char path[MAX_PATH];
> > -			strcat(strcpy(path, fileprefix), "trace_marker");
> > -			if ((tracemark_fd = open(path, O_WRONLY)) == -1)
> > -				warn("unable to open trace_marker file: %s\n", path);
> > -		}
> > -
> > +		open_tracemark_fd();
> >  	} else {
> >  		setkernvar("trace_all_cpus", "1");
> >  		setkernvar("trace_freerunning", "1");
> > -- 
> > 2.1.0
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> But, once again, it didn't apply cleanly,

Yeah, I didn't know I had to use the devel branch. Do you want me
to re-send or did git solved the conflicts?

> and you should have included it
> with the next set off patches where it is required, because I was 
> scratching my head as to why I should include this until I looked there.

Which set of patches?
