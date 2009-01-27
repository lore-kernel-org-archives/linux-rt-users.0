From: Keith Mannthey <kmannth@gmail.com>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Mon, 26 Jan 2009 18:48:39 -0800
Message-ID: <a762e240901261848id9a6de3i81d3f6cef1d8139d@mail.gmail.com>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
	 <20090125225205.GA3783@monkey.beaverton.ibm.com>
	 <1232992272.19862.3.camel@londonpacket.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Jon Masters <jcm@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:19600 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbZA0Csq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Jan 2009 21:48:46 -0500
In-Reply-To: <1232992272.19862.3.camel@londonpacket.bos.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 26, 2009 at 9:51 AM, Jon Masters <jcm@redhat.com> wrote:
> On Sun, 2009-01-25 at 14:52 -0800, Mike Kravetz wrote:
>
>> Any reason why you could not do SMI detection in user level code running
>> at the highest RT priority?
>
> Yeah. I had some suggestions about that already...the problem with that
> is that you can't know whether measured latencies are due to SMIs /or/
> other kernel latencies - maybe there's a bug or other problem? I really
> want to be able to say to vendors "nope, it's definitely your problem".

While I agree it is tricky to sort out OS V. SMI issues it really
doesn't matter if
your SMI periods are less than your OS period.  If you OS blocks as long as
your SMI then it is hard to say for sure.

One class of SMI is periodic. Looking though latency data and looking for
periodic events might be handy.  Say if every X seconds you experience extra
latency you can pretty much bet that is an SMI.

Just had an interesting idea. Why not just boot Linux as far as early console
access and put the test loop in right then and there?

> So I think what'll end up happening is a user process for ease of
> deployment but something like smi_detector for advanced diagnostics. And
> then I just hope others will write tools like the one IBM already has
> that will turn off extraneous SMI generation :)

I will be sending out a RFC with our implementation.  On a few platforms the
firmware supports turning off all "non-fatal" SMIs.  There is a small driver
to interface with the BIOS and some userspace bits.

Thanks,
  Keith Mannthey
  LTC Real-Time
