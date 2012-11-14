From: Bhavesh Davda <bhavesh@vmware.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance
 tracking
Date: Tue, 13 Nov 2012 16:17:32 -0800 (PST)
Message-ID: <186127385.49218418.1352852252623.JavaMail.root@vmware.com>
References: <CAONaPpHVRb6Uw8=6di1R5+ah7LPa8ztypYCoObAf25pfj2ajnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	frank rowand <frank.rowand@am.sony.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:54971 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755999Ab2KNARe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2012 19:17:34 -0500
In-Reply-To: <CAONaPpHVRb6Uw8=6di1R5+ah7LPa8ztypYCoObAf25pfj2ajnA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

No disrespect intended, sorry if it came across as such.

And as I'm no cyclictest expert, I didn't quite catch the subtleties of Frank's important observation. I'll need to study the cyclictest code more carefully to really grok that, which I will.

Stay tuned for a patch...

--
Bhavesh Davda

----- Original Message -----
> From: "John Kacur" <jkacur@redhat.com>
> To: "Bhavesh Davda" <bhavesh@vmware.com>
> Cc: linux-rt-users@vger.kernel.org, "frank rowand" <frank.rowand@am.sony.com>
> Sent: Tuesday, November 13, 2012 4:09:22 PM
> Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
> 
> On Wed, Nov 14, 2012 at 1:04 AM, Bhavesh Davda <bhavesh@vmware.com>
> wrote:
> > Okay, Frank's response raced with mine. Since Frank is not super
> > motivated to submit a patch with his proposed changes to my patch,
> > I'll do so.
> >
> 
> Ummm, ok, this is sounding a little condescending. When people review
> your patch, this is a gift they gave you which they did not need to.
> It means they found your patch interesting enough to suggest how to
> make it better. Adding an option to turn it on, is trivial, I
> believe,
> the important point that Frank said is
> 
> "One further thought...  The histogram overflow cycle report shows
> what cycle the overflow occurred in, not the actual time.  Adding
> the merged for all threads cycle times works because the histogram
> turns off the "different intervals for different threads" option:
> 
>                 if (!histogram) /* same interval on CPUs */
>                         interval += distance;
> 
> but if that ever changes then cycle is not a useful value to be
> reporting.
> 
> So it seems like it would be useful to convert cycle to a time
> in the report.  This is something that would have to be done
> anyway in post processing when trying to make use of the report."
> 
> The motivation should belong to you. You should be proud that we
> thought your ideas were important and good enough to incorporate into
> the software and to review and comment on it. Careful there!
> 
> Thanks
> 
> John
> 
