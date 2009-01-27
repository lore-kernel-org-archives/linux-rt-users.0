From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Mon, 26 Jan 2009 21:23:45 -0500
Message-ID: <75b66ecd0901261823o72339347kfa70d6e54f61af00@mail.gmail.com>
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
Received: from rv-out-0506.google.com ([209.85.198.234]:16692 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbZA0CXq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Jan 2009 21:23:46 -0500
In-Reply-To: <1232992272.19862.3.camel@londonpacket.bos.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 26, 2009 at 12:51 PM, Jon Masters <jcm@redhat.com> wrote:
> On Sun, 2009-01-25 at 14:52 -0800, Mike Kravetz wrote:
>
>> Any reason why you could not do SMI detection in user level code running
>> at the highest RT priority?
>
> Yeah. I had some suggestions about that already...the problem with that
> is that you can't know whether measured latencies are due to SMIs /or/
> other kernel latencies - maybe there's a bug or other problem? I really
> want to be able to say to vendors "nope, it's definitely your problem".

Can't you do this with a known good version of the -rt kernel and the
latency tracer in full RT preempt mode?  SMI induced latency will show
up in the trace as long delays in random code paths where kernel
induced latency can be ruled out.

Lee
