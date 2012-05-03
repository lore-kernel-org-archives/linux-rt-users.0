From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] rt-tests: printf format compile warning
Date: Fri, 4 May 2012 00:37:27 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205040035440.3952@tycho>
References: <4FA2E120.1020909@am.sony.com> <4FA2F514.5070104@linux.intel.com> <20120503162633.788367b0@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463806542-2031043708-1336084653=:3952"
Cc: Darren Hart <dvhart@linux.intel.com>, frank.rowand@am.sony.com,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	jkacur@redhat.com
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47705 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab2ECWhs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 18:37:48 -0400
Received: by wgbdr13 with SMTP id dr13so2178993wgb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 03 May 2012 15:37:47 -0700 (PDT)
In-Reply-To: <20120503162633.788367b0@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806542-2031043708-1336084653=:3952
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT



On Thu, 3 May 2012, Clark Williams wrote:

> On Thu, 03 May 2012 14:13:56 -0700
> Darren Hart <dvhart@linux.intel.com> wrote:
> 
> > 
> > 
> > On 05/03/2012 12:48 PM, Frank Rowand wrote:
> > > 
> > > V2: use type casting instead of ugly constant in format string
> > > 
> > > 
> > > Fix printf format string to fix compile warning for ARM 32 bit target.
> > > 
> > 
> > Oh much better. :-)
> > 
> > > Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> > > ---
> > >  src/cyclictest/cyclictest.c |    2 	1 +	1 -	0 !
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Index: b/src/cyclictest/cyclictest.c
> > > ===================================================================
> > > --- a/src/cyclictest/cyclictest.c
> > > +++ b/src/cyclictest/cyclictest.c
> > > @@ -1575,7 +1575,7 @@ int main(int argc, char **argv)
> > >  		print_tids(parameters, num_threads);
> > >  		if (break_thread_id) {
> > >  			printf("# Break thread: %d\n", break_thread_id);
> > > -			printf("# Break value: %lu\n", break_thread_value);
> > > +			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
> > >  		}
> > >  	}
> > >  	
> > > 
> > 
> >
> 
> Yes, I like this better. I pulled the original and applied this.

Well, I really hate the C99 macros too, they're uglier than sin. But, you 
want to fix a compiler error on 32-bit by creating one on 64-bits? What 
are you guys smoking?

NAK

The above patch creates the following error on 64-bit
src/cyclictest/cyclictest.c:1564:4: warning: format ¡%llu¢ expects 
argument of type ¡long long unsigned int¢, but argument 2 has type 
¡uint64_t¢ [-Wformat]

---1463806542-2031043708-1336084653=:3952--
