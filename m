From: Bhavesh Davda <bhavesh@vmware.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance
 tracking
Date: Tue, 13 Nov 2012 15:48:21 -0800 (PST)
Message-ID: <1982684838.49197680.1352850501878.JavaMail.root@vmware.com>
References: <50A2DAA0.2010105@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
To: frank rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:57019 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752146Ab2KMXsZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2012 18:48:25 -0500
In-Reply-To: <50A2DAA0.2010105@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Frank,

I apologize I didn't have a chance to review your proposed modifications to my patch.

I had looked at your proposal to introduce a '-g' option (for lack of a better letter) instead of piggy-backing on the '-h' option, and I completely agree with that approach.

It would be very handy to specify, for example, '-h 50 -g 1000' to capture and print the 1000 outliers beyond 50 us to get a good sense of any patterns hidden in the outliers.

If John has already accepted my proposed patches, do you want to propose your changes on top of that as a separate patch now?

Thanks for your review, and your excellent suggestion to make this feature even more useful.

--
Bhavesh Davda

----- Original Message -----
> From: "Frank Rowand" <frank.rowand@am.sony.com>
> To: "Bhavesh Davda" <bhavesh@vmware.com>, "John Kacur" <jkacur@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Sent: Tuesday, November 13, 2012 3:41:20 PM
> Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
> 
> On 10/25/12 14:36, Frank Rowand wrote:
> > On 10/16/12 10:02, Bhavesh Davda wrote:
> >> From: Bhavesh Davda <bhavesh@vmware.com>
> >>
> >> Add feature to cyclictest histogram mode to track cycle counts
> >> every time a
> >> sample overflows the histogram limit. This should help identify if
> >> there is a
> >> timing pattern to jitters in cyclictest runs.
> >>
> >> Example output (with -h 10):
> >>  ...
> >>  Histogram Overflows: 00001 00007 00000 00009 00004 00007 00000
> >>  00001
> >>  Histogram Overflow at cycle number:
> >>  Thread 0: 09964
> >>  Thread 1: 00000 00004 00006 00008 00010 09962 11594
> >>  Thread 2:
> >>  Thread 3: 01169 04698 06782 09033 10299 11561 21517 28734 29532
> >>  Thread 4: 11574 11580 11583 11586
> >>  Thread 5: 00020 09448 13954 14954 18954 20587 24973
> >>  Thread 6:
> >>  Thread 7: 18950
> >>  ...
> >>
> >> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
> > 
> > My comments up to "--" are not meant to be part of the header of
> > the
> > following patch.
> > 
> > I am including the following patch as my review of the patch I am
> > replying to.  If the following patch is incorporated into the
> > reviewed patch, then you can add my:
> > 
> >   Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
> >   Tested-by: Frank Rowand <frank.rowand@am.sony.com>
> > 
> > to the combined patch.
> 
> < snip >
> 
> Bhavesh,
> 
> I never saw I reply to my suggestions.  Unfortunately John took my
> reviewed-by for your white space patch and applied it to your
> "cyclictest: histogram overflow instance tracking" patch, without
> my suggestions, and released it in v0.85 rt-tests.
> 
> So...., any thoughts about the suggestions in the email that
> this one is responding to?  And also any thoughts about my
> second email in the series (I'll forward that one again to
> you).
> 
> -Frank
> 
> 
