From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Mon, 5 Feb 2007 10:02:58 +0100
Message-ID: <20070205090258.GA442@elte.hu>
References: <20070205065636.GA1652@elte.hu> <87wt2xdksl.fsf@depni.sinp.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:48412 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbXBEJzg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Feb 2007 04:55:36 -0500
Content-Disposition: inline
In-Reply-To: <87wt2xdksl.fsf@depni.sinp.msu.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Serge Belyshev <belyshev@depni.sinp.msu.ru> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > i have released the v2.6.20-rt1 kernel, which can be downloaded from 
> > the usual place:
> 
> I did not find tarball with split patches there. Could you please make 
> it available somewhere via http or ftp?

it basically consists of the -hrt queue, the GTOD queue (both are 
available in -mm) plus the rest of -rt in a mostly monolithic fashion. I 
dont really want to post it in a queue form because most of the time 
it's not bisectable, etc. It's really an internal thing - i do my 
development on the full tree, so that's the primary source form anyway.

	Ingo
