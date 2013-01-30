From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: white space cleanup
Date: Wed, 30 Jan 2013 18:00:49 +0100 (CET)
Message-ID: <alpine.LFD.2.03.1301301756450.4078@tycho>
References: <51072F6A.1050105@am.sony.com> <5107303E.3010208@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "jkacur@redhat.com" <jkacur@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Bhavesh Davda <bhavesh@vmware.com>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:35804 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387Ab3A3RA7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jan 2013 12:00:59 -0500
Received: by mail-ee0-f53.google.com with SMTP id e53so987716eek.40
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jan 2013 09:00:58 -0800 (PST)
In-Reply-To: <5107303E.3010208@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 28 Jan 2013, Frank Rowand wrote:

> On 01/28/13 18:09, Frank Rowand wrote:
> > Clean up cyclictest formatting:
> >   Change leading spaces to tabs.
> >   Align function parameters.
> >   Place type of function on same line as function name.
> > 
> > Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> > ---
> >  src/cyclictest/cyclictest.c |   43 	21 +	22 -	0 !
> >  1 file changed, 21 insertions(+), 22 deletions(-)
> > 
> 
> < snip >
> 
> The motivation of the white space clean up is so that future
> patches will not add white space damage.  Many editors will
> automatically copy the bad white space if a line immediately
> following is added.
> 
> I tried to not get carried away with other formatting clean
> up.  The alignment of function parameters was only a few
> locations and seemed in the spirit of white space clean up.
> 
> The "type of function name" fix was getting carried away, but
> there was only one instance so I don't feel too guilty.
> 

Okay, this is fine. Whitespace patches can be annoying though when they 
cause conflicts, I had to apply this before patches from Bhavesh Davda
but I understand your motivation.

Applied and in my devel repo to be pushed to Clark

Thanks
