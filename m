From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Fri, 23 Jan 2009 21:33:37 -0500
Message-ID: <75b66ecd0901231833j2fda4554sb0f47457ab838566@mail.gmail.com>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Jon Masters <jcm@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:27107 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbZAXCdi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Jan 2009 21:33:38 -0500
In-Reply-To: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 23, 2009 at 5:55 PM, Jon Masters <jcm@redhat.com> wrote:
> Here's a simple SMI detector we've been playing around with internally.
> In case anyone wants to play with it, and especially help clean it up :)
>
> SMI events are particularly unhelpful on Real Time systems because we
> effectively have the CPU stolen from under us. We can't prevent this
> easily without BIOS vendors/system vendor co-operation, but we can help
> to diagnose and log that these are occuring...which can be very helpful
> too.
>

FYI the RTAI project has a patch to allow disabling of SMI:

https://listas.upv.es/pipermail/rtlinuxgpl/2007-April/000609.html

Lee
