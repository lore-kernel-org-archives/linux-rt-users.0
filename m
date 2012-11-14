From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
Date: Wed, 14 Nov 2012 01:09:22 +0100
Message-ID: <CAONaPpHVRb6Uw8=6di1R5+ah7LPa8ztypYCoObAf25pfj2ajnA@mail.gmail.com>
References: <1801453376.49209988.1352851403071.JavaMail.root@vmware.com>
	<1772255055.49210331.1352851461293.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org,
	frank rowand <frank.rowand@am.sony.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46340 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab2KNAJX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2012 19:09:23 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8086121oag.19
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Nov 2012 16:09:22 -0800 (PST)
In-Reply-To: <1772255055.49210331.1352851461293.JavaMail.root@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 14, 2012 at 1:04 AM, Bhavesh Davda <bhavesh@vmware.com> wrote:
> Okay, Frank's response raced with mine. Since Frank is not super motivated to submit a patch with his proposed changes to my patch, I'll do so.
>

Ummm, ok, this is sounding a little condescending. When people review
your patch, this is a gift they gave you which they did not need to.
It means they found your patch interesting enough to suggest how to
make it better. Adding an option to turn it on, is trivial, I believe,
the important point that Frank said is

"One further thought...  The histogram overflow cycle report shows
what cycle the overflow occurred in, not the actual time.  Adding
the merged for all threads cycle times works because the histogram
turns off the "different intervals for different threads" option:

                if (!histogram) /* same interval on CPUs */
                        interval += distance;

but if that ever changes then cycle is not a useful value to be
reporting.

So it seems like it would be useful to convert cycle to a time
in the report.  This is something that would have to be done
anyway in post processing when trying to make use of the report."

The motivation should belong to you. You should be proud that we
thought your ideas were important and good enough to incorporate into
the software and to review and comment on it. Careful there!

Thanks

John
